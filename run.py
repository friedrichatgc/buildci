import subprocess
import os

os.chdir("c:/mbsim-env")

subprocess.check_call(["g++", "-o", "main.exe", "main.cc"])
subprocess.check_call(["./main.exe"])
subprocess.check_call(["rm", "./main.exe"])

print("DONE")
