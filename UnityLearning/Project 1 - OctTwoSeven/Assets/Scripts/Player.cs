using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour //MonoBehaviour is the parent class
{
    [SerializeField]public Transform groundCheckTransform = null;
    private bool jumpKeyWasPressed;
    private float horizontalInput;
    private Rigidbody rigidbodyComponent;
    [SerializeField] private LayerMask playerMask;
   /* private bool isGrounded;*/
    // Start is called before the first frame update
    void Start()
    {
        rigidbodyComponent = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space) == true)
        {
            jumpKeyWasPressed = true;
        }

        horizontalInput = Input.GetAxis("Horizontal");
    }

 
 public class CamRotation : MonoBehaviour
{

    public float rotationSpeed = 10;

    void Update()
    {
        Vector3 rotation = transform.eulerAngles;

        rotation.x += Input.GetAxis("Horizontal") * rotationSpeed * Time.deltaTime; // Standart Left-/Right Arrows and A & D Keys

        transform.eulerAngles = rotation;
    }
}

//FixedUpdate is called once every physics update //by default 100 Hz
private void FixedUpdate()
    {
        rigidbodyComponent.velocity = new Vector3(horizontalInput, rigidbodyComponent.velocity.y, 0);
        /*if (!isGrounded)
        {
            return;
        }*/

        if (Physics.OverlapSphere(groundCheckTransform.position, 0.1f, playerMask).Length == 0)
        {
            return;
        }

        if (jumpKeyWasPressed == true)
        {
            // Debug.Log("Space Key Was Pressed Down");
            rigidbodyComponent.AddForce(Vector3.up * 11, ForceMode.VelocityChange);
            jumpKeyWasPressed = false;
        }

       
    }

   /* private void OnCollisionEnter(Collision collision)
    {
        isGrounded = true;
    }

    private void OnCollisionExit(Collision collision)
    {
        isGrounded = false;
    }*/
}
