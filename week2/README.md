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
  * See [Regression, Prediction, and Classification](prediction.pptx) slides
  * Additional references: these tutorials on [simple linear regression](http://www.r-tutor.com/elementary-statistics/simple-linear-regression) and [multiple linear regression](http://www.r-tutor.com/elementary-statistics/multiple-linear-regression) in R

### Sales data
This exercise looks at the relationship between price and sales for supermarket sales of orange juice.

1. Load the [orange juice data](oj.csv).
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
    1. Do a regression of ``logmove`` on ``log price``. How well does the model fit? What is the elasticity (the coefficient on log price), and does it make sense? See [here](http://www.salemmarafi.com/business/price-elasticity/) for some background on elasticity and below for a tip on plotting the fitted model.
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

