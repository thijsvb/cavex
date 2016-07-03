#!/bin/bash
zipfile="Ketai.zip"

if [ ! -e $zipfile ]
then
  wget https://github.com/ketai/ketai/raw/master/downloads/$zipfile
fi

tar zxvf $zipfile > /dev/null

cp -a $zipfile/Ketai/. sketchbook/libraries/
