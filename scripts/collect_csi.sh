#!/bin/bash

#$1 remote bot rx
#$2 remote bot rx username
#$3 remote bot rx ip
#$4 remote bot tx1
#$5 remote bot tx1 username
#$6 remote bot tx1 ip
#$7 remote bot tx2
#$8 remote bot tx2 username
#$9 remote bot tx2 ip
#$10 remote bot tx3
#$11 remote bot tx3 username
#$12 remote bot tx3 ip


dir_path="${HOME}/Adversarial_Hyp/data

#Remove old data
rm -rf $dir_path/csi_rx1.dat
rm -rf $dir_path/csi_tx1.dat
rm -rf $dir_path/csi_tx2.dat
rm -rf $dir_path/csi_tx3.dat
rm -r $dir_path/traj

#Get data from TX Robot
scp -r $5@$6:~/Adversarial_Hyp/data/csi_tx1.dat $dir_path/ &
scp -r $8@$9:~/Adversarial_Hyp/data/csi_tx2.dat $dir_path/ &
scp -r $11@$12:~/Adversarial_Hyp/data/csi_tx3.dat $dir_path/ &

#Get data from RX SAR Robot
scp -r $2@$3:~/Adversarial_Hyp/data/csi_rx1.dat $dir_path/

#Get data from OptiTrack data from Local Machine?
scp -r ~/Adversarial_Hyp/data/traj

sleep 1

#Store as backup with timestamp
echo 'Copying file to back up folder'
timestamp=$(date "+%Y-%m-%d_%H%M%S")
cp $dir_path/csi_rx1.dat $dir_path/backup_data/csi_rx1_$timestamp.dat
cp $dir_path/csi_tx1.dat $dir_path/backup_data/csi_tx1_$timestamp.dat
cp $dir_path/csi_tx2.dat $dir_path/backup_data/csi_tx2_$timestamp.dat
cp $dir_path/csi_tx3.dat $dir_path/backup_data/csi_tx3_$timestamp.dat
cp $dir_path/traj/rx_trajectory.csv $dir_path/traj_backup_data/rx_trajectory_${timestamp}_.csv
cp $dir_path/traj/tx1_trajectory.csv $dir_path/traj_backup_data/tx1_trajectory_${timestamp}_.csv
cp $dir_path/traj/tx2_trajectory.csv $dir_path/traj_backup_data/tx2_trajectory_${timestamp}_.csv
cp $dir_path/traj/tx3_trajectory.csv $dir_path/traj_backup_data/tx3_trajectory_${timestamp}_.csv
