#!/bin/bash

lock_filename=""

# Initialization 
n_lockfiles=2
lock_files=()
lock_prefix="mesh_lock"


# Add new element at the end of the array
for i in $(seq 0 $n_lockfiles)
do
    echo "Appending $lock_prefix$i" 
    lock_files=(${lock_files[@]} "$lock_prefix$i")
done

### Function Declaration
function wait_lock_array {
    # Loops through a lock array to see if there are any locks that are open 
    lock_not_open=true
    while $lock_not_open
    do
        for filename in "${lock_files[@]}"
        do
            if [ ! -f $filename ]    # If file exists
            then
                echo "Lock file $filename is open"
                lock_not_open=false
                echo "Lock" > $filename # Create the lock file
                lock_filename=$filename
                break
            else
                echo "Waiting on available lock file"                
            fi 
        done
        sleep 2s
    done
}


function remove_lock_file {
  if test -f $1; then
    echo "Removing lock $1"
    rm -f $1
  fi
}


# Main body of the code 
wait_lock_array $lock_files 
echo "My lock file is $lock_filename"
sleep 5s                                # do something
remove_lock_file $lock_filename

