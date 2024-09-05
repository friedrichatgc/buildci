# escape=`

FROM mbsimenv/buildmsys2ucrt64:latest

RUN "python.exe -m pip install johnnydep"
RUN "python.exe -m johnnydep pip"
RUN "python.exe -m johnnydep numpy"
RUN "python.exe -m johnnydep sympy"
RUN "python.exe -m johnnydep mpmath"
