#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: ./strReplace.sh directory toReplace replacedBy"
else
    echo "$2 will be replaced by $3 in: $1"
    grep -rl $2 $1 | xargs sed -i s/$2/$3/g
    
fi
