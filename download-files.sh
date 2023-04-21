#!/bin/bash

filename=XIAO_ESP32S3_Package.zip
url=https://files.seeedstudio.com/wiki/SeeedStudio-XIAO-ESP32S3/img/$filename

if [ ! -d downloads ]; then
    mkdir downloads
fi

curl --output downloads/$filename 
pushd downloads && unzip $filename && popd