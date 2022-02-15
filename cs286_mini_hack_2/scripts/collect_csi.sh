#!/bin/bash

#$1 local bot rx
#$2 remote bot tx1
#$3 remote bot tx1 username
#$4 remote bot tx1 ip
#$5 remote bot tx2
#$6 remote bot tx2 username
#$7 remote bot tx2 ip
#$8 remote bot tx3
#$9 remote bot tx3 username
#$10 remote bot tx3 ip
#$11 remote bot tx4 
#$12 remote bot tx4 username
#$13 remote bot tx4 ip
#$14 remote bot tx5 
#$15 remote bot tx4 username
#$16 remote bot tx4 ip


dir_path="${HOME}/Harvard_CS286/cs286_mini_hack_2/"

#Get data from RX SAR Robot
scp -r $1@$2:~/Harvard_CS286/cs286_mini_hack_2/csi_rx1.dat $dir_path/


#Get data from TX Robot
scp -r $3@$4:~/Harvard_CS286/cs286_mini_hack_2/csi_tx1.dat $dir_path/

sleep 1

#Store as backup with timestamp
echo 'Copying file to back up folder'
timestamp=$(date "+%Y-%m-%d_%H%M%S")
#cp $dir_path/csi_rx1.dat $dir_path/backup_data/csi_rx1_$timestamp.dat
#cp $dir_path/csi_tx1.dat $dir_path/backup_data/csi_tx1_$timestamp.dat
#cp $dir_path/rx_trajectory.csv $dir_path/traj_backup_data/rx_trajectory_${timestamp}_.csv
#cp $dir_path/t265_rx_trajectory.csv $dir_path/traj_backup_data/t265_rx_trajectory_${timestamp}_.csv;
#cp $dir_path/odom_rx_trajectory.csv $dir_path/traj_backup_data/odom_rx_trajectory_${timestamp}_.csv;
