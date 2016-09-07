@echo off
verify on

set DNS1=8.8.8.8
set DNS2=8.8.4.4
set DNS3=2001:4860:4860::8888
set DNS4=2001:4860:4860::8844
for /f "tokens=1,2,3*" %%i in ('netsh int show interface') do (
	if %%i equ Enabled (
		echo "%%l" : %DNS1% + %DNS2% + %DNS3% + %DNS4%
		netsh int ipv4 set dns name="%%l" static %DNS1% primary validate=no
		netsh int ipv4 add dns name="%%l" %DNS2% index=2 validate=no
		netsh int ipv6 set dns name="%%l" static %DNS3% primary validate=no
		netsh int ipv6 add dns name="%%l" %DNS4% index=2 validate=no
	)
)
ipconfig /release
ipconfig /flushdns
ipconfig /renew
cls

echo Click on "Check for problems the next time I start my computer".
start /wait /min ping 127.0.0.1
start /wait mdsched

echo Press "Y" then "Enter".
start /wait /min ping 127.0.0.1
start /wait chkdsk c: /v /r

echo Cick on "Start", then "Ok", then "Close".
start /wait /min ping 127.0.0.1
start /wait sigverif

echo Check everything, then click on "Ok", then "Delete Files".
start /wait /min ping 127.0.0.1
start /wait cleanmgr /d c:

mkdir C:\Windows10Upgrade\
del C:\Windows10Upgrade\Windows10Upgrade.exe
powershell Start-BitsTransfer -Source http://go.microsoft.com/fwlink/?LinkID=799445 -Destination C:\Windows10Upgrade\Windows10Upgrade.exe
wuauclt /resetauthorization
start /wait C:\Windows10Upgrade\Windows10Upgrade.exe

echo Congratulation! Now, let this window run in the background. Do not shutdown the computer.
start /wait /min ping 127.0.0.1

defrag /c /h /u

dism /online /cleanup-image /restorehealth
sfc /scannow
dism /online /cleanup-image /spsuperseded /hidesp
dism /online /cleanup-image /startcomponentcleanup /resetbase

shutdown /r
exit
