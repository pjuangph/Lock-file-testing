#!/bin/bash
n_instances=50

# Start running instances of lock_test.sh
# there should only be 4 running at a given time
for i in $(seq 0 $n_instances)
do
    ./lock_test.sh & 
done
