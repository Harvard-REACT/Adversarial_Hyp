#!/bin/bash

#$1 = remote rx1 username
#$2 = remote rx1 IP
#$3 = packet length
#$4 = remote tx1 username
#$5 = remote tx1 IP
#$6 = remote tx2 username
#$7 = remote tx2 IP
#$8 = remote tx3 username
#$9 = remote tx3 IP


#FOR TX-Node
#bot_dir="/home/$5/catkin_ws/src"
ssh $4@$5 "bash ~/Adversarial_Hyp/scripts/start_csi_logging.sh tx1" &
ssh $6@$7 "bash ~/Adversarial_Hyp/scripts/start_csi_logging.sh tx2" &
ssh $8@$9 "bash ~/Adversarial_Hyp/scripts/start_csi_logging.sh tx3" &


#FOR RX-ROBOT
#bot_dir="/home/$2/catkin_ws/src"
ssh $1@$2 "bash ~/Adversarial_Hyp/scripts/start_csi.sh rx1 $3" & 


