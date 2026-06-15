#!/bin/bash

#
# downloads MTA Turnstile Data from Feb - Dec 2014
#

curl -L \
"https://data.ny.gov/resource/i55r-43gk.json?\$limit=1000000" \
-o mta_turnstile_2014.json
