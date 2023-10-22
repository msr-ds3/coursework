#!/bin/sh

RATINGS_COUNT=`wc -l ratings.dat | xargs | cut -d ' ' -f 1`
echo "ratings count: $RATINGS_COUNT"
SET_SIZE=`expr $RATINGS_COUNT / 5`
echo "set size: $SET_SIZE"
REMAINDER=`expr $RATINGS_COUNT % 5`
echo "remainder: $REMAINDER"

for i in 1 2 3 4 5
  do
    head -`expr $i \* $SET_SIZE` ratings.dat | tail -$SET_SIZE > r$i.test

    # XXX: OSX users will see the message "head: illegal line count -- 0" here,
    #      but this is just a warning; the script still works as intended.
    head -`expr \( $i - 1 \) \* $SET_SIZE` ratings.dat > r$i.train
    tail -`expr \( 5 - $i \) \* $SET_SIZE` ratings.dat >> r$i.train

    if [ $i -eq 5 ]; then
       tail -$REMAINDER ratings.dat >> r5.test
    else
       tail -$REMAINDER ratings.dat >> r$i.train
    fi

    echo "r$i.test created.  `wc -l r$i.test | xargs | cut -d " " -f 1` lines."
    echo "r$i.train created.  `wc -l r$i.train | xargs | cut -d " " -f 1` lines."
done

./allbut.pl ra 1 10 0 ratings.dat
echo "ra.test created.  `wc -l ra.test | xargs | cut -d " " -f 1` lines."
echo "ra.train created.  `wc -l ra.train | xargs | cut -d " " -f 1` lines."

./allbut.pl rb 11 20 0 ratings.dat
echo "rb.test created.  `wc -l rb.test | xargs | cut -d " " -f 1` lines."
echo "rb.train created.  `wc -l rb.train | xargs | cut -d " " -f 1` lines."

