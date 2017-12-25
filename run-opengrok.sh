#!/bin/bash

docker network create --ipv6 \
  --subnet ::1/112 \
  --driver cilium \
  --ipam-driver cilium cilium-net

docker run --net cilium-net \
  -p 8080:8080 \
  -l "app=opengrok" \
  --name opengrok -d --rm \
  -v $HOME/src:/src \
  -v $HOME/opengrok_data:/data \
  scue/docker-opengrok
