@echo off

set "platformio_dir=%USERPROFILE%\.platformio"
set "arduino_esp32_dir=%platformio_dir%\packages\framework-arduinoespressif32"
set "esp32_dir=%platformio_dir%\platforms\espressif32"

copy seeed_xiao_esp32s3.json "%esp32_dir%\boards"
xcopy /E /Y downloads\boards.txt "%arduino_esp32_dir%"
xcopy /E /Y downloads\XIAO_ESP32S3 "%arduino_esp32_dir%\variants"
