@echo off
cd /d D:/Nato/
echo Installation des programmes pour les postes de travail.
pause

echo Firefox
start https://www.mozilla.org/en-US/firefox/developer/all/?q=French
pause

start "" "D:\Nato\Firefox Developer Edition\firefox.exe"
start /wait /min ping 127.0.0.1 -n 2
start /wait https://adblockplus.org/
start /wait https://adblockplus.org/elemhidehelper
start /wait https://www.libreoffice.org/download/portable-versions/
start /wait https://www.google.com/get/noto/
pause

start D:\Nato\LibreOfficePortable\Data\fonts

del D:\Nato\install.bat
