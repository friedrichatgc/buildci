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

#print(f'::group::\033[0;{colorMap["red"]}mmy group b\033[0m')

print(f'\033[0;{colorMap["red"]}m', end="")
print('::group::my group b')
print(f'\033[0m', end="")

print("group1b")
print("group2b")
print('::endgroup::')
print("test2b")
print("test2a")
print('::group::my group c')
print("group1c")
print("group2c")
print('::endgroup::')
print("test2b")
print("test2a")
for k in colorMap:
  print(f'\033[0;{colorMap[k]}mHello {k} line1\nline2\nline3\033[0m')
print("test2b")
print("test3")
