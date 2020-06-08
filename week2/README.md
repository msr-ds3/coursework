This week covers:

  * More wrangling and plotting in R
  * Statistical inference
  * Regression
  * Classification
  * Overfitting / generalization



# Day 1

<!--
## Plotting (cont'd)

  * Review [visualization_with_ggplot2.ipynb](../week1/visualization_with_ggplot2.ipynb) for an introduction to data visualization with ggplot2

## The Anatomy of the Long Tail
  * Use the [download_movielens.sh](download_movielens.sh) script to download the [MovieLens data](http://grouplens.org/datasets/movielens/)
  * Fill in code in the [movielens.Rmd](movielens.Rmd) file to reproduce the plots from Wednesday's slides
  * Sketch out (on paper) how to generate figure 2 from [The Anatomy of the Long Tail](https://5harad.com/papers/long_tail.pdf)
  * Write code to do this in the last section of [movielens.Rmd](movielens.Rmd)

-->

<!--

# Day 5

## Reproducibility
  * Review the slides for [reproducible code](reproducible_code.pptx)
  * Read this [Introduction to Make](https://bost.ocks.org/mike/make/) and [Make for Data Scientists](http://blog.kaggle.com/2012/10/15/make-for-data-scientists/)

-->




## Intro to stats
  * See the [Statistical Inference & Hypothesis Testing](intro_to_stats.pptx) slides
  * Review the "Estimating a proportion" section of the [statistical inference Rmarkdown file](statistical_inference.Rmd) (preview the output [here](http://htmlpreview.github.io/?https://github.com/msr-ds3/coursework/blob/master/week2/statistical_inference.html))
  * Read Chapter 4 of an [Introduction to Statistical Thinking (With R, Without Calculus)](http://pluto.huji.ac.il/~msby/StatThink/) IST and do questions 4.1 and 4.2. Feel free to execute code in the book along the way.
  * Read Chapter 6 of IST on the normal distribution and do question 6.1
  * Read Chapter 7 of IST on sampling distributions and do exercise 7.1
  * Read Chapter 9 of of IST and do exercise 9.1

<!--
  	 * Example 5 in Section 8.3.5
    * Do question 9.2
  	 * Questions 10.1 and 10.2
  	 * Questions 11.1 and 11.3

    * Do the following exercises in Section 2.9 of ISRS: 2.2, 2.5, 2.21, 2.23
    * Read Sections 3.1 and 3.2 of ISRS
-->


## References
* Chapters 1 and 2 of the online textbook [Intro to Stat with Randomization and Simulation](https://www.openintro.org/stat/textbook.php) (ISRS)
* Statistics for Hackers by VanderPlas ([slides](https://speakerdeck.com/jakevdp/statistics-for-hackers), [video](https://www.youtube.com/watch?v=Iq9DzN6mvYA))
* Interactive demos:
    * From the [Seeing theory](http://students.brown.edu/seeing-theory/) site:
      * [Random variables](http://students.brown.edu/seeing-theory/probability-distributions/index.html#section1)
      * [Basic probability](http://students.brown.edu/seeing-theory/basic-probability/index.html)
      * [Central limit theorem](http://students.brown.edu/seeing-theory/probability-distributions/index.html#section3)
      * [Confidence intervals](http://students.brown.edu/seeing-theory/frequentist-inference/index.html#section2)
    * An [interactive tutorial on sampling variability in polling](http://rocknpoll.graphics)
    * [Student t-distribution](http://rpsychologist.com/d3/tdist/)

<!--

# Day 2

# Day 3
  
# Day 4

# Day 5

## Hypothesis testing

  * We talked about hypothesis testing via simulation on the whiteboard
  * Review the "Hypothesis testing" section of the [statistical inference Rmarkdown file](statistical_inference.Rmd) (preview the output [here](http://htmlpreview.github.io/?https://github.com/msr-ds3/coursework/blob/master/week2/statistical_inference.html))
  * See notes [here](https://github.com/jhofman/msd2019-notes/blob/master/lecture_5/lecture_5.pdf)

## Stats (again!)

  * Read Chapter 2 of [Intro to Stat with Randomization and Simulation](https://www.openintro.org/stat/textbook.php) (ISRS)
  * Do these two problems:
    * [Power calculation for the link between coffee and cancer](https://github.com/jhofman/msd2019/tree/master/homework/homework_2/problem_1)
    * [Is yawning contagious?](https://github.com/jhofman/msd2019/tree/master/homework/homework_2/problem_2)
    
<!--

  * Review the third chapter of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/index.html) and work on the associated lab

  * See section 4 of [Mindless Statistics](http://library.mpib-berlin.mpg.de/ft/gg/GG_Mindless_2004.pdf) and [this article](https://link.springer.com/article/10.1007/s10654-016-0149-3) for some warnings on misinterpretations of p-values

-->

<!--

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