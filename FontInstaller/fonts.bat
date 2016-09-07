@Echo Off
CD %UserProfile%/Downloads
Start PowerShell Start-BitsTransfer -Source https://codeload.github.com/google/fonts/zip/master -Destination Google.zip; Expand-Archive Google.zip -dest Google; Remove-Item Google.zip
Start PowerShell Start-BitsTransfer -Source https://noto-website-2.storage.googleapis.com/pkgs/Noto-hinted.zip -Destination Noto.zip; Expand-Archive Noto.zip -dest Noto; Remove-Item Noto.zip
Start PowerShell Start-BitsTransfer -Source http://comicneue.com/comic-neue-2.2.zip -Destination ComicNeue.zip; Expand-Archive ComicNeue.zip -dest ComicNeue; Remove-Item ComicNeue.zip
Exit