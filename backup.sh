#!/bin/bash

backup_dir=$HOME/.platformio-backup

if [ ! -d $backup_dir ]; then
    mkdir $backup_dir
fi

backup_platforms_dir=$backup_dir/platforms

if [ ! -d $backup_platforms_dir ]; then
    mkdir $backup_platforms_dir
fi

backup_packages_dir=$backup_dir/packages

if [ ! -d $backup_packages_dir ]; then
    mkdir $backup_packages_dir
fi

platformio_dir=$HOME/.platformio
platformio_packages_dir=$platformio_dir/packages
platformio_platforms_dir=$platformio_dir/platforms


cp -r $platformio_packages_dir/framework-arduinoespressif32 $backup_packages_dir
cp -r $platformio_platforms_dir/espressif32 $backup_platforms_dir