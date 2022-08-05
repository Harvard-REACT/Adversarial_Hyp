#!/bin/bash

#$1 remote bot rx username
#$2 remote bot rx ip
#$3 remote bot tx1 username
#$4 remote bot tx1 ip
#$5 remote bot tx2 username
#$6 remote bot tx2 ip
#$7 remote bot tx3 username
#$8 remote bot tx3 ip


dir_path="${HOME}/Adversarial_Hyp/data"

#Remove old data
rm -rf $dir_path/csi_rx1.dat
rm -rf $dir_path/csi_tx1.dat
rm -rf $dir_path/csi_tx2.dat
rm -rf $dir_path/csi_tx3.dat
rm -rf $dir_path/rx_traj.csv

#Get data from TX Robot
scp -r $3@$4:~/Adversarial_Hyp/data/csi_tx1.dat $dir_path/ &
scp -r $5@$6:~/Adversarial_Hyp/data/csi_tx2.dat $dir_path/ &
scp -r $7@$8:~/Adversarial_Hyp/data/csi_tx3.dat $dir_path/ &

#Get data from RX SAR Robot
scp -r $1@$2:~/Adversarial_Hyp/data/csi_rx1.dat $dir_path/ &
scp -r $1@$2:~/Adversarial_Hyp/data/rx_traj.csv $dir_path/

sleep 1

#Store as backup with timestamp
echo 'Copying file to back up folder'
timestamp=$(date "+%Y-%m-%d_%H%M%S")
cp $dir_path/csi_rx1.dat $dir_path/backup_data/csi_rx1_$timestamp.dat
cp $dir_path/csi_tx1.dat $dir_path/backup_data/csi_tx1_$timestamp.dat
cp $dir_path/csi_tx2.dat $dir_path/backup_data/csi_tx2_$timestamp.dat
cp $dir_path/csi_tx3.dat $dir_path/backup_data/csi_tx3_$timestamp.dat
cp $dir_path/rx_traj.csv $dir_path/backup_data/rx_traj_${timestamp}_.csv
