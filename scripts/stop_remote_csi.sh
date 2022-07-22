#!/bin/bash

#$1 = remote rx1 username
#$2 = remote rx1 IP
#$3 = remote tx1 username
#$4 = remote tx1 IP
#$5 = remote tx2 username
#$6 = remote tx2 IP
#$7 = remote tx3 username
#$8 = remote tx3 IP

ssh $1@$2 "bash ~/Adversarial_Hyp/scripts/stop_csi.sh"
ssh $3@$4 "bash ~/Adversarial_Hyp/scripts/stop_csi.sh"
ssh $5@$6 "bash ~/Adversarial_Hyp/scripts/stop_csi.sh"
ssh $7@$8 "bash ~/Adversarial_Hyp/scripts/stop_csi.sh"


