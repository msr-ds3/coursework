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


# Day 3

## Classification: Naive Bayes
  * [Slides](https://speakerdeck.com/jhofman/modeling-social-data-lecture-9-classification) on classification
  * The [(super) naive Bayes](enron_naive_bayes.sh) shell script from lecture
  * Review this [code](classification.ipynb) for classification
  * Complete this [naive Bayes lab](https://rpubs.com/dvorakt/144238)


## Computational Complexity
  * [Sid Sen](http://www.cs.princeton.edu/~sssix/) gave a lecture on computational complexity, data structures, and algorithms. Some references:
    * [Typed notes](https://github.com/jhofman/msd2019-notes/blob/master/lecture_3/lecture_3.pdf) that cover some of Sid's lecture (more [here](http://modelingsocialdata.org/lectures/2019/02/08/lecture-3-computational-complexity.html))
    * A [beginner's guide](https://rob-bell.net/2009/06/a-beginners-guide-to-big-o-notation/) to big-O notation
    * Another [introduction to big-O](https://www.interviewcake.com/article/python/big-o-notation-time-and-space-complexity)
    * The [big-O cheatsheet](http://bigocheatsheet.com/)
    * A [table](http://modelingsocialdata.org/img/runtime_table.png) from [Kleinberg & Tardos](https://www.pearsonhighered.com/program/Kleinberg-Algorithm-Design/PGM319216.html) for translating asymptotic notation to typical runtimes on modern hardware
    * Relevant Khan Academy videos:
      * [Asymptotic notation](https://www.khanacademy.org/computing/computer-science/algorithms/asymptotic-notation/a/asymptotic-notation)
      * [Big-O](https://www.khanacademy.org/computing/computer-science/algorithms/asymptotic-notation/a/big-o-notation) for upper bounds
      * [Big-omega](https://www.khanacademy.org/computing/computer-science/algorithms/asymptotic-notation/a/big-big-omega-notation) for lower bounds
      * [Big-theta](https://www.khanacademy.org/computing/computer-science/algorithms/asymptotic-notation/a/big-big-theta-notation) for tight bounds
    * Hash tables on [Wikipedia](https://en.wikipedia.org/wiki/Hash_table) and [Spark Notes](http://www.sparknotes.com/cs/searching/hashtables/summary.html)

### Computational complexity of naive Bayes
  * Think about the complexity of naive Bayes:
    * Assume you're given D documents that contain words from a vocabulary of total size V, and that documents contain w words, on average. For instance, you might have D = 1,000 emails that are labeled spam or not spam, with a vocabulary of V = 100,000 possible words, where emails contains 100 words, on average.
    * What is the running time for estimating the parameters for the version of naive Bayes discussed?
    * What are the space requirements?
    * What is the cost of making a prediction on a new document once you've estimated the paramters?
    * State all of your answers in terms of D, V, and w.

## Normal equations and gradient descent
  * See [here](http://modelingsocialdata.org/lectures/2019/03/08/lecture-7-regression-1.html) for a table of complexity for model fitting and [here](https://github.com/jhofman/msd2019-notes/blob/master/lecture_6/lecture_6.pdf) for the gory details behind solving the normal equations and gradient descent
  * See this animation of [gradient descent](http://jakehofman.com/gd/) and a related [blog post](https://spin.atomicobject.com/2014/06/24/gradient-descent-linear-regression/)
 

## Logistic Regression

  * See [here](https://github.com/jhofman/msd2019-notes/blob/master/lecture_9/lecture_9.pdf) for notes on logistic regression and classifier evaluation
  * Read Sections 4.1 through 4.3 of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/getbook.html) and do the logistic regression lab (4.6.1 and 4.6.2)
  * Do this [logistic regression lab](https://rpubs.com/dvorakt/255527) using copies of the `lending_club_cleaned.csv` ([source](https://www.lendingclub.com/info/download-data.action)) and `titanic_train.csv` ([source](https://www.kaggle.com/c/titanic/data)) datasets that are checked into this repo
  * See [code](plotting_logit_models.R) for plotting logit models (preview output [here](http://htmlpreview.github.io/?https://raw.githubusercontent.com/msr-ds3/coursework/master/week3/plotting_logit_models.html))  

## References

  * Sections 4.1 through 4.3 of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/getbook.html)
  * Chapter 12 of [Advanced Data Analysis from an Elementary Point of View](http://www.stat.cmu.edu/~cshalizi/ADAfaEPoV/) 
  * [Naive Bayes at 40](http://www.cs.iastate.edu/~honavar/bayes-lewis.pdf) by Lewis (1998)
  * [Idiots Bayes---Not So Stupid After All?](http://www.jstor.org/pss/1403452) by Hand and Yu (2001)
  * [A Bayesian Approach to Filtering Junk E-mail](http://robotics.stanford.edu/users/sahami/papers-dir/spam.pdf) from Sahami, Dumais, Heckerman, and Horvitz (1998)
  * [A Plan for Spam](http://www.paulgraham.com/spam.html) by Paul Graham (2002)
  * [An introduction to ROC analysis](https://ccrma.stanford.edu/workshops/mir2009/references/ROCintro.pdf)
  * [Understanding ROC curves](http://www.navan.name/roc/)

<!--

  
  * For more on ROC curves, see [this video](http://www.dataschool.io/roc-curves-and-auc-explained/) and the accompanying [interactive demo](http://www.navan.name/roc/)
  

  -->
