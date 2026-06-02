#this can be run on www.programmiz.com
#it works, but only has 12 options of pairs
#for furture improvements, make a few versions of the starter list and 
# use the date to choose which to use

from datetime import *

today = date.today()
day = today.day
studs = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l']
offset = day%len(studs)
paired = set()

count = 1
for i in range(len(studs)):
    pos = (i+offset)%12
    if studs[i] not in paired:
        while studs[i] not in paired:
            if pos < len(studs) and studs[pos] not in paired and studs[pos] != studs[i]:
                print(f'{count}. {studs[i]} with {studs[pos%12]}')
                paired.add(studs[i])
                paired.add(studs[pos%12])
                count += 1
            else: pos += 1
