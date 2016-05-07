@echo off

cd %USERPROFILE%/Desktop
mkdir FontInstaller
cd FontInstaller
mkdir Fonts

powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/NatoBoram/Update/master/FontInstaller/google.bat -OutFile google.bat
powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/NatoBoram/Update/master/FontInstaller/noto.bat -OutFile noto.bat

start google.bat
start noto.bat

exit