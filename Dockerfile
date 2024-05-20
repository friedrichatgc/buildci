# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2019

ENV HOME=/home/user

# install msys2
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
  Invoke-WebRequest -UseBasicParsing -uri "https://github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-base-x86_64-latest.sfx.exe" -OutFile msys2.exe; `
  .\msys2.exe -y -oC:\; `
  Remove-Item msys2.exe ; `
  function msys() { C:\msys64\usr\bin\bash.exe @('-lc') + @Args; } `
  msys ' '; `
  msys 'pacman -h';

ENV MSYSTEM=UCRT64 CHERE_INVOKING=yes
SHELL ["c:\\msys64\\usr\\bin\\bash.exe", "-l", "-c"]

RUN "pacman --noconfirm -S unzip"

RUN "wget https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/MinGit-2.43.0-64-bit.zip && `
  unzip -d /c/git MinGit-2.43.0-64-bit.zip && rm -f MinGit-2.43.0-64-bit.zip"
RUN "echo 'PATH=\"$PATH:/c/git/mingw64/bin\"' >> ~/.bash_profile"

# install msys2 using pacman
RUN "pacman --noconfirm -S mingw-w64-ucrt-x86_64-python"

RUN "mkdir /context"
COPY entrypoint.py c:/msys64/context/entrypoint.py
COPY entrypoint_msys2.bat c:/msys64/context/entrypoint_msys2.bat

CMD []
USER ContainerUser
#ENTRYPOINT ["c:/msys64/ucrt64/bin/python3"]
RUN ls -l /ucrt64/bin
RUN ls /context
ENTRYPOINT ["c:/msys64/context/entrypoint_msys2.bat", "/ucrt64/bin/python3", "/context/entrypoint.py"]
