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
sudo mkdir ~/sketchbook/libraries/ketai
sudo cp -a Ketai/. ~/sketchbook/libraries/ketai
cd ~/sketchbook/libraries
ls
