#!/bin/bash

journalctl -b -3 > boot.txt

sed "s/Oct.*$HOSTNAME//g" boot.txt > filtered.txt

sort filtered.txt | uniq -c > counted.txt

awk '$1 != 3' counted.txt > different.txt

head -n 10 different.txt
