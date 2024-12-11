import subprocess

subprocess.check_call(["g++", "-o", "main.exe", "c:/mbsim-env/main.cc"])
subprocess.check_call(["./main.exe"])
subprocess.check_call(["rm", "./main.exe"])

print("DONE")
