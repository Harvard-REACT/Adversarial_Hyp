#!/usr/bin/env python

import rospy
from std_msgs.msg import Bool
import subprocess
import time
import argparse
import os

class CSI_Tester:
    def __init__ (self, robot_un, robot_ip, tx_un, tx_ip, packet_len, ts=3):
        self.pub = rospy.Publisher('verify_csi', Bool, queue_size=10)
        self.pub_aoa = rospy.Publisher('get_aoa', Bool, queue_size=10)
        self.pub_robot = rospy.Publisher('wsr_move_robot', Bool, queue_size=10)
        self.sub = rospy.Subscriber('/run_test_2', Bool, self.callback)
        self.verify_csi_data = Bool()
        self.verify_csi_data.data = True
        self.move_robot = Bool()
        rospy.init_node('csi_online_data_test2', anonymous=True)
        self.home_dir = os.path.expanduser('~')
        self.robot_username=robot_un
        self.robot_ip=robot_ip
        self.packet_length=str(int(packet_len)-28) #To aviod using different values
        self.tx_node_username=tx_un
        self.tx_node_ip=tx_ip
        self.data_collection_time = ts
        rospy.loginfo("Waiting for new request...")
        rospy.spin()

    def callback(self, msg):
        if msg.data:
            rospy.loginfo("Received new request.")
            rospy.loginfo("Starting Data colletion...")
            subprocess.call(['bash', self.home_dir+'/Adversarial_Hyp/scripts/start_remote_csi.sh', 
                            self.robot_username,
                            self.robot_ip,
                            self.packet_length,
                            self.tx_node_username,
                            self.tx_node_ip])

            #Wait for 5 seconds to collect data
            rospy.loginfo("Collecting data..")
            #Trigger robot motion
            self.move_robot.data = True
            self.pub_robot.publish(self.move_robot)
            rospy.loginfo("Robot should start moving")
            time.sleep(self.data_collection_time) 
            
            #Stop robot motion
            self.move_robot.data = False
            self.pub_robot.publish(self.move_robot)
            rospy.loginfo("Robot should stop moving")
            
            #Stop remote csi
            subprocess.call(['bash', self.home_dir+'/Adversarial_Hyp/scripts/stop_remote_csi.sh', 
                            self.robot_username,
                            self.robot_ip,
                            self.tx_node_username,
                            self.tx_node_ip])

            #wait for 1 second
            time.sleep(1)
            rospy.loginfo("Data collection done. Fetching data..")

            #Fetch csi data
            subprocess.call(['bash', self.home_dir+'/Adversarial_Hyp/scripts/collect_csi.sh', 
                            self.robot_username,
                            self.robot_ip,
                            self.tx_node_username,
                            self.tx_node_ip])

            #wait for 2 seconds
            time.sleep(2)


            #publish on /verify csi topic
            self.pub.publish(self.verify_csi_data)
            self.pub_aoa.publish(self.verify_csi_data)
            rospy.loginfo("Passing data to WSR Toolbox for verification...")

            time.sleep(10)
            rospy.loginfo("Waiting for new data collection request")

if __name__ == '__main__':
    try:
        parser = argparse.ArgumentParser(description='Get the inputs.')
        parser.add_argument('--robot_username', type=str)
        parser.add_argument('--robot_ip', type=str)
        parser.add_argument('--tx_username', type=str)
        parser.add_argument('--tx_ip', type=str)
        parser.add_argument('--packet_len', type=str)
        parser.add_argument('--ts', type=int)
        args = parser.parse_args()
        CSI_Tester(args.robot_username, args.robot_ip, 
                   args.tx_username, args.tx_ip, args.packet_len,
                   args.ts)
    except rospy.ROSInterruptException:
        pass
