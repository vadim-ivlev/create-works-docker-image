#!/bin/bash

docker build -t rgru/works:7.2.11-front -f Dockerfile-front-7.2.11 .
docker push rgru/works:7.2.11-front


