#!/usr/bin/env bash

ans=0
current=0

for line in $(cat input.txt); do
    l=$(echo $line)
    if [[ -z $l ]]; then
        if [[ $current -gt $ans ]]; then
            ans=$current
        fi
        current=0
    else
        current=$((current + l))
    fi
done

echo "$ans"