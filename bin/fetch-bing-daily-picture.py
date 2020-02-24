#!/usr/bin/env python3

import shutil
import urllib.request
import json

with urllib.request.urlopen("http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1") as response:
    jsonblob = response.read()
    data = json.loads(jsonblob)
    urlpath = data['images'][0]['url']
    fullurl = 'http://www.bing.com' + urlpath
    urllib.request.urlretrieve(fullurl, "image.jpg")
