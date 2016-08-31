@echo off
echo Installation des programmes pour les postes de travail du Cégep de Trois-Rivières.
pause

start https://www.mozilla.org/en-US/firefox/developer/all/?q=French
pause

start "" "D:\Nato\Firefox Developer Edition\firefox.exe"
start /wait /min ping 127.0.0.1 -n 2
start /wait https://adblockplus.org/
start /wait https://adblockplus.org/elemhidehelper/
start /wait https://www.libreoffice.org/download/portable-versions/
start /wait https://www.google.com/get/noto/
start /wait https://github.com/google/fonts/
pause

start "" "D:\Nato\Firefox Developer Edition\firefox.exe"
start /wait https://web.skype.com/
start /wait https://discordapp.com/
pause

start D:\Nato\LibreOfficePortable\Data\fonts

del D:\Nato\install.bat
