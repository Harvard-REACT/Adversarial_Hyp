#!/bin/bash

#$1 local bot rx
#$2 remote bot tx1
#$3 remote bot tx1 username
#$4 remote bot tx1 ip
#$5 remote bot tx2
#$6 remote bot tx2 username


dir_path="${HOME}/Harvard_CS286/cs286_mini_hack_2/"

#Remove old data
rm -rf $dir_path/csi_rx1.dat
rm -rf $dir_path/csi_tx1.dat

#Get data from TX Robot
scp -r $3@$4:~/Harvard_CS286/cs286_mini_hack_2/csi_tx1.dat $dir_path/ &

#Get data from RX SAR Robot
scp -r $1@$2:~/Harvard_CS286/cs286_mini_hack_2/{csi_rx1.dat, rx_displacement_odom.csv, rx_displacement_t265.csv} $dir_path/ 

sleep 1

#Store as backup with timestamp
echo 'Copying file to back up folder'
timestamp=$(date "+%Y-%m-%d_%H%M%S")
#cp $dir_path/csi_rx1.dat $dir_path/backup_data/csi_rx1_$timestamp.dat
#cp $dir_path/csi_tx1.dat $dir_path/backup_data/csi_tx1_$timestamp.dat
#cp $dir_path/rx_trajectory.csv $dir_path/traj_backup_data/rx_trajectory_${timestamp}_.csv
#cp $dir_path/t265_rx_trajectory.csv $dir_path/traj_backup_data/t265_rx_trajectory_${timestamp}_.csv;
#cp $dir_path/odom_rx_trajectory.csv $dir_path/traj_backup_data/odom_rx_trajectory_${timestamp}_.csv;
