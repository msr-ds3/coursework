# Intro to Statistics and Machine Learning
## Day 1
  * See Intro to Statistics slides (to be posted shortly)
  * Write code to simulate flipping a biased coin and estimating the bias on the coin:
    * Create a function ``flip_coin(N,p)`` that simulates flipping a coin with probability ``p`` of landing heads ``N`` times and returns an estimate of the bias using the sample mean ``p_hat``
	* Run this simulation 1000 times, for all combinations of ``N = {10,100,100}`` and ``p = {0.1, 0.5, 0.9}``
	* Plot the distribution of ``p_hat`` values for each ``N, p`` setting
	* Plot the standard deviation of the ``p_hat`` distribution as a function of the sample size ``N``
	* Create one plot of the ``p_hat`` distributions, faceted by different ``N`` values for ``p = 0.5`` using ``ggplot``
  * Inspect the Citibike trip duration data for outliers, comparing the mean and median trip length time
  * Review the first chapter of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/index.html)
  * See a [recent op-ed](http://www.nytimes.com/2015/06/21/opinion/sunday/whats-the-matter-with-polling.html) on recent challenges in polling

## Day 2
  * See Intro to Regression slides (to be posted shortly)
  * Review these tutorials on [simple linear regression](http://www.r-tutor.com/elementary-statistics/simple-linear-regression) and [multiple linear regression](http://www.r-tutor.com/elementary-statistics/multiple-linear-regression)
  * Coin-flipping simulations review. Check out the examples and code [here](http://rpubs.com/jhofman/statistical_inference). Get the code running in R.
  * Modeling city bike trips. Complete the assignment in [trips_vs_weather.Rmd](citibike/trips_vs_weather.Rmd). Note that in this assigment we'll predict trips per day as a function of the weather. After doing this, please add additional features that you think will be useful to predict number of trips per day. Inspect the fitted model to determine which features are significant.
  * Quantify how well we can predict trips per day. Specifically:
    * What order polynomial best fits the data in terms of adjusted R-squared (use ``summary(your_model)`` to see the regression results)?
    * Add in rain and snow to the model. How much does fit improve? Try out polynomials for each feature. How much does fit improve? What if you create a new variable ``did_rain`` which is 1 if ``rain>0`` and 0 if ``rain=0``. Run a model with this variable. Does this model out-perform including rain as a continuous measure? Do the same thing for snow.
    * Add a column to your data frame that gives day of the week (i.e. Sat, Sun...) as a factor. A quick web search will tell you how to do this if you don't know already. Add this new ``day_of_week`` variable to your model and report the results summary (e.g. ``summary(your_model)``). What happened? How did the model treat the day of week variable? How much did fit improve?
    * What is your overall best combined model? (what features) What is the adjusted R-squared of this model?
    * What model has the best overall performance on the test set?
  * Reading assignment: Section 2.1 of ISL.
