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
7. Now implement 5-fold cross-validation to get a better estimate of the error on the validation data. Do this within a for-loop over folds, and keep track of the mean-squared error on the test data in each iteration. Then compute the average of the five mean-squared errors that you get for the test data in each fold, as well as the standard error (!= standard deviation!) on that average. Hint: you can shuffle the rows of the data set as above in part 2), but now label each row as belonging to 1 of 5 folds and then exclude one fold on each loop.

## References

  * Chapter 3 of [Advanced Data Analysis from an Elementary Point of View](http://www.stat.cmu.edu/~cshalizi/ADAfaEPoV/) on resampling and cross-validation
  * Chapter 2 of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/) on the bias-variance tradeoff
  * Section 1.4 of [Advanced Data Analysis from an Elementary Point of View](http://www.stat.cmu.edu/~cshalizi/ADAfaEPoV/) on the same, with a more detailed derivation
<!-- http://www.inf.ed.ac.uk/teaching/courses/mlsc/Notes/Lecture4/BiasVariance.pdf -->


