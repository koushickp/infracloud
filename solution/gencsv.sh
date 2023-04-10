#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 [start_index] [end_index]"
  exit 1
fi

start=$1
end=$2

if (( start >= end )); then
  echo "Error: start index must be less than end index"
  exit 1
fi

for (( i=start; i<=end; i++ ))
do
  rand_num=$(( $RANDOM % 1000 ))
  echo "${i}, ${rand_num}" >> inputFile
done

