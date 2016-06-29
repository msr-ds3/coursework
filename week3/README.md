## Day 1
  * Continue last week's exercise on developing the best model you can to [predict daily Citibike trips](https://github.com/msr-ds3/coursework/tree/master/week2#predicting-daily-citibike-trips)
  * Do Lab 2, "Ridge Regression and the Lasso" in Chapter 6 of Introduction to Statistical Learning; see sections 5.1 and 6.2 for related reading and background material


## Day 2
  * Revise the Citibike model in a few ways:
    * Look at feature distributions to get a sense of what tranformations (e.g., ``log`` or manually created factors) might improve model performance
    * Add holiday effects and look at how much of the overall error is coming from holidays compared to regular days
    * Use the predicted vs. actual plots to diagnose which examples in the training set you're doing poorly on, and see if there's anything systematic that can be adjusted
  * After completing yesterday's Lab 2 from Chapter 6 in ISL, use ``cv.glmnet`` to potentially improve upon your best model for the Citibike data. What is your overall R^2 and mean-squared error?
    * See the [glmnet vignette](http://web.stanford.edu/~hastie/glmnet/glmnet_alpha.html) for more information on the package
  * See the preview chapter on regression (on slack), the [derivation of the normal equations](https://en.wikipedia.org/wiki/Linear_least_squares_%28mathematics%29#Derivation_of_the_normal_equations), and this post on [gradient descent](https://spin.atomicobject.com/2014/06/24/gradient-descent-linear-regression/)
  * You can use broom to [tidy up your glmnet models](http://rpackages.ianhowson.com/cran/broom/man/cv.glmnet_tidiers.html)
  
## Day 3
  * Implement 5-fold cross-validation for your Citibike model to get a better estimate of the error on the testing data.
    * Hint: you can use something like ``df$fold <- sample(1:5, nrow(df), replace=T)`` to randomly assign each row of a data frame to one of five folds, and then select the training and test data using this (e.g., ``train <- filter(df, fold != 1)]`` and ``test <- filter(df, fold == 1)``)
    * Do this within a for-loop over folds, and keep track of the mean-squared error on the test data in each iteration
    * Then compute the average of the five mean-squared errors that you get and the standard error on that average