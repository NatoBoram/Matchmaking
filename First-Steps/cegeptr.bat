@echo off
echo Installation des programmes pour les postes de travail.
pause

start https://www.mozilla.org/en-US/firefox/developer/all/?q=French
pause

start "" "D:\Nato\Firefox Developer Edition\firefox.exe"
start /min /wait ping 127.0.0.1 -n 2
start https://adblockplus.org/
start https://adblockplus.org/elemhidehelper
start https://www.libreoffice.org/download/portable-versions/
start https://www.google.com/get/noto/
pause

start D:\Nato\LibreOfficePortable\Data\fonts

start del D:\Nato\install.bat
exit
