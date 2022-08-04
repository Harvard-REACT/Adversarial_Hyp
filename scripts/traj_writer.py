#!/usr/bin/env python

import rospy
from natnet_pkg import PoseArrayID
import argparse
import os

class Write_Trajectory:
    def __init__ (self,bot_id):
        self.sub_write_trajectory = rospy.Subscriber('optitrack_pose', PoseArrayID, self.write_traj_to_cvs)
	self.os.path.expanduser('~')
	self.file_name = "/placeholder"
        self.bot_id = bot_id
        rospy.init_node('trajectory_writer_node')


        rospy.spin()
        
    def write_traj_to_cvs(self, msg):
        if msg.data:
	    for i in range(msg.poses.size()):
	    	if(msg.poses[i].ID == self.bot_id):
            	    nsec_timestamp = msg.header.stamp.sec*1e9 + msg.header.stamp.nsec - msg.latency
            	    data = [nsec_timestamp*1e-9,0,msg.poses[i].position.x,msg.poses[i].position.y,msg.poses[i].position.z]
		    

if __name__ == '__main__':
    try:
        parser = argparse.ArgumentParser(description='Get the inputs.')
        parser.add_argument('--bot_id', type=int)
        args = parser.parse_args()
        Write_Trajectory(args.bot_id)
    except rospy.ROSInterruptException:
        pass
