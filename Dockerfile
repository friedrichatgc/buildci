FROM python:windowsservercore-ltsc2022

#RUN mkdir c:/msys64/context
#
#COPY buildci/entrypoint.py c:/msys64/context/entrypoint.py
#USER ContainerUser
ENTRYPOINT ["python3.exe", "-c", "print(99)"]
