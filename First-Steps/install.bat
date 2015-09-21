@echo off
mkdir C:\Nato\
bitsadmin /transfer Update ^ https://raw.githubusercontent.com/NatoBoram/Update/master/First-Steps/firstrun.bat C:\Nato\install.bat
start C:\Nato\install.bat
exit
