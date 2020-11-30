
using UnityEngine;
using System.Collections;

public class CameraControl : MonoBehaviour
{
	// Use this for initialization
	private GameObject gameObject;
	float x1;
	float x2;
	float x3;
	float x4;
	void Start()
	{
		gameObject = GameObject.Find("Main Camera");
	}

	// Update is called once per frame
	void Update()
	{
		//空格键抬升高度
		if (Input.GetKey(KeyCode.Space))
		{
			transform.position = new Vector3(transform.position.x, transform.position.y + 0.1f, transform.position.z);
		}

		//w键前进
		if (Input.GetKey(KeyCode.W))
		{
			this.gameObject.transform.Translate(new Vector3(0, 0, 30f * Time.deltaTime));
		}
		//s键后退
		if (Input.GetKey(KeyCode.S))
		{
			this.gameObject.transform.Translate(new Vector3(0, 0, -30f * Time.deltaTime));
		}
		//a键后退
		if (Input.GetKey(KeyCode.A))
		{
			this.gameObject.transform.Translate(new Vector3(-0.1f, 0, 0 * Time.deltaTime));
		}
		//d键后退
		if (Input.GetKey(KeyCode.D))
		{
			this.gameObject.transform.Translate(new Vector3(0.1f, 0, 0 * Time.deltaTime));
		}
		if (Input.GetKey(KeyCode.Z))
		{
			this.gameObject.transform.Translate(new Vector3(0, 0.1f, 0 * Time.deltaTime));
		}
		if (Input.GetKey(KeyCode.C))
		{
			this.gameObject.transform.Translate(new Vector3(0, -0.1f, 0 * Time.deltaTime));
		}

		if (Input.GetKey(KeyCode.Q))
		{
			float rotationY = transform.localEulerAngles.y - 0.1f;
			transform.localEulerAngles = new Vector3(transform.localEulerAngles.x, rotationY, transform.localEulerAngles.z);
		}
		if (Input.GetKey(KeyCode.E))
		{
			float rotationY = transform.localEulerAngles.y + 0.1f;
			transform.localEulerAngles = new Vector3(transform.localEulerAngles.x, rotationY, transform.localEulerAngles.z);
		}
	}
}
