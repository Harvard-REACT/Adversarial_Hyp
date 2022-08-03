#!/bin/bash

#$1 = local BotID
#$2 = number of tx robots

echo "abc123" | sudo -S ${HOME}/WSR-Toolbox-linux-80211n-csitool-supplementary/netlink/log_to_file ${HOME}/Adversarial_Hyp/data/csi_$1.dat &

#sleep 0.5

echo "abc123" | sudo -S ${HOME}/WSR-Toolbox-linux-80211n-csitool-supplementary/injection_multiple/random_packets_multiple 10000 35 1 7500 $2 & #Only send forward packets
