@echo off
mkdir C:\Nato\
cd /d C:\Nato\
bitsadmin /transfer Update ^ https://raw.githubusercontent.com/NatoBoram/Update/master/First-Steps/firstrun.bat install.bat
start install.bat
exit
