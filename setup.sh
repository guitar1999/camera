#!/bin/bash

username=$1

sudo apt install motion libav-tools
sudo usermod -a -G video $username
sudo usermod -a -G motion $username
sudo mkdir /var/local/motion
sudo chown motion:motion /var/local/motion
sudo chmod g+w /var/local/motion
sudo echo "bcm2835-v4l2" | tee -a /etc/modules

sudo pip install awscli
aws configure
