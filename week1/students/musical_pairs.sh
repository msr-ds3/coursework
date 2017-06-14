ls *.txt | awk 'BEGIN {srand("date +%Y%m%d")} {print rand(), $1;}' | sort | awk '{print $2; if (NR % 2 == 0) print "----------"}'
