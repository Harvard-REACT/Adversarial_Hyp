#!/bin/bash

sudo apt install ros-$ROS_DISTRO-libg2o ros-$ROS_DISTRO-libpointmatcher ros-$ROS_DISTRO-joint-state-publisher-gui ros-$ROS_DISTRO-pcl-ros python-catkin-tools ros-$ROS_DISTRO-turtlebot3-description -y

sudo apt remove ros-$ROS_DISTRO-rtabmap-ros ros-$ROS_DISTRO-rtabmap -y

mkdir -p cs286_hack_ws/src 

cd ~/cs286_hack_ws
catkin build 
echo "source ~/cs286_hack_ws/devel/setup.bash" >> ~/.bashrc

cd ~/
cpuCores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | awk '{print $NF}'`
source /opt/ros/$ROS_DISTRO/setup.bash
source ~/cs286_hack_ws/devel/setup.bash


echo "Downloading Rtabmap..........."
cd ~/Downloads
git clone https://github.com/introlab/rtabmap.git rtabmap

echo "Compiling Rtabmap..........."
cd rtabmap && git checkout 0.20.7-kinetic
cd build && cmake ..
make -j$cpuCores
echo "Installing Rtabmap..........."
sudo make install 

echo "Downloading Rtabmap_ROS..........."
cd ~/cs286_hack_ws
git clone  https://github.com/introlab/rtabmap_ros.git src/rtabmap_ros
cd src/rtabmap_ros 
git checkout 0.20.7-kinetic


echo "Downloading Harvard_CS286 Repo"
cd ~/
git clone https://github.com/Harvard-REACT/Harvard_CS286
cp -r ~/Harvard_CS286/cs286_mini_hack_3/interbotix_xslocobot_descriptions ~/cs286_hack_ws/src/


echo "catkin build packages..........."
cd ~/cs286_hack_ws
rosdep install --from-paths src --ignore-src -r -y
source ~/.bashrc
catkin build
echo "All Packages are Installed."

cd ~/
source ~/.bashrc

sudo apt remove ros-$ROS_DISTRO-rtabmap -y
source ~/.bashrc

