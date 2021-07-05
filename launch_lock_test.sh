#!/bin/bash
n_instances=50

for i in $(seq 0 $n_instances)
do
    ./lock_test.sh & 
done
