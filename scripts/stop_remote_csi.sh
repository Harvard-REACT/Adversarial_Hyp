#!/bin/bash

#$1 = remote rx1 username
#$2 = remote rx1 IP
#$3 = remote tx1 username
#$4 = remote tx1 IP

ssh $1@$2 "bash ~/Harvard_CS286/cs286_mini_hack_2/scripts/stop_csi.sh"
ssh $3@$4 "bash ~/Harvard_CS286/cs286_mini_hack_2/scripts/stop_csi.sh"


