#!/bin/bash

boots=$(journalctl | grep "systemd\[1\]: Startup" | tail -n 10 | awk '{print $21}' | grep -oE '[0-9]+\.[0-9]+')

my_arr=(0 0 0 0 0 0 0 0 0 0)

index=0
for boot in $boots; do
my_arr[index]=$(echo "scale=3; $boot" | bc)
index=$((index+1))
done

average=0
for ((i=0; i<10; i++ ));do
average=$(echo "${my_arr[i]} + $average" | bc -l)
done
average=$( echo "scale=3 ; $average / 10" | bc -l)

sorted=$(for((i=0; i<10; i++)); do echo ${my_arr[i]}; done | sort -n)
mid=$(echo $sorted | awk '{print $5}')

longest=$(echo $sorted | awk '{print $10}')


echo "Average $average sec"
echo "Median $mid sec"
echo "Max $longest sec"
