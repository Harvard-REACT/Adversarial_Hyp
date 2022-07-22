#!/usr/bin/env python

import rospy
from std_msgs.msg import Bool
import subprocess
import time
import argparse
import os

class Alpha_Calculator:
    def __init__ (self, tx_un):
        self.pub_change_alpha_flag = rospy.Publisher('alpha_flag', Bool, queue_size=10)    
        self.sub_start_alpha_calculation = rospy.Subscriber('start_alpha_calculation', Bool, self.calculate_alpha)
        rospy.loginfo("Waiting for new request...")
        rospy.spin()
        
    def calculate_alpha(self, msg):
        if msg.data:
            rospy.loginfo("Starting alpha calculation...")
            time.sleep(30) 
            rospy.loginfo("Alpha collection done.")
            self.pub_change_alpha_flag.publish(True)
            
                

if __name__ == '__main__':
    try:
        parser = argparse.ArgumentParser(description='Get the inputs.')
        parser.add_argument('--tx_username', type=str)
        args = parser.parse_args()
        Alpha_Calculator(args.tx_username)
    except rospy.ROSInterruptException:
        pass
