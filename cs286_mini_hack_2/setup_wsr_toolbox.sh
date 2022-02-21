#!/bin/bash


echo "Installing Boost"

cd ~/Downloads
#wget http://downloads.sourceforge.net/project/boost/boost/1.68.0/boost_1_68_0.tar.gz
tar -zxvf boost_1_68_0.tar.gz
cd boost_1_68_0/
./bootstrap.sh
cpuCores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | awk '{print $NF}'`
sudo ./b2 --with=all -j $cpuCores

echo "Installing Python packages"
sudo apt install python-catkin-tools python-pip git vim -y
pip install Cython setuptools numpy pybind11 scipy pandas matplotlib

echo "Installing WSR Toolbox"
cd ~/
#mkdir -p cs286_hack_ws/src
cd ~/cs286_hack_ws/src
#git clone https://github.com/Harvard-REACT/WSR-Toolbox-cpp.git
cd WSR-Toolbox-cpp
git checkout wsr-melodic
python setup.py build_ext --inplace

echo "Building workspace"
cd ~/cs286_hack_ws/
catkin build
echo "source ~/cs286_hack_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

cd ~/

echo "All Packages are Installed."
