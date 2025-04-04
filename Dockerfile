# escape=`
# buildmsys2ucrt64 image: this image is used to build mbsim-env for Windows

FROM mbsimenv/buildmsys2ucrt64base:latest

# install msys2
ARG MSYS2INSTALLERURI
ENV MSYS2INSTALLERURI=$MSYS2INSTALLERURI
ARG MSYS2INSTALLERFILE
ENV MSYS2INSTALLERFILE=$MSYS2INSTALLERFILE
ARG MSYS2INSTALLERDOWNLOAD
ENV MSYS2INSTALLERDOWNLOAD=$MSYS2INSTALLERDOWNLOAD
ARG MSYS2INSTALLERUPDATEBYPUBLIC
ENV MSYS2INSTALLERUPDATEBYPUBLIC=$MSYS2INSTALLERUPDATEBYPUBLIC
ARG MSYS2INSTALLERUPLOAD
ENV MSYS2INSTALLERUPLOAD=$MSYS2INSTALLERUPLOAD

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
  Invoke-WebRequest -UseBasicParsing -uri "$env:MSYS2INSTALLERURI/$env:MSYS2INSTALLERFILE" -OutFile msys2.exe; `
  .\msys2.exe -y -oC:\; `
  Remove-Item msys2.exe;

# set msys2 as default shell: you NEED TO use e.g.: RUN "ls -l && ls test" (with the double quotes)
# we cannot use something like entrypoint_sys2.bat as wrapper script since e.g. "&&" is not passed as argument by docker Windows
ENV MSYSTEM=UCRT64 CHERE_INVOKING=yes HOME=/home/user
SHELL ["c:\\msys64\\usr\\bin\\bash.exe", "-l", "-c"]

# run msys2 the first time -> initial setup
RUN "echo DONE"

# install/update msys2
COPY msys2_install1.sh c:/msys64/context/msys2_install1.sh
COPY msys2_install2.sh c:/msys64/context/msys2_install2.sh
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN function msys() { C:\msys64\usr\bin\bash.exe @('-lc') + @Args; } `
  msys '/context/msys2_install1.sh'; `
  msys '/context/msys2_install2.sh `
  dos2unix `
  patch `
  unzip `
  rsync `
  openssh `
  sshpass `
  mingw-w64-ucrt-x86_64-7zip `
  mingw-w64-ucrt-x86_64-swig `
  mingw-w64-ucrt-x86_64-arpack `
  mingw-w64-ucrt-x86_64-autotools `
  mingw-w64-ucrt-x86_64-boost `
  mingw-w64-ucrt-x86_64-cmake `
  mingw-w64-ucrt-x86_64-doxygen `
  mingw-w64-ucrt-x86_64-gcc `
  mingw-w64-ucrt-x86_64-graphviz `
  mingw-w64-ucrt-x86_64-hdf5 `
  mingw-w64-ucrt-x86_64-octave `
  mingw-w64-ucrt-x86_64-openblas `
  mingw-w64-ucrt-x86_64-python-numpy `
  mingw-w64-ucrt-x86_64-python-sympy `
  mingw-w64-ucrt-x86_64-python-scipy `
  mingw-w64-ucrt-x86_64-python-matplotlib `
  mingw-w64-ucrt-x86_64-python-h5py `
  mingw-w64-ucrt-x86_64-python-psutil `
  mingw-w64-ucrt-x86_64-python-pygithub `
  mingw-w64-ucrt-x86_64-python-paramiko `
  mingw-w64-ucrt-x86_64-pyside2 `
  mingw-w64-ucrt-x86_64-pyside2-tools `
  mingw-w64-ucrt-x86_64-qwt-qt5 `
  mingw-w64-ucrt-x86_64-diffutils `
  mingw-w64-ucrt-x86_64-soqt-qt5 `
  mingw-w64-ucrt-x86_64-spooles `
  mingw-w64-ucrt-x86_64-xalan-c `
  mingw-w64-ucrt-x86_64-xerces-c `
  mingw-w64-ucrt-x86_64-ccache `
  mingw-w64-ucrt-x86_64-python-pip `
  mingw-w64-ucrt-x86_64-python-asgiref `
  mingw-w64-ucrt-x86_64-python-pytz `
  mingw-w64-ucrt-x86_64-python-sqlparse `
  mingw-w64-ucrt-x86_64-python-requests `
  mingw-w64-ucrt-x86_64-python-pyjwt `
  mingw-w64-ucrt-x86_64-python-cryptography `
  mingw-w64-ucrt-x86_64-python-cffi `
  mingw-w64-ucrt-x86_64-python-defusedxml `
  mingw-w64-ucrt-x86_64-python-oauthlib `
  mingw-w64-ucrt-x86_64-python-psycopg2 `
  mingw-w64-ucrt-x86_64-gcc-fortran `
  mingw-w64-ucrt-x86_64-python-requests-oauthlib `
  ';

SHELL ["c:\\msys64\\usr\\bin\\bash.exe", "-l", "-c"]

# Install pip packages
RUN "python.exe -m pip install --break-system-packages --upgrade pip==24.0 && python.exe -m pip install --break-system-packages django==3.2 django-allauth==0.55 django-octicons==1.0"

# install git
RUN "wget --no-verbose https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/MinGit-2.43.0-64-bit.zip && `
  unzip -d /c/git MinGit-2.43.0-64-bit.zip && rm -f MinGit-2.43.0-64-bit.zip"
RUN "echo 'PATH=\"$PATH:/c/git/cmd\"' >> ~/.bash_profile"
# disable the git safe.directory security feature since files created in a docker container are not owned by the container user
RUN "git config --global --add safe.directory '*'"

## Install mesa for software OpenGL (only needed to run GUI programs in VMs)
#RUN "mkdir mesa && cd mesa && `
#  wget --no-verbose https://github.com/pal1000/mesa-dist-win/releases/download/23.1.9/mesa3d-23.1.9-release-msvc.7z && `
#  7z x mesa3d-23.1.9-release-msvc.7z && `
#  cmd //c systemwidedeploy.cmd 1 && `
#  cd .. && for i in {1..30}; do sleep 1; echo Try $i; rm -rf mesa && break; done"

# create volume directories
RUN "mkdir /mbsim-env /mbsim-ccache"

# set labels
LABEL org.label-schema.schema-version="1.0" `
  org.label-schema.name="mbsimenv/buildmsys2ucrt64" `
  org.label-schema.description="Automatic build (win64 using msys2-ucrt64) for the MBSim-Environment." `
  org.label-schema.vcs-url="https://github.com/mbsim-env/build/tree/master/docker/buildmsys2ucrt64Image" `
  org.label-schema.vendor="MBSim-Environment"

# ccache for autotools and cmake
ENV CC="ccache gcc" `
    CXX="ccache g++" `
    CCACHE_DIR=/mbsim-ccache `
    MBSIM_SWIG=1

#mfmf# copy
COPY msys2_upload.sh c:/msys64/context/msys2_upload.sh
#mfmfCOPY docker/buildImage/distribute.py            c:/msys64/context/distribute.py
#mfmfCOPY docker/buildmsys2ucrt64Image/entrypoint.py c:/msys64/context/entrypoint.py
#mfmfCOPY django/mbsimenv/build.py                   c:/msys64/context/mbsimenv/build.py
#mfmfCOPY django/mbsimenv/runexamples.py             c:/msys64/context/mbsimenv/runexamples.py
#mfmfCOPY django/mbsimenv/mbsimenvSecrets.py         c:/msys64/context/mbsimenv/mbsimenvSecrets.py
#mfmfCOPY django/mbsimenv/mbsimenv                   c:/msys64/context/mbsimenv/mbsimenv
#mfmfCOPY django/mbsimenv/base                       c:/msys64/context/mbsimenv/base
#mfmfCOPY django/mbsimenv/builds                     c:/msys64/context/mbsimenv/builds
#mfmfCOPY django/mbsimenv/runexamples                c:/msys64/context/mbsimenv/runexamples
#mfmfCOPY django/mbsimenv/service                    c:/msys64/context/mbsimenv/service

# these are the default arguments when running the container
CMD []
# call this script when running the container
# (start python3 with inside of the msys2 environment)
#mfmfCOPY docker/buildmsys2ucrt64Image/entrypoint_msys2.py c:/msys64/context/entrypoint_msys2.py
USER ContainerUser
#mfmfENTRYPOINT ["c:/msys64/ucrt64/bin/python3", "c:/msys64/context/entrypoint_msys2.py", "/ucrt64/bin/python3", "/context/entrypoint.py"]
