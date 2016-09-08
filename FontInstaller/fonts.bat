@Echo Off
CD %UserProfile%/Downloads
MkDir Fonts

REM Google
Start PowerShell "Start-BitsTransfer -Source https://codeload.github.com/google/fonts/zip/master -Destination Google.zip; Expand-Archive Google.zip -dest Google; Remove-Item Google.zip; Get-ChildItem -Path Google -Filter *.ttf -Recurse | Move-Item -Destination Fonts -Force; Remove-Item Google -Recurse;"

REM Noto
Start PowerShell "Start-BitsTransfer -Source https://noto-website-2.storage.googleapis.com/pkgs/Noto-hinted.zip -Destination Noto.zip; Expand-Archive Noto.zip -dest Noto; Remove-Item Noto.zip; Get-ChildItem -Path Noto -Filter *.ttf -Recurse | Move-Item -Destination Fonts -Force; Remove-Item Noto -Recurse;"

REM Comic Neue
Start PowerShell "Start-BitsTransfer -Source http://comicneue.com/comic-neue-2.2.zip -Destination ComicNeue.zip; Expand-Archive ComicNeue.zip -dest ComicNeue; Remove-Item ComicNeue.zip; Get-ChildItem -Filter *MACOSX* -Recurse | Remove-Item -Recurse; Get-ChildItem -Path ComicNeue -Filter *.otf -Recurse | Move-Item -Destination Fonts -Force; Remove-Item ComicNeue -Recurse;"

Exit