using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Text;
using System.Net;
using System.Net.Sockets;
using MLAgents;
using System;
using System.Runtime.InteropServices;
using UnityEngine.UI;

public class Client : MonoBehaviour
{
    public class AsyncObject
    {
        public byte[] buffer;
        public Socket socket;
        public int bufferSize;

        public AsyncObject(int _bufferSize, Socket _socket)
        {
            bufferSize = _bufferSize;
            buffer = new byte[bufferSize];
            buffer.Initialize();

            socket = _socket;
        }

        public void ClearBuffer()
        {
            System.Array.Clear(buffer, 0, bufferSize);
        }
    }

    [StructLayout(LayoutKind.Sequential)]
    public class CSONG
    {
        //state space
        [MarshalAs(UnmanagedType.ByValArray, SizeConst = (int)MarathonAgent.E_STATE.end)]
        public bool[] states = new bool[(int)MarathonAgent.E_STATE.end];

        //xml file
        [MarshalAs(UnmanagedType.I4, SizeConst = 1)]
        public int legCount;

        //goal script
        [MarshalAs(UnmanagedType.I4, SizeConst = 1)]
        public int agentIndex;
        [MarshalAs(UnmanagedType.I4, SizeConst = 1)]
        public int goalIndex;
    }

    //public struct UdpState
    //{
    //    public UdpClient udpClient;
    //    public IPEndPoint remoteEP;
    //}

    string ip = "127.0.0.1";
    int port = 8000;

    //UdpClient udpClient;
    //IPEndPoint remoteEP;
    //UdpState udpState = new UdpState();
    Socket mainSocket;
    Queue<byte[]> commandBytes = new Queue<byte[]>();

    //byte[] data;

    public MarathonAcademy marathonAcademy;
    //public Brain brain;

    private MarathonSpawner[] marathonSpawners;
    private MarathonAgent[] marathonAgents;

    //int leg_count;

    private CSONG csongSize = new CSONG(); //패킷 size 측정용

    public Text debugLog; //데이터 수신 테스트용

    

    void Start()
    {
        try
        {
            GameObject[] ants = GameObject.FindGameObjectsWithTag("agent");

            marathonSpawners = new MarathonSpawner[ants.Length];
            marathonAgents = new MarathonAgent[ants.Length];

            for (int i = 0; i < ants.Length; i++)
            {
                marathonSpawners[i] = ants[i].GetComponent<MarathonSpawner>();
                marathonAgents[i] = ants[i].GetComponent<MarathonAgent>();
            }

            //remoteEP = new IPEndPoint(IPAddress.Parse(strIP), port);
            Socket client = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.IP);
            var result = client.BeginConnect(ip, port, null, null);
            bool success = result.AsyncWaitHandle.WaitOne(500, true);
            if (success)
            {
                client.EndConnect(result);
                debugLog.text = ("Connected " + ip);
                mainSocket = client;
            }
            else
            {
                client.Close();
                debugLog.text = ("Connect fail. IP : " + ip);
            }

            byte[] clientNumData = new byte[4];
            client.Receive(clientNumData);
            int clientNum = BitConverter.ToInt32(clientNumData, 0);
            for (int i = 0; i < marathonSpawners.Length; i++)
            {
                marathonSpawners[i].clientNum = clientNum;
            }

            debugLog.text = ("clientNum : " + clientNum);
            
            AsyncObject asyncObject = new AsyncObject(Marshal.SizeOf(csongSize), mainSocket);
            mainSocket.BeginReceive(asyncObject.buffer, 0, asyncObject.bufferSize, 0, DataReceived, asyncObject);

            //udpClient = new UdpClient(remoteEP);
            //udpClient.Client.Blocking = false;
            //udpClient.Client.ReceiveTimeout = 1000;

            //udpState.udpClient = udpClient;
            //udpState.remoteEP = remoteEP;

            //udpClient.Client.Bind(remoteEP);

            //udpClient.BeginReceive(new System.AsyncCallback(ReceiveCallback), udpState); //한번만 받음(비동기)

            //while (udpClient.Available > 0)
            //{
            //    // receive bytes
            //    data = udpClient.Receive(ref remoteEP);
            //    //print("clear data : " + Encoding.Default.GetString(data));
            //}

            //StartCoroutine(ReceiveData());

        }
        catch (Exception e)
        {
            debugLog.text = e.Message;
        }
    }

    void Update()
    {
        //data = udpClient.Receive(ref remoteEP); //받을때까지 멈춤(동기)
        //print(string.Format("{0} : 수신 : {1}", remoteEP.ToString(), Encoding.Default.GetString(data)));
        if (commandBytes.Count > 0)
        {
            CSONG csongData = (CSONG)Deserialize(commandBytes.Dequeue(), csongSize.GetType());
            debugLog.text = string.Format("legCount : {0}, agentIndex : {1}, goalIndex : {2}", csongData.legCount, csongData.agentIndex, csongData.goalIndex);
            ChangeXML(csongData.legCount);
            ChangeState(in csongData.states);
            ChangeGoal(csongData.agentIndex, csongData.goalIndex);
        }
    }

    private void OnDestroy()
    {
        //udpClient.Close();
        try
        {
            mainSocket.Shutdown(SocketShutdown.Both);
            //mainSocket.Disconnect(true);
            //mainSocket.Close(1);
        }
        catch (Exception e)
        {
            print("Destroy Message : " + e.Message);
        }
    }

    void DataReceived(System.IAsyncResult asyncResult)
    {
        // BeginReceive에서 추가적으로 넘어온 데이터를 AsyncObject 형식으로 변환한다.
        AsyncObject obj = (AsyncObject)asyncResult.AsyncState;

        // 데이터 수신을 끝낸다.
        int received = obj.socket.EndReceive(asyncResult);

        // 받은 데이터가 없으면(연결끊어짐) 끝낸다.
        if (received <= 0)
        {
            obj.socket.Close();
            return;
        }

        try
        {
            byte[] byteCommand = (byte[])obj.buffer.Clone();
            commandBytes.Enqueue(byteCommand);
        }
        catch (System.Exception e)
        {
            print(e.Message);
        }
        finally
        {
            obj.ClearBuffer();
            obj.socket.BeginReceive(obj.buffer, 0, obj.bufferSize, 0, DataReceived, obj);
        }
    }

    //IEnumerator ReceiveData()
    //{
    //    while (true)
    //    {
    //        try
    //        {
    //            if (udpClient.Available > 0)
    //            {
    //                // receive bytes
    //                data = udpClient.Receive(ref remoteEP);
    //                //string str = Encoding.Default.GetString(data);

    //                //string[] sp = str.Split('$');
    //                //for (int i = 0; i < sp.Length; i++)
    //                //{
    //                //    //print(sp[i]);
    //                //    if (sp[i].Contains("LegCount"))
    //                //        ChangeXML(sp[i]);
    //                //    else if (sp[i].Contains("StateType"))
    //                //        ChangeState(sp[i]);
    //                //    else if (sp[i].Contains("Agent"))
    //                //        ChangeGoal(sp[i]);
    //                //}

    //                CSONG csong = (CSONG)Deserialize(data, csongSize.GetType());
    //                debugLog.text = string.Format("legCount : {0}, agentIndex : {1}, goalIndex : {2}", csong.legCount, csong.agentIndex, csong.goalIndex);
    //                ChangeXML(csong.legCount);
    //                ChangeState(in csong.states);
    //                ChangeGoal(csong.agentIndex, csong.goalIndex);
    //            }
    //        }
    //        catch (System.Exception err)
    //        {
    //            debugLog.text = err.Message;
    //            //print(err.ToString());
    //        }

    //        yield return new WaitForEndOfFrame();
    //    }
    //}

    public void ChangeXML(int legCount)
    {
        if (legCount < 0) //csong 에서 미입력 or 정수로 변환 실패
            return;

        for (int i = 0; i < marathonSpawners.Length; i++)
        {
            marathonSpawners[i].legCount = legCount;
            debugLog.text = marathonSpawners[i].SetXml(marathonSpawners[i].legCount);
            marathonAgents[i].AgentReset();
        }

        //marathonAcademy.InitializeEnvironment();
        try
        {
            marathonAcademy.UpdateBrainParameters();
        }
        catch (System.Exception)
        {

        }

        marathonAcademy.enabled = true;

        return;
    }

    public void ChangeState(in bool[] states)
    {
        for (int i = 0; i < states.Length; i++)
        {
            foreach (var agent in marathonAgents)
            {
                agent.isCollectList[i] = states[i];
            }
        }
    }

    public void ChangeGoal(int agentIndex, int goalIndex)
    {
        if (agentIndex < 0 || goalIndex < 0) //csong 에서 미입력 or 정수로 변환 실패
            return;

        List<int> agents_index = new List<int>();

        //if (agent.Contains("All"))
        //{
        //    for (int i = 0; i < marathonAgents.Length; i++)
        //    {
        //        agents_index.Add(i);
        //    }
        //}
        //else
        {
            if (agentIndex <= marathonAgents.Length)
                agents_index.Add(agentIndex);
            else
                return;
        }

        for (int i = 0; i < agents_index.Count; i++)
        {
            if (agents_index[i] >= marathonAgents.Length)
                break;

            marathonAgents[agents_index[i]].Set_Goal(goalIndex);
        }
    }

    public object Deserialize(byte[] data, Type dataType)
    {
        int RawSize = Marshal.SizeOf(dataType);

        //If there is no data, the return value is taken to be null.
        if (RawSize > data.Length)
            return null;

        IntPtr buffer = Marshal.AllocHGlobal(RawSize);
        // Buffer To Object
        Marshal.Copy(data, 0, buffer, RawSize);
        object objData = Marshal.PtrToStructure(buffer, dataType);

        Marshal.FreeHGlobal(buffer);

        if (Marshal.SizeOf(objData) != data.Length)// (((PACKET_DATA)obj).TotalBytes != data.Length)
            return null;

        return objData;
    }

    //public void ReceiveCallback(System.IAsyncResult ar)
    //{
    //    UdpClient u = ((UdpState)(ar.AsyncState)).udpClient;
    //    IPEndPoint e = ((UdpState)(ar.AsyncState)).remoteEP;

    //    byte[] receiveBytes = u.EndReceive(ar, ref e);
    //    string receiveString = Encoding.ASCII.GetString(receiveBytes);

    //    print($"Received: {receiveString}");

    //    u.BeginReceive(new System.AsyncCallback(ReceiveCallback), (UdpState)(ar.AsyncState)); //한번만 받고 끝나지 않도록
    //}

    //public void asdf()
    //{
    //    var academyParameters =
    //                new MLAgents.CommunicatorObjects.UnityRLInitializationOutput();
    //    academyParameters.Name = gameObject.name;
    //    academyParameters.Version = kApiVersion;
    //    foreach (var brain in brains)
    //    {
    //        var bp = brain.brainParameters;
    //        academyParameters.BrainParameters.Add(
    //            MLAgents.Batcher.BrainParametersConvertor(
    //                bp,
    //                brain.gameObject.name,
    //                (MLAgents.CommunicatorObjects.BrainTypeProto)
    //                brain.brainType));
    //    }

    //    //academyParameters.EnvironmentParameters =
    //    //    new MLAgents.CommunicatorObjects.EnvironmentParametersProto();
    //    //foreach (var key in resetParameters.Keys)
    //    //{
    //    //    academyParameters.EnvironmentParameters.FloatParameters.Add(
    //    //        key, resetParameters[key]
    //    //    );
    //    //}

    //    marathonAcademy.brainBatcher.SendAcademyParameters(academyParameters);
    //}
}
