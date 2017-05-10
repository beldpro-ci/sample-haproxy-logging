#!/bin/bash

docker network inspect bridge \
  --format='{{(index (index .IPAM.Config 0) "Gateway")}}'
