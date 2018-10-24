#!/bin/bash

docker build -t rgru/works:7.0.31-pravo -f Dockerfile-pravo-7.0.31 . \
&& docker push rgru/works:7.0.31-pravo




