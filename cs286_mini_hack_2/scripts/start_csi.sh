#!/bin/bash

#$1 = local BotID

echo "abc123" | sudo -S ${HOME}/WSR-Toolbox-linux-80211n-csitool-supplementary/netlink/log_to_file ${HOME}/Harvard_CS286/cs286_mini_hack_2/csi_$1.dat &

sleep 0.5

echo "abc123" | sudo -S ${HOME}/WSR-Toolbox-linux-80211n-csitool-supplementary/injection_bak/random_packets 10000 29 1 7500 & #Only send forward packets
