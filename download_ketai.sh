#!/bin/bash
set -v
zipfile="ketai.zip"

if [ ! -e $zipfile ]
then
  wget http://ketailibrary.org/$zipfile
fi

unzip $zipfile

cp -a Ketai/. /processing-3.1.1/sketchbook/libraries/
