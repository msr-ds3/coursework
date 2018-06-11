ls *.txt | awk -v date=`date +%Y%m%d` 'BEGIN {srand(date)} {print rand(), $1;}' | sort | awk '{print $2; if (NR % 2 == 0) print "----------"}'
