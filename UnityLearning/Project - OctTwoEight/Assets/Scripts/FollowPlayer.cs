using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowPlayer : MonoBehaviour
{
    //this variable is used for pointing to the player
    public Transform player;
    public Vector3 offset;

    // Update is called once per frame
    void Update()
    {
        transform.position = player.position + offset;       
    }
}
