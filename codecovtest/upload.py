#!/usr/bin/python

import requests
import subprocess
import urllib

commitID=subprocess.check_output(["git", "rev-parse", "HEAD"]).decode("utf-8").strip()
with open("codecovUploadToken", "r") as f:
  codecovUploadToken=f.read().strip()
buildID=1
jobID=1
lcovDownloadURL="https://www.mbsim-env.de:10443/8465739265725648/codecov/cov.trace.final"

url="https://codecov.io/upload/v5?commit=%s&token=%s&build=%d&job=%d&build_url=%s&flags=%s&url=%s"% \
              (commitID, codecovUploadToken, buildID, jobID,
               urllib.parse.quote("https://www.mbsim-env.de/buildci-dummybuild/%d/%d"%(buildID, jobID)),
               "valgrind", urllib.parse.quote(lcovDownloadURL))
print("codecov call url:")
print(url)
response=requests.post(url,
               data=lcovDownloadURL.encode("utf-8"),
               headers={"Accept": "text/plain"})
print("codecov status code "+str(response.status_code)+" and output:")
print(response.content.decode("utf-8"))
