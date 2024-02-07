print("test1")
print("test2a")
print('::error file=myfile.cpp,line=1,col=5::my error message')
print("test2b")
print("test2a")
print('::group::my group a')
print("group1a")
print("group2a")
print('::endgroup::')
print("test2b")
print("test2a")
print('::group::my group b')
print("group1b")
print("group2b")
print('::endgroup::')
print("test2b")
print("test2a")
colorMap={
  "black": 30,
  "red": 31,
  "green": 32,
  "yellow": 33,
  "blue": 34,
  "magenta": 35,
  "cyan": 36,
  "white": 37,
  "default": 39,
  "reset": 0,
}
for k in colorMap:
  print(f'\033[0;{colorMap[k]}mHello {k}\033[0m')
print("test2b")
print("test3")
