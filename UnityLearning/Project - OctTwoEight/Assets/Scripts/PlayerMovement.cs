using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    public Rigidbody rb;

    public float forwardForce = 2000;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    //Use FixedUpdate for Physics stuff
    private void FixedUpdate()
    {
        rb.AddForce(0, 0, 1000 * Time.deltaTime);


        /*if (Input.GetKey(KeyCode.Space))
        {
            rb.AddForce(0, 50, 0);
        }*/
        /*if (Input.GetKey("w"))
        {
            rb.AddForce(0, 0, 30);
        }*/
        /*if (Input.GetKey("s"))
        {
            rb.AddForce(0, 0, -30);
        }*/
        if (Input.GetKey("left"))
        {
            rb.AddForce(-1, 0, 0, ForceMode.VelocityChange);
        }
        if (Input.GetKey("right"))
        {
            rb.AddForce(1, 0, 0, ForceMode.VelocityChange);
        }
    }
}
