$filename = "XIAO_ESP32S3_Package.zip"
$url = "https://files.seeedstudio.com/wiki/SeeedStudio-XIAO-ESP32S3/img/$filename"

if (!(Test-Path "downloads")) {
    New-Item -ItemType Directory -Path "downloads"
}

Invoke-WebRequest -Uri $url -OutFile "downloads\$filename"
Set-Location "downloads"; Expand-Archive "$filename"; Set-Location ".."
