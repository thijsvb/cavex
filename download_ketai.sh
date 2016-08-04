#!/bin/bash
set -v
zipfile="ketai.zip"

if [ ! -e $zipfile ]
then
  wget http://ketailibrary.org/$zipfile
fi

unzip $zipfile > /dev/null

sudo mkdir /sketchbook
sudo mkdir /sketchbook/libraries
sudo cp -a Ketai/. /sketchbook/libraries/
cd sketchbook/libraries
ls
