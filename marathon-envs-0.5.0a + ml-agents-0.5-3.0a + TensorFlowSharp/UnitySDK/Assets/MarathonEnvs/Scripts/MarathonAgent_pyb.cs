//using System;
//using System.Collections.Generic;
//using System.Linq;
//using UnityEngine;
//using MLAgents;
//using BulletUnity;

//namespace MLAgents
//{
//    public class MarathonAgent : Agent
//    {
//        //
//        // Params for prefabs

//        //
//        // Params for instances
//        [Tooltip("Set to camera to follow this instance")]
//        /**< \brief Set to camera to follow this instance*/
//        public GameObject CameraTarget;

//        [Tooltip("Set to true for this instance to show monitor")]
//        /**< \brief Set to true for this instance to show monitor*/
//        public bool ShowMonitor;

//        //
//        // Parms to set in subclass.AgentReset() 
//        [Tooltip("Reward value to set on termination")]
//        /**< \brief Reward value to set on termination*/
//        protected float OnTerminateRewardValue = 0f;

//        [Tooltip("Function which returns true to request termination of episode")]
//        /**< \brief Function which returns true to request termination of episode*/
//        protected Func<bool> TerminateFunction;

//        [Tooltip("Function which sets reward based on actions")]
//        /**< \brief Function which sets reward based on actions*/
//        protected Func<float> StepRewardFunction;

//        [Tooltip("Function which collections observations")]
//        /**< \brief Function which collections observations*/
//        protected Action ObservationsFunction;

//        [Tooltip("Optional Function for additional reward at end of Episode")]
//        /**< \brief Optional Function for additional reward at end of Episode*/
//        protected Func<float> OnEpisodeCompleteGetRewardFunction;

//        [Tooltip("Helper for tracking body parts")]
//        /**< \brief Helper for tracking body parts*/
//        protected Dictionary<string, BRigidBody> BodyParts = new Dictionary<string, BRigidBody>();

//        [Tooltip("Helper for body parts rotation to focal point")]
//        /**< \brief Helper for body parts rotation to focal point*/
//        protected Dictionary<string, Quaternion> BodyPartsToFocalRoation = new Dictionary<string, Quaternion>();

//        //
//        // read only status
//        [Tooltip("True if foot hit terrain since last logic frame")]
//        /**< \brief True if foot hit terrain since last logic frame*/
//        public bool FootHitTerrain;

//        [Tooltip(
//            "True if body part other than foot hit terrain since last logic frame. Note: bodyparts which connect to foot maybe flagged as foot")]
//        /**< \brief True if body part other than foot hit terrain since last logic frame. Note: bodyparts which connect to foot maybe flagged as foot*/
//        public bool NonFootHitTerrain;

//        [Tooltip("Last set of Actions")]
//        /**< \brief Last set of Actions*/
//        public List<float> Actions;

//        [Tooltip("Current state of each sensor")]
//        /**< \brief Current state of each sensor*/
//        public List<float> SensorIsInTouch;

//        [Tooltip("Gameobject for FocalPoint")]
//        /**< \brief Gameobject for FocalPoint*/
//        public GameObject FocalPoint;

//        [Tooltip("BRigidBody for FocalPoint")]
//        /**< \brief BRigidBody for FocalPoint*/
//        public BRigidBody FocalRidgedBody;

//        [Tooltip("Max distance travelled across all episodes")]
//        /**< \brief Max distance travelled across all episodes*/
//        public float FocalPointMaxDistanceTraveled;

//        [Tooltip("Current angle of each Joint")]
//        /**< \brief Current angle of each Joint*/
//        List<float> JointAngles;

//        [Tooltip("Current velocity of each Joint")]
//        /**< \brief Current velocity of each Joint*/
//        public List<float> JointVelocity;

//        [Tooltip("Current rotation of each Joint")]
//        /**< \brief Current rotation of each Joint*/
//        public List<Quaternion> JointRotations;

//        [Tooltip("Current angular velocity of each Joint")]
//        /**< \brief Current angular velocity of each Joint*/
//        List<Vector3> JointAngularVelocities;

//        [Tooltip("Joints created by MarathonSpawner")]
//        /**< \brief Joints created by MarathonSpawner*/
//        public List<MarathonJoint> MarathonJoints;

//        [Tooltip("Sensors created by MarathonSpawner")]
//        /**< \brief Sensors created by MarathonSpawner*/
//        public List<MarathonSensor> MarathonSensors;

//        public List<ConfigurableJoint> configurableJoints = new List<ConfigurableJoint>();
//        public List<CollisionSensor> collisionSensors = new List<CollisionSensor>();

//        //
//        // local variables
//        internal int NumSensors;
//        Dictionary<GameObject, Vector3> transformsPosition;
//        Dictionary<GameObject, Quaternion> transformsRotation;
//        MarathonSpawner marathonSpawner;
//        protected bool _hasValidModel;
//        List<float> qpos;
//        List<float> qglobpos;
//        List<float> qvel;
//        List<float> recentVelocity;


//        public override void AgentReset()
//        {
//            if (marathonSpawner == null)
//                marathonSpawner = GetComponent<MarathonSpawner>();

//            Transform[] allChildren = GetComponentsInChildren<Transform>();
//            if (_hasValidModel)
//            {
//                // restore
//                foreach (Transform child in allChildren)
//                {
//                    if (child.gameObject.name.Contains("OpenAIHumanoid"))
//                    {
//                        continue;
//                    }

//                    //TODO
//                    child.position = transformsPosition[child.gameObject];
//                    child.rotation = transformsRotation[child.gameObject];
//                    var childRb = child.GetComponent<BRigidBody>();
//                    if (childRb != null)
//                    {
//                        childRb.angularVelocity = Vector3.zero;
//                        childRb.velocity = Vector3.zero;
//                    }
//                }

//                marathonSpawner.ApplyRandom();
//                SetupMarathon();
//                UpdateQ();
//                return;
//            }

//            MarathonJoints = null;
//            MarathonSensors = null;
//            var rbs = this.GetComponentsInChildren<BRigidBody>().ToList();
//            foreach (var item in rbs)
//            {
//                if (item != null)
//                    DestroyImmediate(item.gameObject);
//            }

//            Resources.UnloadUnusedAssets();

//            marathonSpawner.SpawnFromXml();
//            allChildren = GetComponentsInChildren<Transform>();
//            transformsPosition = new Dictionary<GameObject, Vector3>();
//            transformsRotation = new Dictionary<GameObject, Quaternion>();
//            foreach (Transform child in allChildren)
//            {
//                transformsPosition[child.gameObject] = child.position;
//                transformsRotation[child.gameObject] = child.rotation;
//            }

//            marathonSpawner.ApplyRandom();
//            //SetupMarathon();
//            UpdateQ();
//            _hasValidModel = true;
//            recentVelocity = new List<float>();
//        }

//        void SetupMarathon()
//        {
//            NumSensors = MarathonSensors.Count;
//        }

//        internal void SetupBodyParts()
//        {
//            // set body part directions
//            foreach (var bodyPart in BodyParts)
//            {
//                var name = bodyPart.Key;
//                var BRigidBody = bodyPart.Value;

//                // find up
//                var focalPoint = BRigidBody.transform.position;
//                focalPoint.x += 10;
//                var focalPointRotation = BRigidBody.transform.rotation;
//                focalPointRotation.SetLookRotation(focalPoint - BRigidBody.transform.position);
//                BodyPartsToFocalRoation[name] = focalPointRotation;
//            }
//        }

//        public override void CollectObservations()
//        {
//            UpdateQ();
//            ObservationsFunction();
//        }

//        //string str = "";
//        public bool useMyVector;
//        public float[] my_vectorAction;
//        public override void AgentAction(float[] vectorAction, string textAction)
//        {
//            //print(Time.frameCount + " action");
//            ////str = "";
//            ////???????? ???? action size?? ?????? ?????? ????????(???? ?????? ????)
//            if (my_vectorAction.Length != MarathonJoints.Count)
//            {
//                my_vectorAction = new float[MarathonJoints.Count];

//                float re = -1f;
//                for (int i = 0; i < my_vectorAction.Length; i += 2)
//                {
//                    my_vectorAction[i] = 0.5f * re;
//                    my_vectorAction[i + 1] = 1f * re;
//                    re *= -1f;
//                }
//            }

//            if (useMyVector)
//                vectorAction = my_vectorAction;

//            Actions = vectorAction.ToList();
//            for (int i = 0; i < MarathonJoints.Count; i++)
//            {
//                //if (Actions[i] > 1f || Actions[i] < -1f)
//                //    print("need clip action");

//                ApplyAction(MarathonJoints[i], Actions[i]);
//            }

//            UpdateQ();

//            if (!IsDone())
//            {
//                bool done = TerminateFunction();

//                if (done)
//                {
//                    Done();
//                    //print("cumulativeReward = " + GetCumulativeReward());
//                    //ResetReward();
//                    SetReward(OnTerminateRewardValue);
//                    //print("done reward = " + OnTerminateRewardValue);
//                }
//                else if (StepRewardFunction != null)
//                {
//                    SetReward(StepRewardFunction());
//                    //print("step reward = " + StepRewardFunction());
//                }

//                done |= (this.GetStepCount() >= agentParameters.maxStep && agentParameters.maxStep > 0);
//                if (done && OnEpisodeCompleteGetRewardFunction != null)
//                {
//                    AddReward(OnEpisodeCompleteGetRewardFunction());
//                    //print("add reward = " + OnEpisodeCompleteGetRewardFunction());
//                }
//            }

//            FootHitTerrain = false;
//            NonFootHitTerrain = false;
//        }

//        public void my_vector_reverse()
//        {
//            for (int i = 0; i < my_vectorAction.Length; i++)
//            {
//                my_vectorAction[i] *= -1f;
//            }
//        }

//        internal void KillJointPower(string[] hints)
//        {
//            var mJoints = hints
//                .SelectMany(hint =>
//                    MarathonJoints
//                        .Where(x => x.JointName.ToLowerInvariant().Contains(hint.ToLowerInvariant()))
//                ).ToList();
//            foreach (var joint in mJoints)
//                Actions[MarathonJoints.IndexOf(joint)] = 0f;
//        }

//        internal float GetHeight()
//        {
//            var feetYpos = MarathonJoints
//                .Where(x => x.JointName.ToLowerInvariant().Contains("foot"))
//                .Select(x => x.Joint.transform.position.y)
//                .OrderBy(x => x)
//                .ToList();
//            float lowestFoot = 0f;
//            if (feetYpos != null && feetYpos.Count != 0)
//                lowestFoot = feetYpos[0];
//            var height = FocalPoint.transform.position.y - lowestFoot;
//            return height;
//        }

//        internal float GetAverageVelocity(string bodyPart = null)
//        {
//            var v = GetVelocity(bodyPart);
//            recentVelocity.Add(v);
//            if (recentVelocity.Count >= 10)
//                recentVelocity.RemoveAt(0);
//            return recentVelocity.Average();
//        }

//        internal float GetVelocity(string bodyPart = null)
//        {
//            //var dt = Time.fixedDeltaTime;
//            float rawVelocity = 0f;
//            if (!string.IsNullOrWhiteSpace(bodyPart))
//                rawVelocity = BodyParts[bodyPart].velocity.x;
//            else
//                rawVelocity = FocalRidgedBody.velocity.x;

//            //var maxSpeed = 4f; // meters per second
//            var maxSpeed = 1f; // meters per second
//            var velocity = rawVelocity * maxSpeed;
//            if (ShowMonitor)
//            {
//                Monitor.Log("MaxDistance", FocalPointMaxDistanceTraveled.ToString());
//                Monitor.Log("MPH: ", (rawVelocity * 2.236936f).ToString());
//            }

//            return velocity;
//        }

//        internal float GetUprightBonus()
//        {
//            var qpos2 = (GetAngleFromUp() % 180) / 180;
//            var uprightBonus = 0.5f * (2 - (Mathf.Abs(qpos2) * 2) - 1);
//            return uprightBonus;
//        }

//        internal float GetUprightBonus(string bodyPart)
//        {
//            var toFocalAngle = BodyPartsToFocalRoation[bodyPart] * -BodyParts[bodyPart].transform.forward;
//            var angleFromUp = Vector3.Angle(toFocalAngle, Vector3.up);
//            var qpos2 = (angleFromUp % 180) / 180;
//            var uprightBonus = 0.5f * (2 - (Mathf.Abs(qpos2) * 2) - 1);
//            return uprightBonus;
//        }

//        internal float GetDirectionBonus(string bodyPart, Vector3 direction, float maxBonus = 0.5f)
//        {
//            if (BodyParts[bodyPart] == null)
//                return 0f;

//            var toFocalAngle = BodyPartsToFocalRoation[bodyPart] * BodyParts[bodyPart].transform.right;
//            var angle = Vector3.Angle(toFocalAngle, direction);
//            var qpos2 = (angle % 180) / 180;
//            var bonus = maxBonus * (2 - (Mathf.Abs(qpos2) * 2) - 1);
//            return bonus;
//        }

//        internal void GetDirectionDebug(string bodyPart)
//        {
//            var toFocalAngle = BodyPartsToFocalRoation[bodyPart] * BodyParts[bodyPart].transform.right;
//            var angleFromLeft = Vector3.Angle(toFocalAngle, Vector3.left);
//            var angleFromUp = Vector3.Angle(toFocalAngle, Vector3.up);
//            var angleFromDown = Vector3.Angle(toFocalAngle, Vector3.down);
//            var angleFromRight = Vector3.Angle(toFocalAngle, Vector3.right);
//            var angleFromForward = Vector3.Angle(toFocalAngle, Vector3.forward);
//            var angleFromBack = Vector3.Angle(toFocalAngle, Vector3.back);
//            print(
//                $"{bodyPart}: l: {angleFromLeft}, r: {angleFromRight}, f: {angleFromForward}, b: {angleFromBack}, u: {angleFromUp}, d: {angleFromDown}");
//        }

//        internal float GetLeftBonus(string bodyPart)
//        {
//            var bonus = GetDirectionBonus(bodyPart, Vector3.left);
//            return bonus;
//        }

//        internal float GetRightBonus(string bodyPart)
//        {
//            var bonus = GetDirectionBonus(bodyPart, Vector3.right);
//            return bonus;
//        }

//        internal float GetForwardBonus(string bodyPart)
//        {
//            var bonus = GetDirectionBonus(bodyPart, Vector3.forward);
//            return bonus;
//        }

//        internal float GetHeightPenality(float maxHeight)
//        {
//            var height = GetHeight();
//            var heightPenality = maxHeight - height;
//            heightPenality = Mathf.Clamp(heightPenality, 0f, maxHeight);
//            return heightPenality;
//        }

//        internal float GetEffort(string[] ignorJoints = null)
//        {
//            double effort = 0;
//            for (int i = 0; i < Actions.Count; i++)
//            {
//                var name = MarathonJoints[i].JointName;
//                if (ignorJoints != null && ignorJoints.Contains(name))
//                    continue;
//                var jointEffort = Mathf.Pow(Mathf.Abs(Actions[i]), 2);
//                effort += jointEffort;
//            }

//            return (float)effort;
//        }

//        internal float GetJointsAtLimitPenality(string[] ignorJoints = null)
//        {
//            int atLimitCount = 0;
//            for (int i = 0; i < Actions.Count; i++)
//            {
//                var name = MarathonJoints[i].JointName;
//                if (ignorJoints != null && ignorJoints.Contains(name))
//                    continue;
//                bool atLimit = Mathf.Abs(Actions[i]) >= 1f;
//                if (atLimit)
//                    atLimitCount++;
//            }

//            float penality = atLimitCount * 0.2f;
//            return (float)penality;
//        }

//        internal float GetEffortSum()
//        {
//            var effort = Actions
//                .Select(x => Mathf.Abs(x))
//                .Sum();
//            return effort;
//        }

//        internal float GetEffortMean()
//        {
//            var effort = Actions
//                .Average();
//            return effort;
//        }

//        internal float GetAngleFromUp()
//        {
//            var angleFromUp = Vector3.Angle(FocalPoint.transform.forward, Vector3.up);
//            if (ShowMonitor)
//            {
//            }

//            return angleFromUp;
//        }

//        public virtual void OnTerrainCollision(GameObject other, GameObject terrain)
//        {
//            if (string.Compare(terrain.name, "Terrain", true) != 0)
//                return;

//            switch (other.name.ToLowerInvariant().Trim())
//            {
//                case "right_leg": // dm_walker
//                case "left_leg": // dm_walker
//                case "foot": // dm_hopper
//                case "calf": // dm_hopper
//                case "left_left_foot": // dm_humanoid
//                case "left_right_foot": // dm_humanoid
//                case "right_left_foot": // dm_humanoid
//                case "right_right_foot": // dm_humanoid
//                case "left_shin": // dm_humanoid
//                case "right_shin": // dm_humanoid
//                case "left_ankle_geom": // oai_ant
//                case "right_ankle_geom": // oai_ant
//                case "third_ankle_geom": // oai_ant
//                case "fourth_ankle_geom": // oai_ant
//                case "right_foot": // dm_walker
//                case "left_foot": // dm_walker
//                    FootHitTerrain = true;
//                    break;
//                default:
//                    NonFootHitTerrain = true;
//                    break;
//            }
//        }

//        internal bool TerminateNever()
//        {
//            return false;
//        }

//        internal bool TerminateOnNonFootHitTerrain()
//        {
//            return NonFootHitTerrain;
//        }

//        internal void ApplyAction(MarathonJoint mJoint, float? target = null)
//        {
//            B6DOFConstraint configurableJoint = mJoint.Joint as B6DOFConstraint;
//            ConfigurableJoint c;
//            HingeJoint h;
//            c.angularXDrive;

//            if (!target.HasValue) // handle random
//                target = UnityEngine.Random.value * 2 - 1;
//            Vector3 t = configurableJoint.motorLinearTargetVelocity;
//            t.x = target.Value * mJoint.MaximumForce;
//            configurableJoint.motorLinearTargetVelocity = t;
//            JointDrive angX = configurableJoint.angularXDrive;
//            angX.positionSpring = 1f;
//            float scale = mJoint.MaximumForce * Mathf.Pow(Mathf.Abs(target.Value), 3);
//            angX.positionDamper = Mathf.Max(1f, scale);
//            angX.maximumForce = Mathf.Max(1f, mJoint.MaximumForce);
//            configurableJoint.angularXDrive = angX;
//        }


//        List<System.Tuple<ConfigurableJoint, Transform>> _baseTargetPairs;

//        public void SetMarathonSensors(List<MarathonSensor> marathonSensors)
//        {
//            MarathonSensors = marathonSensors;
//            SensorIsInTouch = Enumerable.Range(0, marathonSensors.Count).Select(x => 0f).ToList();
//            foreach (var sensor in marathonSensors)
//            {
//                sensor.SiteObject.gameObject.AddComponent<SensorBehavior>();
//            }
//        }

//        public void SetMarathonJoints(List<MarathonJoint> marathonJoints)
//        {
//            MarathonJoints = marathonJoints;
//            var target = FindTopMesh(MarathonJoints.FirstOrDefault()?.Joint.gameObject, null);
//            if (CameraTarget != null && MarathonJoints != null)
//            {
//                var smoothFollow = CameraTarget.GetComponent<SmoothFollow>();
//                if (smoothFollow != null)
//                    smoothFollow.target = target.transform;
//            }

//            FocalPoint = target;
//            FocalRidgedBody = FocalPoint.GetComponent<BRigidBody>();
//            var qlen = MarathonJoints.Count + 3;
//            qpos = Enumerable.Range(0, qlen).Select(x => 0f).ToList();
//            qglobpos = Enumerable.Range(0, qlen).Select(x => 0f).ToList();
//            qvel = Enumerable.Range(0, qlen).Select(x => 0f).ToList();
//            JointAngles = Enumerable.Range(0, MarathonJoints.Count).Select(x => 0f).ToList();
//            JointVelocity = Enumerable.Range(0, MarathonJoints.Count).Select(x => 0f).ToList();
//            _baseTargetPairs = MarathonJoints
//                .Select(x => new System.Tuple<B6DOFConstraint, Transform>(x.TrueBase, x.TrueTarget))
//                //.Distinct()
//                .ToList();
//            JointRotations = Enumerable.Range(0, _baseTargetPairs.Count).Select(x => Quaternion.identity).ToList();
//            JointAngularVelocities = Enumerable.Range(0, _baseTargetPairs.Count).Select(x => Vector3.zero).ToList();

//            for (int i = 0; i < MarathonJoints.Count; i++)
//            {
//                configurableJoints.Add(MarathonJoints[i].Joint.GetComponent<ConfigurableJoint>());
//                if (configurableJoints[i].gameObject.name.Contains("ankle"))
//                {
//                    CollisionSensor sensor = configurableJoints[i].gameObject.AddComponent<CollisionSensor>();
//                    collisionSensors.Add(sensor);
//                }
//            }
//        }

//        GameObject FindTopMesh(GameObject curNode, GameObject topmostNode = null)
//        {
//            var meshRenderer = curNode.GetComponent<MeshRenderer>();
//            if (meshRenderer != null)
//                topmostNode = meshRenderer.gameObject;
//            var root = curNode.transform.root.gameObject;
//            var meshRenderers = root.GetComponentsInChildren<MeshRenderer>();
//            if (meshRenderers != null && meshRenderers.Length > 0)
//                topmostNode = meshRenderers[0].gameObject;

//            return (topmostNode);
//        }

//        //int beforeFrame = 0;
//        void UpdateQ()
//        {
//            if (MarathonJoints == null || MarathonJoints.Count == 0)
//                return;

//            //if (Time.frameCount == beforeFrame)
//            //    return;

//            //beforeFrame = Time.frameCount;

//            float dt = Time.fixedDeltaTime;
//            FocalPointMaxDistanceTraveled = Mathf.Max(FocalPointMaxDistanceTraveled, FocalPoint.transform.position.x);

//            var topJoint = MarathonJoints[0];
//            var topTransform = topJoint.Joint.transform;
//            var topRidgedBody = topJoint.Joint.transform.GetComponent<BRigidBody>();
//            qpos[0] = topTransform.position.x;
//            qglobpos[0] = topTransform.position.x;
//            qvel[0] = topRidgedBody.velocity.x;
//            qpos[1] = topTransform.position.y;
//            qglobpos[1] = topTransform.position.y;
//            qvel[1] = topRidgedBody.velocity.y;
//            qpos[2] = ((topTransform.rotation.eulerAngles.z - 180f) % 180) / 180;
//            qglobpos[2] = ((topTransform.rotation.eulerAngles.z - 180f) % 180) / 180;
//            qvel[2] = topRidgedBody.velocity.z;
//            for (int i = 0; i < MarathonJoints.Count; i++)
//            {
//                var joint = MarathonJoints[i].Joint;
//                var targ = joint.transform;
//                float pos = 0f;
//                float globPos = 0f;
//                if (joint.axis.x != 0f)
//                {
//                    pos = targ.localEulerAngles.x;
//                    globPos = targ.eulerAngles.x;
//                }
//                else if (joint.axis.y != 0f)
//                {
//                    pos = targ.localEulerAngles.y;
//                    globPos = targ.eulerAngles.y;
//                }
//                else if (joint.axis.z != 0f)
//                {
//                    pos = targ.localEulerAngles.z;
//                    globPos = targ.eulerAngles.z;
//                }

//                pos = ((pos - 180f) % 180) / 180;
//                globPos = ((globPos - 180f) % 180) / 180;
//                var lastPos = qpos[3 + i];
//                qpos[3 + i] = pos;
//                JointAngles[i] = pos;
//                var lastgPos = qglobpos[3 + i];
//                qglobpos[3 + i] = globPos;
//                var vel = (qpos[3 + i] - lastPos) / (dt);
//                qvel[3 + i] = vel;
//                JointVelocity[i] = vel;
//            }

//            for (int i = 0; i < _baseTargetPairs.Count; i++)
//            {
//                var x = _baseTargetPairs[i];
//                var baseRot = x.Item1.transform.rotation;
//                var targetRot = x.Item2.rotation;
//                var rotation = Quaternion.Inverse(baseRot) * targetRot;
//                JointRotations[i] = rotation;

//                var baseAngVel = x.Item1.GetComponent<BRigidBody>().angularVelocity;
//                var targetAngVel = x.Item2.GetComponent<BRigidBody>().angularVelocity;
//                var angVel = baseAngVel - targetAngVel;
//                angVel /= dt;
//                angVel /= 10000f;
//                JointAngularVelocities[i] = angVel;
//            }
//        }

//        public void SensorCollisionEnter(Collider sensorCollider, Collision other)
//        {
//            if (string.Compare(other.gameObject.name, "Terrain", true) != 0)
//                return;
//            var otherGameobject = other.gameObject;
//            var sensor = MarathonSensors
//                .FirstOrDefault(x => x.SiteObject == sensorCollider);
//            if (sensor != null)
//            {
//                var idx = MarathonSensors.IndexOf(sensor);
//                SensorIsInTouch[idx] = 1f;
//            }
//        }

//        public void SensorCollisionExit(Collider sensorCollider, Collision other)
//        {
//            if (string.Compare(other.gameObject.name, "Terrain", true) != 0)
//                return;
//            var otherGameobject = other.gameObject;
//            var sensor = MarathonSensors
//                .FirstOrDefault(x => x.SiteObject == sensorCollider);
//            if (sensor != null)
//            {
//                var idx = MarathonSensors.IndexOf(sensor);
//                SensorIsInTouch[idx] = 0f;
//            }
//        }
//    }
//}