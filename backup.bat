@echo off

set "backup_dir=%USERPROFILE%\.platformio-backup"

if not exist "%backup_dir%" (
    mkdir "%backup_dir%"
)

set "backup_platforms_dir=%backup_dir%\platforms"

if not exist "%backup_platforms_dir%" (
    mkdir "%backup_platforms_dir%"
)

set "backup_packages_dir=%backup_dir%\packages"

if not exist "%backup_packages_dir%" (
    mkdir "%backup_packages_dir%"
)

set "platformio_dir=%USERPROFILE%\.platformio"
set "platformio_packages_dir=%platformio_dir%\packages"
set "platformio_platforms_dir=%platformio_dir%\platforms"

xcopy /E /Y "%platformio_packages_dir%\framework-arduinoespressif32" "%backup_packages_dir%"
xcopy /E /Y "%platformio_platforms_dir%\espressif32" "%backup_platforms_dir%"
