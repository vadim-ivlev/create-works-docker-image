#!/bin/bash

docker build -t rgru/works:7.0.31 -f Dockerfile-works-7.0.31 . \
&& docker push rgru/works:7.0.31


