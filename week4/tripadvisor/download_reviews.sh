#!/bin/bash
#
# tripadvisor hotel reviews
# http://times.cs.uiuc.edu/~wang296/Data/
#

mkdir data
cd data

[ -f Review_Texts.zip ] || wget http://times.cs.uiuc.edu/~wang296/Data/LARA/TripAdvisor/Review_Texts.zip

unzip Review_Texts.zip
