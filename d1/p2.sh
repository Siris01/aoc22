#!/usr/bin/env bash

top1=0
top2=0
top3=0
current=0

for line in $(cat input.txt); do
    l=$(echo $line)
    if [[ -z $l ]]; then
        if [[ $current -lt $top3 ]]; then
            current=0 #NO-OP
        elif [[ $current -lt $top2 ]]; then
            top3=$current
        elif [[ $current -lt $top1 ]]; then
            top3=$top2
            top2=$current
        else
            top3=$top2
            top2=$top1
            top1=$current
        fi
        current=0
    else
        current=$((current + l))
    fi
done

ans=$((top1 + top2 + top3))
echo "$ans"