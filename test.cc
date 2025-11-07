#include "test.h"
#include <iostream>

using namespace std;

Test::Test(int a_) {
  a = a_;
}

int Test::func(int b) {
  cout<<"Test::Func "<<a<<" "<<b<<endl;
  return a+b;
}
