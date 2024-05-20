FROM mcr.microsoft.com/windows/servercore:ltsc2019

#RUN mkdir c:/msys64/context
#
#COPY buildci/entrypoint.py c:/msys64/context/entrypoint.py
#USER ContainerUser
ENTRYPOINT ["python", "-c", "print(99)"]
