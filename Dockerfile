FROM mbsimenv/buildmsys2ucrt64:latest

ENTRYPOINT ["c:/msys64/ucrt64/bin/python3", "c:/msys64/context/entrypoint_msys2.py", "/ucrt64/bin/python3", "/c/mbsim-env/run.py"]
