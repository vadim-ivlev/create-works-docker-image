#!/bin/bash

docker build -t rgru/works:5.6.38-front -f Dockerfile-front-5.6.38 .
docker push rgru/works:5.6.38-front


