# Intro to Statistics and Machine Learning
## Day 1
  * See [Intro to Estimators and Sampling](estimators-and-sampling.pptx) slides
  * Review and modify [this code](http://rpubs.com/jhofman/statistical_inference) to simulate flipping a biased coin and estimating the bias on the coin:
    * Use the ``estimate_coin_bias(N,p)`` function that simulates flipping a coin with probability ``p`` of landing heads ``N`` times and returns an estimate of the bias using the sample mean ``p_hat``
	* Run this simulation 1000 times, for all combinations of ``N = {10,100,100}`` and ``p = {0.1, 0.5, 0.9}``
	* Plot the distribution of ``p_hat`` values for each ``N, p`` setting
	* Plot the standard deviation of the ``p_hat`` distribution as a function of the sample size ``N``
	* Create one plot of the ``p_hat`` distributions, faceted by different ``N`` values for ``p = 0.5`` using ``ggplot``
  * Review the third chapter of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/index.html) and work on the associated lab
  * Also check out Chapters 7, 8, and 9 of [Introduction to Statistical Thinking (With R, Without Calculus)](http://pluto.huji.ac.il/~msby/StatThink/)

## Day 2
  * See the [slides](prediction.pptx) on regression
  * Additional references: these tutorials on [simple linear regression](http://www.r-tutor.com/elementary-statistics/simple-linear-regression) and [multiple linear regression](http://www.r-tutor.com/elementary-statistics/multiple-linear-regression) in R

### Sales data
This exercise looks at the relationship between price and sales for supermarket sales of orange juice.

1. Load the [orange juice data](oj.csv). See [here](http://www.inside-r.org/packages/cran/bayesm/docs/orangeJuice) for a description of the columns.
2. Visualizing price.
    1. Make a plot of the distribution of prices.
    2. Change the x-axis on this plot to use a logarithmic scale using ``scale_x_log10()``.
    3. Repeat i), faceted by brand.
    4. Repeat ii), faceted by brand.
    5. What do these graphs tell you about the variation in price? Why do the log plots look different? Do you find them more/less informative?
3. Visualizing the quantity/price relationship.
    1. Plot ``logmove`` (the log of quantity sold) vs. ``log price``. 
    2. Color each point by ``brand``. What do insights can you derive that were not apparent before?
4.  Estimating the relationship.
    1. Do a regression of ``logmove`` on ``log price``. How well does the model fit? What is the elasticity (the coefficient on log price), and does it make sense? See [here](http://www.salemmarafi.com/business/price-elasticity/) for some background on elasticity and below for a tip on plotting the fitted model. Also, see [here](http://home.wlu.edu/~gusej/econ398/notes/logRegressions.pdf) for more on log-log transformations in regression.
    2. Now add in an intercept term for each brand (by adding ``brand`` to the [regression formula](http://faculty.chicagobooth.edu/richard.hahn/teaching/formulanotation.pdf)). How do the results change? How should we interpret these coefficients?
    3. Now add interaction terms to allow the elasticities to differ by brand, by including a ``brand:log price`` term in the regression formula. Note the estimate coefficients will "offset" the base estimates. What is the insights we get from this regression? What is the elasticity for each firm? Do the elasticities make sense?
5. Impact of "featuring in store".
    1. Which brand is featured the most? Make a plot to show this.
    2. How should we incorporate the "featured in store" variable into our regression? Start with an additive formulation (e.g. feature impacts sales, but not through price).
    3. Now run a model where features can impact sales and price sensitivity.
    4. Now run a model where each brand can have a different impact of being featured and a different impact on price sensitivity. Produce a table of elasticties for each brand, one row for "featured" and one row for "not featured" (you need 6 estimates).

``` 
	# create some fake data
	x <- runif(300)
	z <- sample(1:3, 300, replace=T)
	df <- data.frame(x=x, z=as.factor(z), y=2*x - 3*z + x*z + rnorm(300))

	# fit the model
    model <- lm(y ~ x + z, data=df)
    
	# add the predicted values to the data frame
    df$predicted <- fitted(model)
    
    # plot the observations as points and predictions as a line
    ggplot(df, aes(x=x, y=y, color=z)) +
      geom_point() +
      geom_line(aes(x=x, y=predicted, color=z))
```

## Day 3
  * See the [slides](prediction.pptx) on classification
  * See [example plots](oj.R) for some of yesterday's exercises
  * Review pages 15-33 of Chapter 2 in [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/index.html)
  * [Fernando](http://research.microsoft.com/jump/164338) spoke about [regular expressions](slides/regular-expressions.pptx)
    * See this handy [regex cheatsheet](http://ryanstutorials.net/linuxtutorial/cheatsheetgrep.php)
    * See his last two slides for exercises, some of which involve the [20 newsgroups](http://qwone.com/~jason/20Newsgroups/) data
    * Use ``wget`` or ``curl`` to download the data and ``tar zxvf <filename>`` to decompress it

### More sales data
1. Let’s return to the orange juice assignment and investigate how store demographics are related to demand.
    1. Let’s start with the following model: ``logmove ~ log(price)*brand*feat`` and add in the store demographics as linear features (e.g., ``+ AGE60 + EDUC + ETHNIC + INCOME``). Try them individually and then all together.
    2. What demographics are significantly ``(t > 2 standard deviations)`` related to demand?
    3. How much did the adjusted R-squared improve with the addition of these variables?
2. Let’s focus on two variables ``HHLARGE`` ("fraction of households that are large") and ``EDUC`` ("fraction of shoppers with advanced education").
    1. What are the means and percentiles of each of these variables?
    2. Using your coefficient estimates from the regression in 1b:
        1. If we move from the median value of ``HHLARGE`` to the 75th percentile (3rd quartile), how much does ``logmove`` change each week on average? You can estimate this visually if you plot the fitted model, or you can compare the predicted values for rows that have the median and 75th percentiles for ``HHLARGE``.
        2. If we move from the median value of ``EDUC`` to the 75th percentile (3rd quartile), how much does ``logmove`` change each week on average?
        3. Based on this analysis, which is the more important predictor of demand?
    3. Now let’s see if these variables impact price sensitivity. Add two interaction terms (with logprice) to the model to test this.
        1. What are the coefficients on the interaction terms?
        2. Recall, positive values indicate lower price sensitivity and negative values indicate greater price sensitivity. Do your estimates make sense based on your intuition?
        3. What are the coefficient estimates on the constants EDUC and HHLARGE? How do they compare to your regression from 1b?
        4. Similar to 2b, if we move from the median value of each variable to the 3rd quartile, how much does elasticity change? Based on this, which is more important to price sensitivity?
    4. You should notice that the coefficients on ``EDUC`` and ``HHLARGE`` have flipped sign once we include interaction terms with price. HHLARGE now appears to be a positive demand shifter and increases price sensitivity. Explain in words or pictures what is going on.
3. Let’s split our data into a training set and a test set. An easy way to do this is with the sample command. The following will randomly select 20% of the rows in our data frame: ``indexes <- sample(1:nrow(oj), size=0.2*nrow(oj))``
    1. Now let’s use this index to create a training and a test set, try:
``OJtest=oj[index, ]`` and ``Ojtrain=oj[-index, ]``. What did this do? How many rows does the test set have? How many rows does the training set have?
4. Now let’s run the very simple model ``logmove ~ log(price) + brand`` on the training data.
    1. Use LM on this model and report the R-squared.
    2. Use ``predict(model, Ojtest)`` to predict log sales for the test set.
    3. Compute ``cor(predicted_sales,logmove)^2`` on the test set. This is our "honest R-squared". How does it compare to the value in (a)?
5. Now let’s run better models.
    1. Run our "previous favorite" ``logmove ~ brand*log(price)*feat`` on the training data. Use LM to get regular R-squared. Now, follow the procedure in (3) to compute "honest R-squared". What is it? How do they compare?
    2. Now add in all the demographics. What is the regular R-squared on training data? What is the honest R-squared on the test set?

## Day 4
  * See the [slides](prediction.pptx) on cross-validation and regularization
  * Continue working on yesterday's sales data and regular expression exercises

### Cross-validation for Citibike trips
In this assignment we'll predict number of trips per day as a function of the weather on that day.

1. Create a data frame with one row for each day, the number of trips taken on that day, and the minimum temperature on that day.
2. Split the data into a randomly selected training and test set, as in the above exercise, with 80% of the data for training the model and 20% for testing.
3. Fit a model to predict the number of trips as a (linear) function of the minimum temperature, and evaluate the fit on the training and testing data sets. Do this first visually by plotting the predicted and actual values as a function of the minimum temperature. Then do this with R^2, as above. You'll want to use the ``predict`` and ``cor`` functions for this.
4. Repeat this procedure, but add a quadratic term to your model (e.g., ``+ tmin^2``, or equivalently `` + poly(k,2)``). How does the model change, and how do the fits between the linear and quadratic models compare?
5. Now automate this, extending the model to higher-order polynomials with a ``for`` loop over the degree ``k``. For each value of ``k``, fit a model to the training data and save the R^2 on the training data to one vector and test vector to another. Then plot the training and test R^2 as a function of ``k``. What value of ``k`` has the best performance?
6. Finally, fit one model for the value of ``k`` with the best performance in 6), and plot the actual and predicted values for this model.

## Day 5
  * Finish up the regular expression exercises
  * Then do cross-validation for the Citibike trips data
  * Finish up with the prediction exercise below
  * Make sure to save your work and push it to GitHub. Do this is three steps:
  	1. ``git add`` and ``git commit`` and new files to your local repository. (Omit large data files.)
  	2. ``git pull upstream master`` to grab changes from this repository, and resolve any merge conflicts, commiting the final results.
  	3. ``git push origin master`` to push things back up to your GitHub fork of the course repository. 
   
### Predicting daily Citibike trips
The point of this exercise is to get experience in an open-ended prediction exercise: predicting the total number of Citibike trips taken on a given day. Here are the rules of the game:

1. You can use any features you like that are available prior to the day in question, ranging from the weather, to the time of year and day of week, to activity in previous days or weeks, but don't cheat and use features from the future (e.g., the next day's trips).
2. As usual, split your data into training and testing subsets and evaluate performance on each.
3. Quantify your performance in two ways: R^2 (or the square of the correlation coefficient), as we've been doing, and with [root mean-squared error](https://www.kaggle.com/wiki/RootMeanSquaredError).
4. Report the model with the best performance on the test data. Watch out for overfitting.
5. Plot your final best fit model in two different ways. First with the date on the x-axis and the number of trips on the y-axis, showing the actual values as points and predicted values as a line. Second as a plot where the x-axis is the predicted value and the y-axis is the actual value, with each point representing one day.
5. Inspect the model when you're done to figure out what the highly predictive features are, and see if you can prune away any negligble features that don't matter much.