@echo off
powershell Invoke-WebRequest -Uri https://noto-website-2.storage.googleapis.com/pkgs/Noto-hinted.zip -OutFile Noto-hinted.zip
"C:\Program Files\7-Zip\7z.exe" -aoa e Noto-hinted.zip
move /-Y Noto*.ttf Fonts/
move /-Y Noto*.otf Fonts/
exit