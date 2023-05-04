#!/bin/bash

# Set key prefix to be checked
KEY_PREFIX="/"

# Set output file
OUTPUT_FILE="etcd_check.txt"

# Check each key with the specified prefix
for key in $(etcdctl get --keys-only --prefix $KEY_PREFIX | tr -d '\000'); do
  # Check if key exists and has a value
  if [ -n "$(etcdctl get $key)" ]; then
    # Checks whether the key contains invalid characters
    if [[ "$key" =~ [^[:print:]] ]]; then
      echo "The key $key contains invalid characters." >> $OUTPUT_FILE
    else
      echo "The $key is OK."
    fi
  else
    echo "The $key is empty or does not exist." >> $OUTPUT_FILE
  fi
done
