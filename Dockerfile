FROM mcr.microsoft.com/windows/servercore:ltsc2019

#RUN mkdir c:/msys64/context
#
#COPY buildci/entrypoint.py c:/msys64/context/entrypoint.py
#USER ContainerUser
ENTRYPOINT ["c:/msys64/ucrt64/bin/python3", "-c", "print(99)"]
