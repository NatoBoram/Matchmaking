@echo off
echo Installation des premiers logiciels sur un nouvel appareil.
pause

echo Mozilla
start https://www.mozilla.org/en-US/firefox/developer/all/?q=French
pause

echo AdBlockPlus
start firefox
start /wait /min ping 127.0.0.1 -n 2
start https://adblockplus.org/
start https://adblockplus.org/elemhidehelper
pause

echo Microsoft
start firefox
start /wait /min ping 127.0.0.1 -n 2
start https://www.microsoft.com/fr-ca/download/details.aspx?id=35
start http://www.microsoft.com/fr-ca/download/details.aspx?id=44928
start http://www.microsoft.com/silverlight/
pause

echo Adobe
start firefox
start /wait /min ping 127.0.0.1 -n 2
start https://get.adobe.com/fr/reader/
start https://get.adobe.com/fr/flashplayer/
start https://get.adobe.com/fr/air/
start https://get.adobe.com/fr/shockwave/
pause

echo Java
start firefox
start /wait /min ping 127.0.0.1 -n 2
start http://java.com/fr/download/manual.jsp
pause

echo Apple
start firefox
start /wait /min ping 127.0.0.1 -n 2
start http://www.apple.com/quicktime/download/
pause

echo Applications
start firefox
start /wait /min ping 127.0.0.1 -n 2
start http://free.avg.com/ca-fr/free-antivirus-download
start https://www.piriform.com/ccleaner/download
start http://www.dvdvideosoft.com/
start http://www.apple.com/itunes/download/
start https://www.magicaljellybean.com/keyfinder/
start https://notepad-plus-plus.org/
start http://www.libreoffice.org/download/libreoffice-fresh/?type=win-x86_64&lang=fr
start http://www.skype.com/fr/download-skype/skype-for-computer/
start https://www.teamviewer.com/
start https://www.virtualbox.org/
start http://www.videolan.org/vlc/download-windows.html
start http://www.win-rar.com/predownload.html?&Version=64bit
pause

echo Games
start firefox
start /wait /min ping 127.0.0.1 -n 2
start https://us.battle.net/account/download/
start http://www.cheatengine.org/
start http://na.leagueoflegends.com/
start https://lolupdater.com/?p=download
start https://minecraft.net/download
start http://store.steampowered.com/about/
start http://www.systemrequirementslab.com/cyri
start http://www.teamspeak.com/downloads
pause

start del D:\Nato\install.bat
