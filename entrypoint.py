import sys

argStr=""
for a in sys.argv:
  if "'" in a:
    raise RuntimeError("Can't convert a argument including '")
  argStr+=" '"+a+"'"
print(argStr)
