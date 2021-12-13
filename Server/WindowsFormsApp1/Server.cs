using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net;
using System.Net.Sockets;
using System.Runtime.InteropServices;

namespace WindowsFormsApp1
{
    public partial class Server : Form
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

        public enum E_STATE
        {
            positionX,
            positionY,
            positionZ,

            rotationX,
            rotationY,
            rotationZ,

            velocityX,
            velocityY,
            velocityZ,

            angularVelocityX,
            angularVelocityY,
            angularVelocityZ,

            joint_angle,

            joint_angularVelocity,

            joint_collisionSensor,

            end,
        }

        [StructLayout(LayoutKind.Sequential)]
        public class CSONG
        {
            //state space
            [MarshalAs(UnmanagedType.ByValArray, SizeConst = (int)E_STATE.end)]
            public bool[] states = new bool[(int)E_STATE.end];

            //xml file
            [MarshalAs(UnmanagedType.I4, SizeConst = 1)]
            public int legCount;

            //goal script
            [MarshalAs(UnmanagedType.I4, SizeConst = 1)]
            public int agentIndex;
            [MarshalAs(UnmanagedType.I4, SizeConst = 1)]
            public int goalIndex;
        }

        string strIP = "127.0.0.1";
        int port = 8000;

        //UdpClient udpServer;
        Socket mainSocket;
        List<Socket> connectedClient = new List<Socket>();
        private CSONG csongSize = new CSONG(); //패킷 size 측정용

        CSONG csong;
        byte[] sendData;

        public Server()
        {
            InitializeComponent();
        }

        private void Server_Load(object sender, EventArgs e)
        {
            //udpServer = new UdpClient(port);
            mainSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.IP);
            IPEndPoint serverEP = new IPEndPoint(IPAddress.Any, port);

            mainSocket.Bind(serverEP);
            mainSocket.Listen(10);

            mainSocket.BeginAccept(AcceptCallback, null);

            //데이터 받기
            //int length = socket.Receive(rBuffer, 0, rBuffer.Length, SocketFlags.None);

            //디코딩
            //string result = Encoding.UTF8.GetString(rBuffer);

            //label1.Text = "전송된 데이터 : ";
            //label1.Text += result + "\n";

            checkedListBoxes.Add(state_position_checkedListBox);
            checkedListBoxes.Add(state_rotation_checkedListBox);
            checkedListBoxes.Add(state_velocity_checkedListBox);
            checkedListBoxes.Add(state_angularvelocity_checkedListBox);
            checkedListBoxes.Add(state_joint_angle_checkedListBox);
            checkedListBoxes.Add(state_joint_angularvelocity_checkedListBox);
            checkedListBoxes.Add(state_joint_collisionSensor_checkedListBox);

            stateLabels.Add(state_position_label);
            stateLabels.Add(state_rotation_label);
            stateLabels.Add(state_velocity_label);
            stateLabels.Add(state_angularvelocity_label);
            stateLabels.Add(state_joint_angle_label);
            stateLabels.Add(state_joint_angularvelocity_label);
            stateLabels.Add(state_joint_collisionSensor_label);

            csong = new CSONG();
        }

        byte[] bytes = new byte[1];
        private void update_timer_Tick(object sender, EventArgs e)
        {
            //for (int i = 0; i < connectedClient.Count; i++)
            //{
            //    try
            //    {
            //        connectedClient[i].Receive(bytes); //클라이언트 생존 확인
            //    }
            //    catch (System.Exception ex)
            //    {
            //        RemoveClient(connectedClient[i]);
            //    }
            //}
            
            label3.Text = "Client Count : " + connectedClient.Count;
        }

        private void RemoveClient(Socket client)
        {
            connectedClient.Remove(client); //해당 클라이언트 죽음
            try
            {
                client.Shutdown(SocketShutdown.Both);
                client.Disconnect(true);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        void AcceptCallback(System.IAsyncResult asyncResult)
        {
            try
            {
                //연결 요청 수락
                Socket client = mainSocket.EndAccept(asyncResult);
                client.Send(BitConverter.GetBytes(connectedClient.Count)); //클라 번호 전송
                connectedClient.Add(client);

                //추가 연결 요청 대기
                mainSocket.BeginAccept(AcceptCallback, null);

                //데이터 수신 대기
                AsyncObject asyncObject = new AsyncObject(Marshal.SizeOf(csongSize), client);
                asyncObject.socket.BeginReceive(asyncObject.buffer, 0, asyncObject.bufferSize, 0, DataReceived, asyncObject);
            }
            catch (System.Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        void DataReceived(System.IAsyncResult asyncResult)
        {
            try
            {
                AsyncObject asyncObject = (AsyncObject)asyncResult.AsyncState;

                // 데이터 수신을 끝낸다.
                int received = asyncObject.socket.EndReceive(asyncResult);

                // 받은 데이터가 없으면(연결끊어짐) 끝낸다.
                if (received <= 0)
                {
                    RemoveClient(asyncObject.socket);
                    asyncObject.socket.Close();
                    return;
                }

                string str = Encoding.UTF8.GetString(asyncObject.buffer);
                Console.WriteLine(str);

                asyncObject.ClearBuffer();

                //다시 데이터 수신 대기
                asyncObject.socket.BeginReceive(asyncObject.buffer, 0, asyncObject.bufferSize, 0, DataReceived, asyncObject);
            }
            catch (System.Exception e)
            {
                Console.WriteLine("데이터 수신 실패 : " + e.Message);
            }
        }

        private List<Label> stateLabels = new List<Label>();
        private List<CheckedListBox> checkedListBoxes = new List<CheckedListBox>();
        private void button1_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(send_textBox.Text, out csong.legCount))
                csong.legCount = -1;

            int index = 0;
            for (int i = 0; i < checkedListBoxes.Count; i++)
            {
                for (int j = 0; j < checkedListBoxes[i].Items.Count; j++)
                {
                    //if (checkedListBoxes[i].GetItemChecked(j))
                    //{
                    //    stateString += stateLabels[i].Text + ":";
                    //    stateString += j + ",";
                    //}
                    csong.states[index] = checkedListBoxes[i].GetItemChecked(j);
                    index++;
                }
            }

            if (!int.TryParse(textBoxAgent.Text, out csong.agentIndex))
                csong.agentIndex = -1;
            if (!int.TryParse(textBoxGoal.Text, out csong.goalIndex))
                csong.goalIndex = -1;

            sendData = Serialize(csong);
            for (int i = 0; i < connectedClient.Count; i++)
            {
                try
                {
                    connectedClient[i].Send(sendData);
                }
                catch (Exception ex)
                {
                    //RemoveClient(connectedClient[i]);
                    Console.WriteLine(ex.Message);
                }
            }

            //udpServer.Send(sendData, sendData.Length, remoteEP);
            label3.Text = "Client Count : " + connectedClient.Count;
        }

        private void Server_FormClosed(object sender, FormClosedEventArgs e)
        {
            //udpServer.Close();
            mainSocket.Close();
            for (int i = connectedClient.Count - 1; i >= 0; i--)
            {
                connectedClient[i].Close();
            }
        }

        private void UpdateCheckedStateCount(object sender, EventArgs e)
        {
            state_size_label.Text = string.Format("space size : {0}", GetCheckedStateCount());
        }

        private int GetCheckedStateCount()
        {
            int count = 0;
            for (int i = 0; i < checkedListBoxes.Count; i++)
            {
                int plusCount = 1;
                if (checkedListBoxes[i].Name.Contains("joint_"))
                {
                    int.TryParse(send_textBox.Text, out plusCount);
                    if(!checkedListBoxes[i].Name.Contains("collisionSensor"))
                        plusCount *= 2;
                }

                for (int j = 0; j < checkedListBoxes[i].Items.Count; j++)
                {
                    if (checkedListBoxes[i].GetItemChecked(j))
                        count += plusCount;
                }
            }

            return count;
        }

        //정수만 입력
        private void Only_Digit_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar != '\b')
                e.Handled = !char.IsDigit(e.KeyChar);
        }

        byte[] Serialize(CSONG packet)
        {
            int size = Marshal.SizeOf(packet);
            byte[] arr = new byte[size];

            IntPtr ptr = Marshal.AllocHGlobal(size);
            Marshal.StructureToPtr(packet, ptr, true);
            Marshal.Copy(ptr, arr, 0, size);
            Marshal.FreeHGlobal(ptr);
            return arr;
        }
    }
}
