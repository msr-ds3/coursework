## Day 1
  * Continue last week's exercise on developing the best model you can to [predict daily Citibike trips](https://github.com/msr-ds3/coursework/tree/master/week2#predicting-daily-citibike-trips)
  * Do Lab 2, "Ridge Regression and the Lasso" in Chapter 6 of Introduction to Statistical Learning; see sections 5.1 and 6.2 for related reading and background material


## Day 2
  * See the preview chapter on regression (on slack), the [derivation of the normal equations](https://en.wikipedia.org/wiki/Linear_least_squares_%28mathematics%29#Derivation_of_the_normal_equations), and this post on [gradient descent](https://spin.atomicobject.com/2014/06/24/gradient-descent-linear-regression/)
  * Revise the Citibike model in a few ways:
    * Look at feature distributions to get a sense of what tranformations (e.g., ``log`` or manually created factors) might improve model performance
    * Add holiday effects and look at how much of the overall error is coming from holidays compared to regular days
    * Use the predicted vs. actual plots to diagnose which examples in the training set you're doing poorly on, and see if there's anything systematic that can be adjusted
  * After completing yesterday's Lab 2 from Chapter 6 in ISL, use ``cv.glmnet`` to potentially improve upon your best model for the Citibike data. What is your overall R^2 and mean-squared error?
    * See the [glmnet vignette](http://web.stanford.edu/~hastie/glmnet/glmnet_alpha.html) for more information on the package
  * You can use broom to [tidy up your glmnet models](http://rpackages.ianhowson.com/cran/broom/man/cv.glmnet_tidiers.html)
  
## Day 3
  * Implement 5-fold cross-validation for your Citibike model to get a better estimate of the error on the testing data.
    * Hint: you can use something like ``df$fold <- sample(1:5, nrow(df), replace=T)`` to randomly assign each row of a data frame to one of five folds, and then select the training and test data using this (e.g., to select fold f=1 ``train <- filter(df, fold != f)]`` and ``test <- filter(df, fold == f)``)
    * Do this within a for-loop over folds, and keep track of the mean-squared error on the test data in each iteration
    * Then compute the average of the five mean-squared errors that you get for the test data in each fold, as well as the standard error (!= standard deviation!) on that average
    
## Day 4
  * [Amit Sharma](http://www.amitsharma.in) gave a guest lecture on [causality](https://github.com/amit-sharma/causal-inference-tutorial)
  * When you're convinced that you have your best model, clean up all your code so that it saves your best model a ``.RData`` file
  * Commit all of your changes to git, using ``git add -f`` to add the model ``.Rdata`` file if needed, and push to your Github repository
  * Finally, write a new file that loads in the [weather data for new days](weather_2015.csv) and your saved model, and predicts the number of trips each day (see [load_trips.R](../week1/citibike/load_trips.R) for code snippets to load in the weather data)
  * Compute the RMSE on this data set and compare the results to what you found with cross-validation
  * Pair up with a partner, run their model, and evaluate the predictions it makes for the 2015 data
  
## Day 5
  * See the [slides](http://www.slideshare.net/jakehofman/modeling-social-data-lecture-6-classification-with-naive-bayes) we covered on Naive Bayes for classification, along with the [one-word spam classifier](enron_naive_bayes.sh) shell script (more references [here](http://jakehofman.com/ddm/2012/02/lecture-03-2/))
  * Complete this [naive Bayes lab](https://rpubs.com/dvorakt/144238) 
  * Do the logistic regression lab (4.6.1 and 4.6.2) in Chapter 4 of ISL (sections 4-4.3 are useful background reading)
  * Also go through this [logistic regression lab](https://rpubs.com/dvorakt/151334)
  * Finally, make sure to [commit and push](https://github.com/msr-ds3/coursework/tree/master/week2#day-5) your code to GitHub