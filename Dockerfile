# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2019

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

RUN "pacman --noconfirm -S mingw-w64-ucrt-x86_64-7zip"

# Install mesa for software OpenGL (only needed to run GUI programs in VMs)
RUN "mkdir mesa && cd mesa && `
  wget --no-verbose https://github.com/pal1000/mesa-dist-win/releases/download/23.1.9/mesa3d-23.1.9-release-msvc.7z && `
  7z x mesa3d-23.1.9-release-msvc.7z && `
  cmd //c systemwidedeploy.cmd 1 && `
  cd .. && for i in {1..30}; do sleep 1; echo Try $i; rm -rf mesa && break; done"

RUN "find / -iname opengl32.dll"
