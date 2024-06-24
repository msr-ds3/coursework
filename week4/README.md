# Day 1


## Testing your Citibike models

Now you're going to test the model you developed yesterday using trips from 2014 with data from 2015.

1. First you'll need to get data for 2015. Make a copy of the the [download_trips.sh](../week1/download_trips.sh) script from week 1 here and modify it to download all trips from 2015. You can call it `download_trips_2015.sh`.
2. Then make a copy of the [load_trips.R](../week1/load_trips.R) script from week 1 here and modify it to load the 2015 trip data along with weather data for 2015 contained in [weather_2015.csv](weather_2015.csv). You can call it `load_trips_2015.R`. If you used any other data for your model, make sure to include code that downloads and incorporates that data as well. The result should be a `trips_2015.Rdata` file similar to what you used to develop your model, but containing data from 2015 (instead of 2014).
3. Write a new file called `test_citibike_predictions.Rmd` that loads in the 2015 `trips_2015.Rdata` file and weather data along with your saved model (from yesterday's `.Rdata` file, and predicts the number of trips for each day.
4. Compute the RMSE between the actual and predicted trips for 2015 and compare the results to what you found with cross-validation on the 2014 data.
5. Pair up with a partner who has a different model, use their code to run their model, and evaluate the predictions it makes for 2015.
6. Write up any thoughts you have about this exercise in your Rmarkdown file, ranging from how the model performed in 2014 vs. 2015, challenges you faced in running it on new data, or issues that came up in running each other's code. Commit and push the file to Github when you're done.
