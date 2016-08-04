#!/bin/bash
set -v
zipfile="ketai.zip"

if [ ! -e $zipfile ]
then
  wget http://ketailibrary.org/$zipfile
fi

unzip $zipfile > /dev/null

sudo mkdir ~/sketchbook
sudo mkdir ~/sketchbook/libraries
sudo mkdir ~/sketchbook/libraries/Ketai
sudo cp -a Ketai/. ~/sketchbook/libraries/Ketai
cd ~/sketchbook/libraries
ls
