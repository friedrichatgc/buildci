#!/bin/bash

g++ --coverage -lgcov -o main main.cc || exit
./main || exit
'lcov' '-c' '--no-external' '-i' '--ignore-errors' 'graph' '-o' 'cov.trace.base' '-d' $PWD || exit
'lcov' '-c' '--no-external' '-o' 'cov.trace.test' '-d' $PWD || exit
'lcov' '-a' 'cov.trace.base' '-a' 'cov.trace.test' '-o' 'cov.trace.total' || exit
'lcov' '-r' 'cov.trace.total' '/mbsim-env/mbsim*/kernel/swig/*' '-o' 'cov.trace.final' || exit
sed -i -re "s+SF:/home/markus/project/buildci/+SF:/+g" cov.trace.final || exit
/home/markus/REMOTE/mountall || exit
cp cov.trace.final /home/markus/REMOTE/testwebdav/codecov/. || exit
python upload.py || exit
echo DONE
