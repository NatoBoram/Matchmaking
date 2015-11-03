@echo off
set x=5
echo Installation des premiers logiciels sur un nouvel appareil.
pause

echo Mozilla
start "" "https://www.mozilla.org/en-US/firefox/developer/all/?q=French"
pause

echo AdBlockPlus
start firefox
start /wait /min ping 127.0.0.1 -n %x%
start "" "https://adblockplus.org/"
start "" "https://adblockplus.org/elemhidehelper"
pause

echo Microsoft
start firefox
start /wait /min ping 127.0.0.1 -n %x%
start "" "https://www.microsoft.com/fr-ca/download/confirmation.aspx?id=35"
start "" "http://www.microsoft.com/en-us/download/details.aspx?id=30679"
start "" "http://www.microsoft.com/fr-ca/download/details.aspx?id=44928"
start "" "http://www.microsoft.com/silverlight/"
pause

echo Adobe
start firefox
start /wait /min ping 127.0.0.1 -n %x%
start "" "https://get.adobe.com/fr/reader/"
start "" "https://get.adobe.com/fr/flashplayer/"
start "" "https://get.adobe.com/fr/air/"
start "" "https://get.adobe.com/fr/shockwave/"
pause

echo Java
start firefox
start /wait /min ping 127.0.0.1 -n %x%
start "" "http://java.com/fr/download/manual.jsp"
pause

echo Apple
start firefox
start /wait /min ping 127.0.0.1 -n %x%
start "" "http://www.apple.com/quicktime/download/"
pause

echo Web Plugin
start firefox
start /wait /min ping 127.0.0.1 -n %x%
start "" "https://skypewebexperience.skype.com/content/3-14-1793/plugin_installation.html"
start "" "https://www.google.com/tools/dlpage/hangoutplugin/"
pause

echo Applications
start firefox
start /wait /min ping 127.0.0.1 -n %x%
start "" "http://free.avg.com/ca-fr/free-antivirus-download"
start "" "https://www.piriform.com/ccleaner/download"
start "" "http://www.dvdvideosoft.com/"
start "" "http://www.gimp.org/downloads/"
start "" "http://www.apple.com/itunes/download/"
start "" "https://www.magicaljellybean.com/keyfinder/"
start "" "https://notepad-plus-plus.org/"
start "" "http://www.libreoffice.org/download/libreoffice-fresh/?type=win-x86_64&lang=fr"
start "" "http://www.skype.com/fr/download-skype/skype-for-computer/"
start "" "https://www.teamviewer.com/"
start "" "http://www.videolan.org/vlc/download-windows.html"
start "" "http://www.win-rar.com/predownload.html?&Version=64bit"
pause

echo Games
start firefox
start /wait /min ping 127.0.0.1 -n %x%
start "" "https://us.battle.net/account/download/"
start "" "http://www.cheatengine.org/"
start "" "http://na.leagueoflegends.com/"
start "" "https://lolupdater.com/?p=download"
start "" "https://minecraft.net/download"
start "" "http://store.steampowered.com/about/"
start "" "http://www.systemrequirementslab.com/cyri"
start "" "http://www.teamspeak.com/downloads"
pause

echo Computer Tools
start firefox
start /wait /min ping 127.0.0.1 -n %x%
start "" "http://www.linuxliveusb.com/fr/download"
start "" "http://www.speedguide.net/downloads.php"
start "" "https://www.virtualbox.org/"
start "" "https://www.wireshark.org/#download"
start "" "http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html"
start "" "http://www.oracle.com/technetwork/java/javase/downloads/index.html"
start "" "http://www.autohotkey.com/"
start "" "https://eclipse.org/downloads/"
start "" "https://filezilla-project.org/download.php"
start "" "http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html"
start "" "http://adam.denadai.free.fr/index.php?page=Download"
start "" "https://desktop.github.com/"
start "" "http://www.wampserver.com/"
start "" "https://www.python.org/downloads/"
pause

del C:\Nato\install.bat