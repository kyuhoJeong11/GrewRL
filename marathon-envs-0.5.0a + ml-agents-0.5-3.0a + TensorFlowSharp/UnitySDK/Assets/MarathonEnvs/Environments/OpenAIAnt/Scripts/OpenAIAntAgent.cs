using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using MLAgents;

public class OpenAIAntAgent : MarathonAgent
{
    private void Start()
    {
        StepRewardFunction = StepRewardAnt_PyBullet;
        //TerminateFunction = TerminateAnt_My;
        TerminateFunction = Goal1;

        InitCollectFunction();
    }

    public string terminateFunctionName;
    public Vector3 target;

    public UnityEngine.UI.Text debugText;
    public override void AgentReset()
    {
        try
        {
            torso.Clear();
            configurableJoints.Clear();
            collisionSensors.Clear();

            _hasValidModel = false;

            target = transform.position;
            target.x += 1000f;

            if (marathonSpawner == null)
                marathonSpawner = GetComponent<MarathonSpawner>();

            debugText.text = marathonSpawner.SetXml(marathonSpawner.legCount);
            base.AgentReset();

            if (torso.Count <= 0)
            {
                foreach (Transform child in transform)
                {
                    if (child.name.Contains("torso_geom")
                        //|| child.name.Contains("head") 
                        //|| child.name.Contains("tail")
                        )
                    {
                        torso.Add(child);
                    }
                }
            }

            Actions = new List<float>();
            for (int i = 0; i < MarathonJoints.Count; i++)
            {
                Actions.Add(0f);
            }

            beforeAngle = new float[MarathonJoints.Count];
        }
        catch (Exception e)
        {
            BodyParts["pelvis"] = GetComponentsInChildren<Rigidbody>().FirstOrDefault(x => x.name == "torso_geom");
            //throw;
        }

        // set to true this to show monitor while training
        Monitor.SetActive(true);

        //StepRewardFunction = StepRewardAnt101;
        //StepRewardFunction = StepRewardAnt_My;

        //TerminateFunction = TerminateAnt;

        ObservationsFunction = ObservationsDefault;

        BodyParts["pelvis"] = GetComponentsInChildren<Rigidbody>().FirstOrDefault(x => x.name == "torso_geom");
        SetupBodyParts();

        init_y = BodyParts["pelvis"].transform.position.y;

        Init_GoalList();
    }

    public override void AgentOnDone()
    {
    }

    float init_y;
    float[] beforeAngle;
    void ObservationsDefault()
    {
        var pelvis = BodyParts["pelvis"];
        #region origin
        //AddVectorObs(pelvis.velocity); //3
        //AddVectorObs(pelvis.transform.forward); // gyroscope //3
        //AddVectorObs(pelvis.transform.up); //3

        ////AddVectorObs(SensorIsInTouch); //xml ���� ��

        //for (int i = 0; i < collisionSensors.Count; i++)
        //    AddVectorObs(collisionSensors[i].isCollision);

        //JointRotations.ForEach(x => AddVectorObs(x)); //xml actuator �� * 4
        //AddVectorObs(JointVelocity); //xml actuator ��
        #endregion

        #region pybullet
        //if (collectStateList.Count <= 0)
        //{
        //    //more //8
        //    float torso_height = Mathf.Abs(pelvis.transform.position.y - init_y);
        //    AddVectorObs(torso_height);

        //    float self_walk_target_theta = Mathf.Atan2(target.z - pelvis.transform.position.z, target.x - pelvis.transform.position.x);
        //    float yaw = GetAngle(pelvis.transform.localEulerAngles.y) * Mathf.Deg2Rad;
        //    float angle_to_target = self_walk_target_theta - yaw;
        //    //print(self_walk_target_theta + ", " + yaw);
        //    float sin = Mathf.Sin(angle_to_target);
        //    float cos = Mathf.Cos(angle_to_target);
        //    //print(sin + ", " + cos);
        //    AddVectorObs(sin);
        //    AddVectorObs(cos);

        //    AddVectorObs(pelvis.velocity * 0.3f);

        //    float pitch = GetAngle(pelvis.transform.localEulerAngles.x) * Mathf.Deg2Rad;
        //    float roll = GetAngle(pelvis.transform.localEulerAngles.z) * Mathf.Deg2Rad;

        //    float clampedAngleX = Mathf.Clamp(pitch, -5f, 5f);
        //    //float clampedAngleY = Mathf.Clamp(yaw, -5f, 5f);
        //    float clampedAngleZ = Mathf.Clamp(roll, -5f, 5f);

        //    AddVectorObs(clampedAngleX);
        //    //AddVectorObs(clampedAngleY);
        //    AddVectorObs(clampedAngleZ);

        //    CollectJointAngle(0); //joint ����
        //    CollectJointAngularVelocity(0); //joint ���ӵ�
        //    CollectJointCollisionSensors(0); //feet_contact, ���� ���� ����
        //}
        #endregion

        #region CSONG
        for (int i = 0; i < isCollectList.Length; i++)
        {
            if (isCollectList[i])
                collectStateList[i]();
        }

        //print("state space size : " + info.vectorObservation.Count);

        int remain = brain.brainParameters.vectorObservationSize - info.vectorObservation.Count;
        for (int i = 0; i < remain; i++)
        {
            AddVectorObs(0f);
        }
        #endregion
    }

    bool TerminateAnt()
    {
        var angle = GetForwardBonus("pelvis");
        bool endOnAngle = (angle < .2f);
        return endOnAngle;
    }

    [SerializeField] List<Transform> torso = new List<Transform>();
    bool TerminateAnt_My()
    {
        terminateFunctionName = "Goal My";
        bool done = false;
        //for (int i = 0; i < torso.Count; i++)
        //{
        //    //float angle = GetAngle(torso[i].localEulerAngles.y);

        //    if (torso[i].localPosition.y <= 0.26f// || torso[i].localPosition.y > 1.0f
        //    //|| torso[i].localPosition.z < -3f || torso[i].localPosition.z > 3f
        //    //|| angle < -20f || angle > 20f
        //    )
        //    {
        //        done = true;
        //        break;
        //        //print("done");
        //    }
        //}

        return done;
    }

    float StepRewardAnt101()
    {
        float velocity = GetVelocity();
        float effort = GetEffort();
        var effortPenality = 0.5f * (float)effort;
        var jointsAtLimitPenality = GetJointsAtLimitPenality() * 4;

        var reward = velocity
                     - jointsAtLimitPenality
                     - effortPenality;
        if (ShowMonitor)
        {
            var hist = new[] { reward, velocity, -jointsAtLimitPenality, -effortPenality }.ToList();
            Monitor.Log("rewardHist", hist.ToArray());
        }

        //print("velocity : " + velocity);
        //print("effort : " + effort);
        //print("jointsAtLimitPenality : " + jointsAtLimitPenality);
        return reward;
    }

    float beforeVelocity;
    float StepRewardAnt_My()
    {
        float actionSquSum = 0f;
        for (int i = 0; i < Actions.Count; i++)
        {
            actionSquSum += Actions[i] * Actions[i];
        }

        float forward_reward = GetVelocity();   //�ӵ�(���� �ð��� ���ư� �Ÿ�)
        float ctrl_cost = 0.5f * actionSquSum;  //�׼� �迭 ���ҵ��� ������ ��
        float contact_cost = 0f;                //0.5 * 1e-3 * np.sum(np.square(np.clip(self.sim.data.cfrc_ext, -1, 1)))
                                                //The cfrc_ext are the external forces (force x,y,z and torque x,y,z) applied to each of the links at the center of mass. For the Ant, this is 14*6: the ground link, the torso link, and 12 links for all legs (3 links for each leg).
                                                //https://github.com/openai/gym/issues/585 
                                                //�������� �׻� 0
        float survive_reward = 1.0f;            //���

        //float accel = forward_reward - beforeVelocity;
        //accel = Mathf.Abs(accel);

        //beforeVelocity = forward_reward;

        float reward = forward_reward - ctrl_cost - contact_cost + survive_reward;

        //reward -= accel;
        //print(accel);

        return reward;
    }

    //float beforeTargetDist = 0f;
    float StepRewardAnt_PyBullet()
    {
        //print(Time.frameCount + " reward");
        //���� ���ʽ�
        //float alive_bonus = 1f; //���
        //if (torso[0].localPosition.y <= 0.26f)
        //{
        //    alive_bonus = -1f;
        //    //print("-1");
        //}

        //�ӵ� ���ʽ�
        float progress = GetVelocity();

        //float targetDist = new Vector2(target.z - BodyParts["pelvis"].transform.position.z, target.x - BodyParts["pelvis"].transform.position.x).magnitude;
        //float progress = (beforeTargetDist - targetDist) / Time.fixedDeltaTime;
        //print(targetDist + ", " + beforeTargetDist + ", " + progress + ", " + GetVelocity());
        //beforeTargetDist = targetDist;

        //action ���Ƽ
        //const float self_electricity_cost = -2f;
        //float actionAbsSum = 0f;
        //const float self_stall_torque_cost = -0.1f;
        //float actionSqrSum = 0f;
        //for (int i = 0; i < Actions.Count; i++)
        //{
        //    actionAbsSum += Mathf.Abs(Actions[i] * JointVelocity[i]);
        //    actionSqrSum += Actions[i] * Actions[i];
        //}
        //float absMean = actionAbsSum / Actions.Count;
        //float sqrMean = actionSqrSum / Actions.Count;
        //float electricity_cost = self_electricity_cost * absMean + self_stall_torque_cost * sqrMean;
        //electricity_cost = Mathf.Clamp(electricity_cost, -1f, 1f);

        ////joint stuck ���Ƽ
        //const float self_joints_at_limit_cost = -0.1f;
        //int joints_at_limit = 0;
        //for (int i = 0; i < configurableJoints.Count; i++)
        //{
        //    float lowerLimit = configurableJoints[i].lowAngularXLimit.limit * Mathf.Deg2Rad;
        //    float upperLimit = configurableJoints[i].highAngularXLimit.limit * Mathf.Deg2Rad;

        //    //float pos = MarathonJoints[i].Joint.transform.position.x;
        //    float pos = lowerLimit + (upperLimit - lowerLimit) * (Actions[i] + 1f) * 0.5f;
        //    float pos_mid = 0.5f * (lowerLimit + upperLimit);
        //    pos = 2 * (pos - pos_mid) / (upperLimit - lowerLimit);

        //    if (Mathf.Abs(pos) > 0.99f)
        //        joints_at_limit++;
        //}
        //float joints_at_limit_cost = self_joints_at_limit_cost * joints_at_limit;

        ////���� ���Ƽ
        //float feet_collision_cost = 0f; //���

        //float reward = alive_bonus + progress + electricity_cost + joints_at_limit_cost + feet_collision_cost;
        //float reward = progress + electricity_cost + joints_at_limit_cost + feet_collision_cost;
        float reward = progress;

        //print(string.Format("alive_bonus : {0}, progress : {1}, electricity_cost : {2}, joints_at_limit_cost : {3}, reward : {4}", alive_bonus, progress, electricity_cost, joints_at_limit_cost, reward));
        //print("reward : " + reward);

        return reward;
    }

    void Init_GoalList()
    {
        Goals.Clear();

        Goals.Add(TerminateAnt_My);
        Goals.Add(Goal1);
        Goals.Add(Goal2);
    }

    protected override bool Goal1()
    {
        terminateFunctionName = "Goal1";
        return false;
    }

    protected override bool Goal2()
    {
        terminateFunctionName = "Goal2";
        return true;
    }
}