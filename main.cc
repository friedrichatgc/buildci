#include "test.h"
#include <iostream>

using namespace std;

int main() {
  Test t(4);
  auto r = t.func(3);
  cout<<"main "<<r<<endl;
  return 0;
}
