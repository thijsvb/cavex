#!/bin/bash
set -v
zipfile="ketai.zip"

if [ ! -e $zipfile ]
then
  wget http://ketailibrary.org/$zipfile
fi

unzip $zipfile

mkdir /sketchbook
mkdir /sketchbook/libraries
cp -a Ketai/. /sketchbook/libraries/
cd sketchbook/libraries
ls
