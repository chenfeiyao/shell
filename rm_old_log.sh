#!/bin/bash 

cd /data/log

find . -type f -name "*"  -mtime +2  -maxdepth 1 | xargs rm -rf
