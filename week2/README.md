# Intro to Statistics and Machine Learning
## Day 1
  * See [Intro to Statistics](slides/estimators-and-sampling.pptx] slides
  * Write code to simulate flipping a biased coin and estimating the bias on the coin:
    * Create a function ``flip_coin(N,p)`` that simulates flipping a coin with probability ``p`` of landing heads ``N`` times and returns an estimate of the bias using the sample mean ``p_hat``
	* Run this simulation 1000 times, for all combinations of ``N = {10,100,100}`` and ``p = {0.1, 0.5, 0.9}``
	* Plot the distribution of ``p_hat`` values for each ``N, p`` setting
	* Plot the standard deviation of the ``p_hat`` distribution as a function of the sample size ``N``
	* Create one plot of the ``p_hat`` distributions, faceted by different ``N`` values for ``p = 0.5`` using ``ggplot``
  * Inspect the Citibike trip duration data for outliers, comparing the mean and median trip length time
  * Review the first chapter of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/index.html)
  * Also check out Chapters 7, 8, and 9 of [Introduction to Statistical Thinking (With R, Without Calculus)](http://pluto.huji.ac.il/~msby/StatThink/)
  * See a [recent op-ed](http://www.nytimes.com/2015/06/21/opinion/sunday/whats-the-matter-with-polling.html) on recent challenges in polling

## Day 2
  * See [Intro to Regression](slides/intro-to-regression.pptx) slides
  * Review these tutorials on [simple linear regression](http://www.r-tutor.com/elementary-statistics/simple-linear-regression) and [multiple linear regression](http://www.r-tutor.com/elementary-statistics/multiple-linear-regression)
  * Coin-flipping simulations review. Check out the examples and code [here](http://rpubs.com/jhofman/statistical_inference). Get the code running in R.
  * Modeling city bike trips
    * Complete the portion of the assignment in [trips_vs_weather.Rmd](citibike/trips_vs_weather.Rmd) for modeling trips per day as a function of the minimum recorded temperature
    * Quantify how well we can predict trips per day for various degree polynomial function, and generate the described plots
    * What order polynomial best fits the data in terms of adjusted R-squared (use ``summary(your_model)`` to see the regression results)?
  * Reading assignment: Section 2.1 of ISL.

## Day 3
  * [Fernando](http://research.microsoft.com/jump/164338) gave a guest lecture on [how to read research papers](slides/reading-papers.pptx)
  * Read [Exposure to ideologically diverse news and opinion on Facebook](http://www.sciencemag.org/content/348/6239/1130.abstract). Also check out the [supplemental material](http://www.sciencemag.org/content/348/6239/1130/suppl/DC1) and open sourced [data and code](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/LDJ7MS)
  * Revisit modeling the citibike trips
    * Add additional features that you think will be useful to predict number of trips per day, for instance, rain and snow.
    * How much does fit improve? Try out polynomials for each feature and compare the fit
	* What if you create a new variable ``did_rain`` which is 1 if ``rain>0`` and 0 if ``rain=0``. Run a model with this variable. Does this model out-perform including rain as a continuous measure? Do the same thing for snow.
    * Add a column to your data frame that gives day of the week (i.e. Sat, Sun...) as a factor. A quick web search will tell you how to do this if you don't know already. Add this new ``day_of_week`` variable to your model and report the results summary (e.g. ``summary(your_model)``). What happened? How did the model treat the day of week variable? How much did fit improve?
    * What is your overall best combined model? What is the adjusted R-squared of this model?
    * What model has the best overall performance in terms of R-squared and RMSE on the test set?
    * Inspect the fitted model to determine which features are significant
  * Read assignment: Chapter 3 of ISL.
  * See [here](http://cran.r-project.org/doc/manuals/R-intro.html#Statistical-models-in-R) for detailed information abouut specifying formulas in R

## Day 4
  * See [these slides](http://astrostatistics.psu.edu/samsi06/tutorials/tut2larryl_all.pdf) on nonparametric inference in R, specifically [locfit](http://cran.r-project.org/web/packages/locfit/index.html)
  * Here's a (hopefully) [intuitive explanation of overfitting](http://www.quora.com/What-is-an-intuitive-explanation-of-overfitting/answers/3863608?share=1)
  * Install and load the ``locfit`` package
  * Revisit modeling the citibike trips again, this time with ``locfit``
    * Specifically, explore how the fit changes with different parameter values for smoothing and polynomial degree
	* Sweep over different values for the ``nn`` smoothing parameter and ``deg`` degree parameter and evaluate the train and test performance
	* What values of nn and deg give the best performance in terms of R-squared and RMSE on the test set?
	* How does this compare to fits you obtained earlier in the week?
	* Tips for using ``locfit``:

````
# to fit number of trips to tmin with smoothing at 0.5 and 2nd degree interpolation
model <- locfit(num_trips ~ lp(tmin, nn=0.5, deg=2), data=trips_by_day)

# then the usual fitted(), predict(), etc

# to plot the same data with the fitted model overlayed
ggplot(data=trips_by_day, aes(x=tmin, y=num_trips)) +
  geom_point() +
  geom_smooth(method=locfit, formula=y ~ lp(x, nn=0.5, deg=2))
````
  * Review the lecture slides from today
