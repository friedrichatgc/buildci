FROM python:windowsservercore-ltsc2022

RUN mkdir c:/msys64/context

COPY test.py c:/msys64/context/entrypoint.py

#COPY buildci/entrypoint.py c:/msys64/context/entrypoint.py
#USER ContainerUser
ENTRYPOINT ["python.exe", "c:/msys64/context/entrypoint.py"]
