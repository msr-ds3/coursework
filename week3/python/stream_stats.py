#!/usr/bin/env python

import sys
import fileinput

if __name__ == '__main__':

    # check for input filename given as first argument
    if len(sys.argv) < 2:
        sys.stderr.write('reading input from stdin\n')

    # read input one line at a time
    for line in fileinput.input():
        # split on tab to get the key and value for each line
        fields = line.rstrip('\n').split('\t')

        # update statistics for the group correponding to this key
        # (minimum, median, mean, and maximum)

    # loop over each group and output the group's key and statistics
