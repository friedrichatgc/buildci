#include <iostream>

using namespace std;

void func2(bool b) {
  if(b)
    cout<<"func2a"<<endl;
  else
    cout<<"func2b"<<endl;
}

void func1(bool b) {
  if(b)
    cout<<"func1a"<<endl;
  else
    cout<<"func1b"<<endl;
  func2(!b);
}

int main() {
  func1(true);
  return 0;
}
