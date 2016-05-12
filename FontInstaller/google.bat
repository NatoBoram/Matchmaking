@echo off
powershell Invoke-WebRequest -Uri https://codeload.github.com/google/fonts/zip/master -OutFile fonts-master.zip
"C:\Program Files\7-Zip\7z.exe" -aos e fonts-master.zip
move /Y *.ttf Fonts/

move Fonts ..
cd ..
start Fonts
rd /s /q FontInstaller
exit