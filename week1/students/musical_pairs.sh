#!/bin/bash
#

# get date
# parse date in a way where it is just numbers
# don't select same team member (need to figure out combinations)
#


cd students

name=($(ls | cut -d' ' -f1 | awk -F. '{print $1}'))

day=$(date +%d)

combination=$((day % 11))

if (( $combination > 6 )); then
    iterations=$((combination - 6))
    for ((i=0; i < iterations; i++)); do
        reserve=${name[1]}
        for ((j=1; j<12; j+=2)); do
            if (( j+2 < 12 )); then
                name[j]=${name[$((j+2))]}
            else
                name[j]=${name[$(((j+2) % 12))]}
            fi
        done
        name[11]=$reserve
    done
else
    for ((i=0; i < combination; i++)); do
        temp=${name[1]}
        for ((j=2; j<12; j+=2)); do
            if (( j == 2)); then
                name[j-1]=${name[j]}
            else
                name[j-2]=${name[j]}
            fi
        done
        name[10]=$temp
    done
fi

for ((i=0; i < 12; i++)); do
    if (( i % 2 == 0)); then
        echo "--------------"
    fi
    echo ${name[i]}
done


