sfc /scannow
dism /online /cleanup-image /checkhealth
dism /online /cleanup-image /scanhealth
dism /online /cleanup-image /restorehealth /source:wim:F:\sources\install.wim:1
sfc /scannow
dism /online /cleanup-image /spsuperseded /hidesp
dism /online /cleanup-image /startcomponentcleanup /resetbase
sfc /scannow
shutdown /r