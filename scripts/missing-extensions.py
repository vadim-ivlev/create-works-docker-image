#!/usr/bin/env python3

import sys
import os

USAGE=f"""
Shows PHP extensions that are installed on the server and not in the docker image.

Usage: {sys.argv[0]} server_name image_name

  server_name - name of the server  defined in ~/.ssh/config
  image_name  - name of the docker image

Example:
{sys.argv[0]} front rgru/works:5.6.38-front 
"""



if len(sys.argv) < 3:
    print(USAGE)
    exit(0)



SERVER=sys.argv[1]
IMAGE=sys.argv[2]



os.system(f"ssh {SERVER} php -m |sort >server-extensions.txt")
os.system(f"docker run -it --rm {IMAGE} php -m | tr -d '\r'| sort >docker-extensions.txt")
#grep -Fxv -f server-extensions.txt docker-extensions.txt
os.system(f"comm -13  docker-extensions.txt server-extensions.txt")
