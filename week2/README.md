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
    1. Do a regression of ``logmove`` on ``log price``. How well does the model fit? What is the elasticity (the coefficient on log price), and does it make sense? See [here](http://www.salemmarafi.com/business/price-elasticity/) for some background on elasticity.
    2. Now add in an intercept term for each brand (by adding ``brand`` to the [regression formula](http://faculty.chicagobooth.edu/richard.hahn/teaching/formulanotation.pdf)). How do the results change? How should we interpret these coefficients?
    3. Now add interaction terms to allow the elasticities to differ by brand, by including a ``brand:log price`` term in the regression formula. Note the estimate coefficients will "offset" the base estimates. What is the insights we get from this regression? What is the elasticity for each firm? Do the elasticities make sense?
5. Impact of "featuring in store".
    1. Which brand is featured the most? Make a plot to show this.
    2. How should we incorporate the "featured in store" variable into our regression? Start with an additive formulation (e.g. feature impacts sales, but not through price).
    3. Now run a model where features can impact sales and price sensitivity.
    4. Now run a model where each brand can have a different impact of being featured and a different impact on price sensitivity. Produce a table of elasticties for each brand, one row for "featured" and one row for "not featured" (you need 6 estimates).
