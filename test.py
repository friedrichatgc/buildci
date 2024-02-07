print("test1")
print("test2a")
print('::error file=myfile.cpp,line=1,col=5::my error message')
print("test2b")
print("test2a")
print('::group::my group')
print("group1")
print("group2")
print('::endgroup::')
print("test2b")
print("test2a")
colorMap={
  "black": 30,
  "red": 31,
  "green": 32,
  "yellow": 33,
  "blue": 34,
  "purple": 35,
  "cyan": 36,
  "gray": 37,
  "white": 38,
}
for k in colorMap:
  print(f'\033[0;{colorMap[k]};40mHello {k}\033[0m')
for k in colorMap:
  print(f'\033[1;{colorMap[k]};40mHello bold {k}\033[0m')
print("test2b")
print("test3")
