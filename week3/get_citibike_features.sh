# holiday data
curl -o holidays.csv "https://gist.githubusercontent.com/shivaas/4758439/raw/a33943da19bd8512f41cd369332ee7e805eb373c/US%2520Bank%2520holidays%2520(up%2520to%25202020)"

# wind data
curl -o winds.csv "https://www.ncei.noaa.gov/access/services/data/v1?dataset=daily-summaries&stations=USW00094728,USW00014732,USW00094789&startDate=2014-01-01&endDate=2014-12-31&dataTypes=AWND&format=csv&units=standard&includeStationName=true"
