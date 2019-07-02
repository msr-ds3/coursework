# Day 1

## Overfitting and cross-validation

  * See the [slides](https://speakerdeck.com/jhofman/modeling-social-data-lecture-8-regression-part-2) on overfitting and cross-validation
  * Read Section 5.1 of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/)

## Cross-validation for Citibike trips
In this assignment we'll predict number of trips per day as a function of the weather on that day. Do all of your work in an RMarkdown file named `citibike_cv.Rmd`.

1. Use the `trips_per_day.tsv` file that has one row for each day, the number of trips taken on that day, and the minimum temperature on that day.
2. Split the data into a randomly selected training and validation set with 80% of the data for training the model and 20% for validation. Hint: you can use the `sample` function without replacement to shuffle the rows of the data set before splitting to train and validation sets.
3. Fit a model using ``lm`` to predict the number of trips as a (linear) function of the minimum temperature, and evaluate the fit on the training and validation data sets. Do this first visually by plotting the predicted and actual values as a function of the minimum temperature. Then do this with R^2 and RMSE on both the training and validation sets. You'll want to use the ``predict`` and ``cor`` functions for this.
4. Repeat this procedure, but add a quadratic term to your model (e.g., ``+ tmin^2``, or (more or less) equivalently `` + poly(tmin, 2, raw = T)``). How does the model change, and how do the fits between the linear and quadratic models compare?
5. Now automate this, extending the model to higher-order polynomials with a ``for`` loop over the degree ``k``. For each value of ``k``, fit a model to the training data and save the R^2 on the training data to one vector and validation vector to another. Then plot the training and validation R^2 as a function of ``k``. What value of ``k`` has the best performance?
6. Finally, fit one model for the value of ``k`` with the best performance in 6), and plot the actual and predicted values for this model.
7. Now implement 5-fold cross-validation to get a better estimate of the error on the validation data. Do this within a for-loop over folds, and keep track of the mean-squared error on the validation data in each iteration. Then compute the average of the five mean-squared errors that you get for the validation data in each fold, as well as the standard error (!= standard deviation!) on that average. Hint: you can shuffle the rows of the data set as above in part 2), but now label each row as belonging to 1 of 5 folds and then exclude one fold on each loop.

## References

  * Chapter 3 of [Advanced Data Analysis from an Elementary Point of View](http://www.stat.cmu.edu/~cshalizi/ADAfaEPoV/) on resampling and cross-validation
  * Chapter 2 of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/) on the bias-variance tradeoff
  * Section 1.4 of [Advanced Data Analysis from an Elementary Point of View](http://www.stat.cmu.edu/~cshalizi/ADAfaEPoV/) on the same, with a more detailed derivation
<!-- http://www.inf.ed.ac.uk/teaching/courses/mlsc/Notes/Lecture4/BiasVariance.pdf -->


# Day 2

## Regularization

  * See the [intro_to_glmnet.ipynb](intro_to_glmnet.ipynb) notebook
  * Read section 6.2 of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/), do Lab 2, "Ridge Regression and the Lasso" in Section 6.6
  * See the [glmnet vignette](http://web.stanford.edu/~hastie/glmnet/glmnet_alpha.html) for more information on the package
  * You can use broom to [tidy up your glmnet models](https://broom.tidyverse.org/reference/tidy.cv.glmnet.html)

## Predicting daily Citibike trips (open-ended)
The point of this exercise is to get experience in an open-ended prediction exercise: predicting the total number of Citibike trips taken on a given day. Do all of your work in an RMarkdown file named `predict_citibike.Rmd`. Here are the rules of the game:

1. You can use any features you like that are available prior to the day in question, ranging from the weather, to the time of year and day of week, to activity in previous days or weeks, but don't cheat and use features from the future (e.g., the next day's trips). You can even try adding [holiday](https://gist.github.com/shivaas/4758439) effects. You might want to look at feature distributions to get a sense of what tranformations (e.g., ``log`` or manually created factors such as weekday vs. weekend) might improve model performance. This [formula syntax in R](https://cran.r-project.org/doc/manuals/R-intro.html#Formulae-for-statistical-models) reference might be useful.
2. As usual, split your data into training and validation subsets and evaluate performance on each.
3. Quantify your performance using [root mean-squared error](https://www.kaggle.com/wiki/RootMeanSquaredError).
4. Report the model with the best performance on the validation data. Watch out for overfitting.
5. Plot your final best fit model in two different ways. First with the date on the x-axis and the number of trips on the y-axis, showing the actual values as points and predicted values as a line. Second as a plot where the x-axis is the predicted value and the y-axis is the actual value, with each point representing one day.
5. Inspect the model when you're done to figure out what the highly predictive features are, and see if you can prune away any negligble features that don't matter much.
6. When you're convinced that you have your best model, clean up all your code so that it saves your best model in a ``.RData`` file using the `save` function.
7. Commit all of your changes to git, using ``git add -f`` to add the model ``.Rdata`` file if needed, and push to your Github repository.
8. Write a new file that loads in the [weather data for new days](weather_2015.csv) and your saved model, and predicts the number of trips for each day (see [load_trips.R](../week1/load_trips.R) for code snippets to load in the weather data).
9. Modify the [download_trips.sh](../week1/download_trips.sh) script to download trips from 2015 (instead of 2014). 
10. Compute the RMSE between the actual and predicted trips for 2015 and compare the results to what you found with cross-validation.
11. Pair up with a partner who has a different model, run their model, and evaluate the predictions it makes for the 2015 data.