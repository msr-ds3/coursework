#!/bin/bash

date +"%Y%m%d" | md5sum > /tmp/ymd; ls *.txt | shuf --random-source=/tmp/ymd | awk '{print; if (NR % 2 == 0) print "--------"}'
