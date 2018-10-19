#!/bin/bash

USAGE="
Shows PHP extensions that are installed on the server and not in the docker image.

Usage: ./$(basename $0) server_name image_name

  server_name - name of the server  defined in ~/.ssh/config
  image_name  - name of the docker image

Example:
./$(basename $0) front rgru/works:5.6.38-front 
"


if [ $# -lt 2 ]; then
    	echo "$USAGE"
	exit 1		
fi

SERVER="$1"
IMAGE="$2"


ssh $SERVER php -m |sort >server-extensions.txt
docker run -it --rm $IMAGE php -m | tr -d "\r"| sort >docker-extensions.txt
#grep -Fxv -f server-extensions.txt docker-extensions.txt
comm -13  docker-extensions.txt server-extensions.txt
