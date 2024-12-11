import subprocess

try:
  subprocess.check_call(["g++.exe", "-o", "main.exe", "main.cc"])
  subprocess.check_call(["./main.exe"])
  subprocess.check_call(["/usr/bin/rm.exe", "./main.exe"])
except:
  pass

try:
  subprocess.check_call(["/ucrt64/bin/g++.exe", "-o", "main.exe", "main.cc"])
  subprocess.check_call(["./main.exe"])
  subprocess.check_call(["/usr/bin/rm.exe", "./main.exe"])
except:
  pass

print("DONE")
