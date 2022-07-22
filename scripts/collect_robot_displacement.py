#!/usr/bin/env python

import rospy
from std_msgs.msg import Bool
import argparse
from nav_msgs.msg import Odometry
import csv
import os
from geometry_msgs.msg import Twist 

class CSI_Tester_Robot:
    def __init__ (self, odom_topic, velocity_topic, motion="linear"):
        self.sub_odom = rospy.Subscriber(odom_topic, Odometry, self.odom_callback)
        self.sub_t265 = rospy.Subscriber('/camera/odom/sample', Odometry, self.t265_callback)
        self.sub = rospy.Subscriber('wsr_move_robot', Bool, self.callback)
        self.pub_vel = rospy.Publisher(velocity_topic, Twist, queue_size=10)
        self.vel = Twist()
        self.start_data_collection = False
        self.motion = motion
        rospy.init_node('collect_robot_data', anonymous=True)
        rospy.loginfo("Waiting for new request...")
        self.odom_displacement=[]
        self.t265_displacement=[]
        self.home_dir = os.path.expanduser('~')
        rospy.spin()

    def odom_callback(self,msg):
        if (self.start_data_collection):
            
            if(self.motion == "linear"):
                self.vel.linear.x=0.2
            else:
                self.vel.angular.z=0.5
            
            self.pub_vel.publish(self.vel)
            temp=[]
            temp.append(msg.header.stamp.secs)
            temp.append(msg.header.stamp.nsecs)
            temp.append(msg.pose.pose.position.x)
            temp.append(msg.pose.pose.position.y)
            temp.append(msg.pose.pose.position.z)
            temp.append(msg.pose.pose.orientation.x)
            temp.append(msg.pose.pose.orientation.y)
            temp.append(msg.pose.pose.orientation.z)
            temp.append(msg.pose.pose.orientation.w)
            temp.append(msg.twist.twist.linear.x)
            temp.append(msg.twist.twist.linear.y)
            temp.append(msg.twist.twist.linear.z)
            temp.append(msg.twist.twist.angular.x)
            temp.append(msg.twist.twist.angular.y)
            temp.append(msg.twist.twist.angular.z)
            self.odom_displacement.append(temp)
            #start recording data to an array

    def t265_callback(self,msg):
        if (self.start_data_collection):
            temp=[]
            temp.append(msg.header.stamp.secs)
            temp.append(msg.header.stamp.nsecs)
            temp.append(msg.pose.pose.position.x)
            temp.append(msg.pose.pose.position.y)
            temp.append(msg.pose.pose.position.z)
            temp.append(msg.pose.pose.orientation.x)
            temp.append(msg.pose.pose.orientation.y)
            temp.append(msg.pose.pose.orientation.z)
            temp.append(msg.pose.pose.orientation.w)
            temp.append(msg.twist.twist.linear.x)
            temp.append(msg.twist.twist.linear.y)
            temp.append(msg.twist.twist.linear.z)
            temp.append(msg.twist.twist.angular.x)
            temp.append(msg.twist.twist.angular.y)
            temp.append(msg.twist.twist.angular.z)
            self.t265_displacement.append(temp)


    def callback(self, msg):
        if msg.data:
            print("Got new request")
            self.start_data_collection = True
        else:
            self.start_data_collection = False
            self.pub_vel.publish(Twist())
            with open(self.home_dir+'/Adversarial_Hyp/data/traj/rx_displacement_odom.csv','w') as f:
                write = csv.writer(f)
                write.writerows(self.odom_displacement)

            with open(self.home_dir+'/Adversarial_Hyp/data/traj/rx_displacement_t265.csv','w') as f:
                write = csv.writer(f)
                write.writerows(self.t265_displacement)

            self.odom_displacement=[]
            self.t265_displacement=[]
            print("Collected robot displacement data.")
            print("Waiting for new request")
            

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Get the inputs.')
    parser.add_argument('--position_topic', type=str)
    parser.add_argument('--velocity_topic', type=str)
    parser.add_argument('--motion', type=str)
    args = parser.parse_args()
    try:
        CSI_Tester_Robot(args.position_topic,args.velocity_topic,args.motion)
    except rospy.ROSInterruptException:
        pass
