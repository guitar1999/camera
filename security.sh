#!/bin/bash

raspistill -w 800 -h 600 -q 50 -t 1000 -o /home/jessebishop/camera.jpg -hf -vf -ex 'night'

