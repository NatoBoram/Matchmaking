@echo off

powershell Invoke-WebRequest -Uri https://noto-website-2.storage.googleapis.com/pkgs/Noto-hinted.zip -OutFile Noto-hinted.zip

"C:\Program Files\7-Zip\7z.exe" -aoa e Noto-hinted.zip

del Noto-hinted.zip
del LICENSE_OFL.txt

move /-Y Noto*.ttf Fonts/
move /-Y Noto*.otf Fonts/

start fonts\

exit