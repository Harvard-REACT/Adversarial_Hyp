#!/bin/bash

#$1 = local BotID

echo "abc123" | sudo -S ${HOME}/WSR-Toolbox-linux-80211n-csitool-supplementary/netlink/log_to_file ${HOME}/Adversarial_Hyp/data/csi_$1.dat &


