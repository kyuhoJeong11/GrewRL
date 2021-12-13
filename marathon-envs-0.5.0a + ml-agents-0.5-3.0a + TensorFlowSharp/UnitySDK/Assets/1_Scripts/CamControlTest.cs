using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CamControlTest : MonoBehaviour
{
    Vector3 initPos;
    // Start is called before the first frame update
    void Start()
    {
        initPos = transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        transform.position += new Vector3(Input.GetAxisRaw("Horizontal") * Time.deltaTime, 0f, Input.GetAxisRaw("Vertical") * Time.deltaTime);
        if (Input.GetKeyDown(KeyCode.R))
            transform.position = initPos;
    }
}
