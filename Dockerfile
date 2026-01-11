# escape=`
# buildmsys2ucrt64 image: this image is used to build mbsim-env for Windows

FROM mcr.microsoft.com/windows:ltsc2019

# install msys2
ARG MSYS2INSTALLERURI
ENV MSYS2INSTALLERURI=$MSYS2INSTALLERURI

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
  Invoke-WebRequest -UseBasicParsing -uri "$env:MSYS2INSTALLERURI/msys2-base-x86_64.sfx.exe" -OutFile msys2.exe; `
  .\msys2.exe -y -oC:\; `
  Remove-Item msys2.exe;

# set msys2 as default shell: you NEED TO use e.g.: RUN "ls -l && ls test" (with the double quotes)
# we cannot use something like entrypoint_sys2.bat as wrapper script since e.g. "&&" is not passed as argument by docker Windows
ENV MSYSTEM=UCRT64 CHERE_INVOKING=yes HOME=/home/user
SHELL ["c:\\msys64\\usr\\bin\\bash.exe", "-l", "-c"]

# run msys2 the first time -> initial setup
RUN "echo msys2 init done"

RUN "pacman -S --noconfirm mingw-w64-ucrt-x86_64-7zip"




# Install mesa for software OpenGL (only needed to run GUI programs in VMs)
# In Windows docker cacls.exe does not exist but is required by mesa systemwidedeploy.cmd -> use icacls.exe temporarily
RUN "ls -l /c/windows/system32/*acls.exe"
RUN "mkdir mesa && cd mesa && `
  wget --no-verbose https://github.com/pal1000/mesa-dist-win/releases/download/25.3.3/mesa3d-25.3.3-release-msvc.7z && `
  cp /c/windows/system32/icacls.exe /c/windows/system32/cacls.exe && `
  7z x mesa3d-25.3.3-release-msvc.7z && `
  cmd //c systemwidedeploy.cmd 1 && `
  rm /c/windows/system32/cacls.exe && `
  cd .. && for i in {1..30}; do sleep 1; echo Try $i; rm -rf mesa && break; done"
