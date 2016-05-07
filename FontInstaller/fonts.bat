@echo off

cd %USERPROFILE%/Desktop
mkdir FontInstaller
cd FontInstaller
mkdir Fonts

powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/NatoBoram/Update/master/FontInstaller/noto.bat -OutFile noto.bat
start noto.bat

powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/NatoBoram/Update/master/FontInstaller/google.bat -OutFile google.bat
start google.bat