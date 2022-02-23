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
        self.sub = rospy.Subscriber('run_test_1', Bool, self.callback)
        self.verify_csi_data = Bool()
        self.verify_csi_data.data = True
        rospy.init_node('csi_online_data_test1', anonymous=True)
        self.home_dir = os.path.expanduser('~')
        self.robot_username=robot_un
        self.robot_ip=robot_ip
        self.packet_length=packet_len-28 #To avoid using different packet lengths
        self.tx_node_username=tx_un
        self.tx_node_ip=tx_ip
        self.data_collection_time = ts
        rospy.loginfo("Waiting for new request...")
        rospy.spin()

    def callback(self, msg):
        if msg.data:
            rospy.loginfo("Received new request.")
            rospy.loginfo("Starting Data colletion...")
            subprocess.call(['bash', self.home_dir+'/Harvard_CS286/cs286_mini_hack_2/scripts/start_remote_csi.sh', 
                            self.robot_username,
                            self.robot_ip,
                            self.packet_length,
                            self.tx_node_username,
                            self.tx_node_ip])

            #Wait for 5 seconds to collect data
            rospy.loginfo("Collecting data..")
            time.sleep(self.data_collection_time) 
            
            #Stop remote csi
            subprocess.call(['bash', self.home_dir+'/Harvard_CS286/cs286_mini_hack_2/scripts/stop_remote_csi.sh', 
                            self.robot_username,
                            self.robot_ip,
                            self.tx_node_username,
                            self.tx_node_ip])

            #wait for 1 second
            time.sleep(1)
            rospy.loginfo("Data collection done. Fetching data..")

            #Fetch csi data
            subprocess.call(['bash', self.home_dir+'/Harvard_CS286/cs286_mini_hack_2/scripts/collect_csi.sh', 
                            self.robot_username,
                            self.robot_ip,
                            self.tx_node_username,
                            self.tx_node_ip])

            #wait for 2 seconds
            time.sleep(2)


            #publish on /verify csi topic
            self.pub.publish(self.verify_csi_data)
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
