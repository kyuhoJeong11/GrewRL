using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using MLAgents;

public class MarathonTestBedAgent : MarathonAgent {

    public override void AgentReset()
    {
        base.AgentReset();

        // set to true this to show monitor while training
        Monitor.SetActive(true);

        StepRewardFunction = StepRewardTestBed;
        TerminateFunction = TerminateNever;
        ObservationsFunction = ObservationsDefault;
        base.SetupBodyParts();
    }


    public override void AgentOnDone()
    {
    }
    void ObservationsDefault()
    {
    }

    float StepRewardTestBed()
    {
        return 0f;
    }
}
