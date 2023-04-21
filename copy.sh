#!/bin/bash

platformio_dir=$HOME/.platformio
arduino_esp32_dir=$platformio_dir/packages/framework-arduinoespressif32
esp32_dir=$platformio_dir/platforms/espressif32

cp seeed_xiao_esp32s3.json $esp32_dir/boards
cp -r downloads/boards.txt $arduino_esp32_dir
cp -r downloads/XIAO_ESP32S3 $arduino_esp32_dir/variants