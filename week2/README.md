# Intro to Statistics and Machine Learning
# Day 1
  * See Intro to Statistics slides (to be posted shortly)
  * Write code to simulate flipping a biased coin and estimating the bias on the coin:
    * Create a function ``flip_coin(N,p)`` that simulates flipping a coin with probability ``p`` of landing heads ``N`` times and returns an estimate of the bias using the sample mean ``p_hat``
	* Run this simulation 1000 times, for all combinations of ``N = {10,100,100}`` and ``p = {0.1, 0.5, 0.9}``
	* Plot the distribution of ``p_hat`` values for each ``N, p`` setting
	* Plot the standard deviation of the ``p_hat`` distribution as a function of the sample size ``N``
	* Create one plot of the ``p_hat`` distributions, faceted by different ``N`` values for ``p = 0.5`` using ``ggplot``
  * Inspect the Citibike trip duration data for outliers, comparing the mean and median trip length time
  * Review the first chapter of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/index.html)

# Day 2
  * Coin-flipping simulations review. Check out the examples and code [here](http://rpubs.com/jhofman/statistical_inference). Get the code running in R.
  * Modeling city bike trips. Complete the assignment in [trips_vs_weather.Rmd](citibike/trips_vs_weather.Rmd). Note that in this assigment we'll predict trips per day as a function of the weather. After doing this, please add additional features that you think will be useful to predict number of trips per day.
  * Quantify how well we can predict trips per day.
  * Reading assignment: Section 2.1 of ISL.
