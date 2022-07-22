#!/bin/bash

#$1 = local BotID
#$2 = packet length, default = 29

echo "abc123" | sudo -S ${HOME}/WSR-Toolbox-linux-80211n-csitool-supplementary/netlink/log_to_file ${HOME}/Adversarial_Hyp/data/csi_$1.dat &

sleep 0.5

echo "abc123" | sudo -S ${HOME}/WSR-Toolbox-linux-80211n-csitool-supplementary/injection_bak/random_packets 10000 $2 1 7500 & #Only send forward packets
