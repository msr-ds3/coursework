This week covers:

  * More wrangling and plotting in R
  * Statistics



# Day 1

## Plotting (cont'd)

  * Review [visualization_with_ggplot2.ipynb](../week1/visualization_with_ggplot2.ipynb) for an introduction to data visualization with ggplot2


## Combining and reshaping data
  * Review [combine_and_reshape_in_r.ipynb](combine_and_reshape_in_r.ipynb) on joins with dplyr and reshaping with tidyr
  * Read chapters 9 and 10 of [R for Data Science](http://r4ds.had.co.nz) on tidyr and joins
  * Do the following exercises from [R for Data Science](http://r4ds.had.co.nz):
    * Exercise 2 on page 151
    * Exercise 1 and 3 on page 156 
  * Do part 1 of Datacamp's [Cleaning Data in R](https://www.datacamp.com/courses/cleaning-data-in-r) tutorial
  * Additional references:
    * The tidyr [vignette on tidy data](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)
    * The dplyr [vignette on two-table verbs](https://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html) for joins
    * A [visual guide to joins](http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/)

## The Anatomy of the Long Tail
  * Use the [download_movielens.sh](download_movielens.sh) script to download the [MovieLens data](http://grouplens.org/datasets/movielens/)
  * Fill in code in the [movielens.Rmd](movielens.Rmd) file to reproduce the plots from Wednesday's slides
  * Sketch out (on paper) how to generate figure 2 from [The Anatomy of the Long Tail](https://5harad.com/papers/long_tail.pdf)
  * Wrote code to do this in the last section of [movielens.Rmd](movielens.Rmd)

<!--

# Day 5

## Reproducibility
  * Review the slides for [reproducible code](reproducible_code.pptx)
  * Read Chapter 21 of [R for Data Science](http://r4ds.had.co.nz) on Rmarkdown
  * Do the following exercises:
    * Exercises 1 and 2 on page 426 (try keyboard shortcuts: ctrl-shift-enter to run chunks, and ctrl-shift-k to knit the document)
    * Exercise 3 on page 428, using [this file](https://raw.githubusercontent.com/hadley/r4ds/master/rmarkdown/diamond-sizes.Rmd)
    * Exercise 1 on page 434
  * Read this [Introduction to Make](https://bost.ocks.org/mike/make/) and [Make for Data Scientists](http://blog.kaggle.com/2012/10/15/make-for-data-scientists/)



-->




<!--
# Day 1
  * See the [Statistical Inference & Hypothesis Testing](intro_to_stats.pptx) slides
  * Review the [statistical inference Rmarkdown file](statistical_inference.Rmd) (preview the output [here](http://htmlpreview.github.io/?https://github.com/msr-ds3/coursework/blob/master/week2/statistical_inference.html))
  * Interactive demos from the slides:
    * [Student t-distribution](http://rpsychologist.com/d3/tdist/)
    * From the [Seeing theory](http://students.brown.edu/seeing-theory/) site:
      * [Random variables](http://students.brown.edu/seeing-theory/probability-distributions/index.html#section1)
      * [Basic probability](http://students.brown.edu/seeing-theory/basic-probability/index.html)
      * [Central limit theorem](http://students.brown.edu/seeing-theory/probability-distributions/index.html#section3)
      * [Confidence intervals](http://students.brown.edu/seeing-theory/frequentist-inference/index.html#section2)
    * An [interactive tutorial on sampling variability in polling](http://rocknpoll.graphics)
  * Read Chapter 7 of [Introduction to Statistical Thinking (With R, Without Calculus)](http://pluto.huji.ac.il/~msby/StatThink/) (IST) for a recap of sampling distributions. Feel free to execute code in the book along the way.
  * Do question 7.1
  * Read Chapter 9 of of IST
  * Do questions 9.1 and 9.2
  * Go through the [sampling means Rmarkdown file](sampling_means_HW.Rmd) (preview the output [here](http://htmlpreview.github.io/?https://github.com/msr-ds3/coursework/blob/master/week2/sampling_means_HW.html)), and complete the last exercise
  * Read Chapters 10 and 11 of IST
  * For background:
    *  Chapter 4 has a good review of population distributions, expectations, and variance
    *  Chapter 5 has a recap of random variables
    *  Chapter 6 has more information on the normal distribution
  * See section 4 of [Mindless Statistics](http://library.mpib-berlin.mpg.de/ft/gg/GG_Mindless_2004.pdf) and [this article](https://link.springer.com/article/10.1007/s10654-016-0149-3) for some warnings on misinterpretations of p-values


  * Review the third chapter of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/index.html) and work on the associated lab



# Day 2

  * Review the [Prediction and Regression](Lecture%202%20Prediction%20regression%202018.pptx) slides
  * Do [HW2](hw2%20DS3%202018.docx) where you'll learn all about regression and Orange Juice!
  * See this notebook on [linear models](https://github.com/msr-ds3/coursework/blob/master/week2/linear_models.ipynb) with the `modelr` from the tidyverse and this one on [model evaluation](model_evaluation.ipynb) 
  * Read Chapter 18 of [R for Data Science](http://r4ds.had.co.nz) on modeling in R
  * Reference:
    * A description of the [oj data](https://rdrr.io/cran/bayesm/man/orangeJuice.html)
    * [Formula syntax in R](https://cran.r-project.org/doc/manuals/R-intro.html#Formulae-for-statistical-models)
    * Dan's interactive [Visual Least Squares](http://www.dangoldstein.com/dsn/archives/2006/03/every_wonder_ho.html) tool
    * Some background on elasticity: [blog post](http://www.salemmarafi.com/business/price-elasticity/), [Khan Academy video](https://www.khanacademy.org/economics-finance-domain/microeconomics/elasticity-tutorial/price-elasticity-tutorial/v/price-elasticity-of-demand)
    * A slide deck on [log transformations in regression](http://home.wlu.edu/%7Egusej/econ398/notes/logRegressions.pdf)
    * Chapter 3 of [Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/) on regression
    * Also covered in Chapter 14 of [Introduction to Statistical Thinking](http://pluto.huji.ac.il/~msby/StatThink/)


# Day 3
  * Review the [Testing, cross-validation, and model selection](Lecture%203%20t%20stats%2C%20cross%20validation%20and%20model%20selection%202018.pptx) slides
  * Do [HW3](hw2%20DS3%202018.docx), which looks at including store demographics and previous prices for modeling oj sales

# Day 4
  * Investigate cross-price elasticity of oj sales together in class
  * Review the slides on [causality](Lecture%204%20Intro%20to%20causality%20non%20parametric.pptx)
  * Do the assignment below

## Cross-validation for Citibike trips
In this assignment we'll predict number of trips per day as a function of the weather on that day. Do all of your work in an RMarkdown file named `citibike_cv.Rmd`.

1. Create a data frame with one row for each day, the number of trips taken on that day, and the minimum temperature on that day.
2. Split the data into a randomly selected training and test set, as in the above exercise, with 80% of the data for training the model and 20% for testing.
3. Fit a model using ``lm`` to predict the number of trips as a (linear) function of the minimum temperature, and evaluate the fit on the training and testing data sets. Do this first visually by plotting the predicted and actual values as a function of the minimum temperature. Then do this with R^2 and RMSE on both the training and test sets. You'll want to use the ``predict`` and ``cor`` functions for this.
4. Repeat this procedure, but add a quadratic term to your model (e.g., ``+ tmin^2``, or (more or less) equivalently `` + poly(tmin,2)``). How does the model change, and how do the fits between the linear and quadratic models compare?
5. Now automate this, extending the model to higher-order polynomials with a ``for`` loop over the degree ``k``. For each value of ``k``, fit a model to the training data and save the R^2 on the training data to one vector and test vector to another. Then plot the training and test R^2 as a function of ``k``. What value of ``k`` has the best performance?
6. Finally, fit one model for the value of ``k`` with the best performance in 6), and plot the actual and predicted values for this model.

# Day 5

* Review these notebooks on [linear models](https://github.com/msr-ds3/coursework/blob/master/week2/linear_models.ipynb) with the `modelr` from the tidyverse and this one on [model evaluation](model_evaluation.ipynb) 
* See this [manual model fitting](https://jmhmsr.shinyapps.io/modelfit/) shiny app
* Do the assignment below

### Predicting daily Citibike trips
The point of this exercise is to get experience in an open-ended prediction exercise: predicting the total number of Citibike trips taken on a given day. Do all of your work in an RMarkdown file named `predict_citibike.Rmd`. Here are the rules of the game:

1. You can use any features you like that are available prior to the day in question, ranging from the weather, to the time of year and day of week, to activity in previous days or weeks, but don't cheat and use features from the future (e.g., the next day's trips). You might even try finding a CSV of holidays online and adding a factor for "is_holiday" to your model to see if this improves the fit.
2. As usual, split your data into training and testing subsets and evaluate performance on each.
3. Quantify your performance in two ways: R^2 (or the square of the correlation coefficient), as we've been doing, and with [root mean-squared error](https://www.kaggle.com/wiki/RootMeanSquaredError).
4. Report the model with the best performance on the test data. Watch out for overfitting.
5. Plot your final best fit model in two different ways. First with the date on the x-axis and the number of trips on the y-axis, showing the actual values as points and predicted values as a line. Second as a plot where the x-axis is the predicted value and the y-axis is the actual value, with each point representing one day.
5. Inspect the model when you're done to figure out what the highly predictive features are, and see if you can prune away any negligble features that don't matter much.
6. When you're convinced that you have your best model, clean up all your code so that it saves your best model in a ``.RData`` file.
7. Commit all of your changes to git, using ``git add -f`` to add the model ``.Rdata`` file if needed, and push to your Github repository.
8. Write a new file that loads in the [weather data for new days](weather_2015.csv) and your saved model, and predicts the number of trips for each day (see [load_trips.R](../week1/load_trips.R) for code snippets to load in the weather data).
9. Modify the [download_trips.sh](../week1/download_trips.sh) script to download trips from 2015 (instead of 2014). 
10. Compute the RMSE between the actual and predicted trips for 2015 and compare the results to what you found with cross-validation.
11. Pair up with a partner who has a different model, run their model, and evaluate the predictions it makes for the 2015 data.

-->