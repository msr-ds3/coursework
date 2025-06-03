This week covers:

  * More wrangling and plotting in R
  * Statistical inference
  * Regression
  * Overfitting / generalization

# Day 1

## Combining and reshaping data
  * Review [combine_and_reshape_in_r.ipynb](combine_and_reshape_in_r.ipynb) on joins with dplyr and reshaping with tidyr

## Plotting exercises
  * Finish up the Citibike plotting exercises in [plot_trips.R](../week1/plot_trips.R), including the plots that involve reshaping data

## Combining and reshaping exercises
  * Read chapters 5 and 19 of the 2nd edition of [R for Data Science](http://r4ds.had.co.nz) on reshaping and joins
  * Do the following exercises from the 1st edition of [R for Data Science](http://r4ds.had.co.nz):
    * Section [12.2.1](https://r4ds.had.co.nz/tidy-data.html#exercises-23), exercise 2
    * Section [12.3.3](https://r4ds.had.co.nz/tidy-data.html#exercises-24) exercises 1 and 3 

## Rmarkdown

  * Read Chapter 27 of the 1st edition of [R for Data Science](http://r4ds.had.co.nz) on Rmarkdown
  * Do the following exercises from the 1st edition of [R for Data Science](http://r4ds.had.co.nz):
    * Section [27.2.1](https://r4ds.had.co.nz/r-markdown.html#exercises-71), exercises 1 and 2 (try keyboard shortcuts: ctrl-shift-enter to run chunks, and ctrl-shift-k to knit the document)
    * Section [27.3.1](https://r4ds.had.co.nz/r-markdown.html#exercises-72) exercise 3, using [this file](diamond-sizes.Rmd)
    * Section [27.4.7](https://r4ds.had.co.nz/r-markdown.html#exercises-72), exercise 1

## Learn more

  * Do part 1 of Datacamp's [Cleaning Data in R](https://www.datacamp.com/courses/cleaning-data-in-r) tutorial
  * Additional references:
    * The tidyr [vignette on tidy data](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)
    * The dplyr [vignette on two-table verbs](https://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html) for joins
    * A [visual guide to joins](http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/)

# Day 2

## Sampling distributions and standard errors
  * See the [Statistical Inference & Hypothesis Testing](intro_to_stats.pptx) slides
  * Review the "Estimating a proportion" section of the [statistical inference Rmarkdown file](statistical_inference.Rmd) (preview the output [here](http://htmlpreview.github.io/?https://github.com/msr-ds3/coursework/blob/master/week2/statistical_inference.html))
  * Read Chapter 4 of an [Introduction to Statistical Thinking (With R, Without Calculus)](http://pluto.huji.ac.il/~msby/StatThink/) IST and do questions 4.1 and 4.2. Feel free to execute code in the book along the way.
  * Read Chapter 6 of IST on the normal distribution and do question 6.1
  * [Time permitting:] Read Chapter 7 of IST on sampling distributions and do exercise 7.1

## References
* Chapter 1 of the online textbook [Intro to Stat with Randomization and Simulation](https://www.openintro.org/book/isrs/) (ISRS)
* Interactive demos:
    * From the [Seeing theory](https://seeing-theory.brown.edu/) site:
      * [Random variables](https://seeing-theory.brown.edu/probability-distributions/index.html#section1)
      * [Basic probability](https://seeing-theory.brown.edu/basic-probability/index.html)
      * [Central limit theorem](https://seeing-theory.brown.edu/probability-distributions/index.html#section3)
      * [Confidence intervals](https://seeing-theory.brown.edu/frequentist-inference/index.html#section2)
    * An [interactive tutorial on sampling variability in polling](http://rocknpoll.graphics)
    * [Student t-distribution](http://rpsychologist.com/d3/tdist/)
<!--
* Some notes on expected values and variance, with proofs of their properties
    * [Expected value](https://brilliant.org/wiki/expected-value/), click through on "linearity of expectation" for proof
    * [Variance](https://brilliant.org/wiki/variance-definition/)
-->

<!--


# Day 2

## Hypothesis testing

  * Review the "Hypothesis testing" section of the [statistical inference Rmarkdown file](statistical_inference.Rmd) (preview the output [here](http://htmlpreview.github.io/?https://github.com/msr-ds3/coursework/blob/master/week2/statistical_inference.html))
  * Read Chapter 9 of IST and do exercise 9.1
  * Read Chapter 10 of IST and do exercises 10.1 and 10.2
  * Also check out the this analysis of [the color distribution of M&Ms](https://github.com/jhofman/delicious-statistics) that we discussed
  * Read Chapter 2 of the online textbook [Intro to Stat with Randomization and Simulation](https://www.openintro.org/book/isrs/) (ISRS) and do exercises 2.2 and 2.6
  * Read Sections 3.1 and 3.2 of ISRS
  * Do exercise 9.2 in IST

## References
  * See the relevant part of these [lecture notes](https://github.com/jhofman/msd2019-notes/blob/master/lecture_5/lecture_5.pdf) on statistics by simulation
  * Statistics for Hackers by VanderPlas ([slides](https://speakerdeck.com/jakevdp/statistics-for-hackers), [video](https://www.youtube.com/watch?v=Iq9DzN6mvYA))
  * See section 4 of [Mindless Statistics](http://library.mpib-berlin.mpg.de/ft/gg/GG_Mindless_2004.pdf) and [this article](https://link.springer.com/article/10.1007/s10654-016-0149-3) for some warnings on misinterpretations of p-values


# Day 3

  * Continue working on exercises from yesterday
  * Read Chapters 12 and 13 of IST and do exercises 12.1 and 13.1

## Power, effect sizes, and the replication crisis
  * See this [post](http://modelingsocialdata.org/lectures/2019/03/01/lecture-6-reproducibility-2.html) and the related [lecture notes](https://github.com/jhofman/msd2019-notes/blob/master/lecture_6/lecture_6.pdf) on effect sizes and the replication crisis
  * See this notebook on [statistical vs. practical significance](http://htmlpreview.github.io/?https://github.com/msr-ds3/coursework/blob/master/week2/statistically_significant_splits.html)
  * There's also an [interactive version](https://jhofman.github.io/statisticallysignificant/), play with it and see if you understand what's going on! 


## References
  * [Understanding Statistical Power and Significance Testing](https://rpsychologist.com/d3/NHST/)
  * [Calculating the power of a test](http://www.cyclismo.org/tutorial/R/power.html)
  * The American Statistical Association's [statement on p-values](https://amstat.tandfonline.com/doi/abs/10.1080/00031305.2016.1154108#.XE8wl89KjRY) by Wasserstein & Lazar
  * [Inference by eye](https://apastyle.apa.org/manual/related/cumming-and-finch.pdf) by Cumming and Finch
  * [Statistical tests, P values, confidence intervals, and power: a guide to misinterpretations](https://link.springer.com/article/10.1007%2Fs10654-016-0149-3) by Greenland et al.
  * [The Insignificance of Significance Testing](https://www.jstor.org/stable/3802789?seq=1#metadata_info_tab_contents) by Johnson
  * [The Insignificance of Null Hypothesis Significance Testing](https://journals.sagepub.com/doi/abs/10.1177/106591299905200309) by Gill
  * [Why Most Published Research Findings Are False](http://journals.plos.org/plosmedicine/article/file?id=10.1371/journal.pmed.0020124&type=printable)
  * Felix Schönbrodt's [blog post](http://www.nicebread.de/whats-the-probability-that-a-significant-p-value-indicates-a-true-effect/) and 
[shiny app](http://shinyapps.org/apps/PPV/) on misconceptions about p-values and false discoveries
  * [Interpreting Cohen's d effect size](https://rpsychologist.com/d3/cohend/)
  * [The New Statistics: Why and How](https://journals.sagepub.com/doi/pdf/10.1177/0956797613504966) by Cummings
  * A guide on [effect sizes](https://transparentstats.github.io/guidelines/effectsize.html) and related [blog post](https://transparentstatistics.org/2018/07/05/meanings-effect-size/)



# Day 4

## Regression

  * Review the [slides](regression.pdf) we covered in class
  * See this [shiny app on model fitting](https://jmhmsr.shinyapps.io/modelfit/) and this [tool for visualing least squares](https://seeing-theory.brown.edu/regression-analysis/index.html) (Dan's version [here](http://www.dangoldstein.com/dsn/archives/2006/03/every_wonder_ho.html) is similar, but requires Flash)
  * Read Chapter 5 of [Intro to Stats with Randomization and Simulation](https://drive.google.com/file/d/0B-DHaDEbiOGkRHNndUlBaHVmaGM/edit), do exercises 5.20 and 5.29
  * Read Section 3.1 of [Intro to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/), do Lab 3.6.2
  * See the [notebook on linear models](https://github.com/msr-ds3/coursework/blob/master/week2/linear_models.ipynb) with the `modelr` from the tidyverse

## References
  * Detailed [notes](https://github.com/jhofman/msd2019-notes/blob/master/lecture_7/lecture_7.pdf) on derivations for ordinary least squares regression with multiple predictors
  * Chapter 14 of [Introduction to Statistical Thinking](http://pluto.huji.ac.il/~msby/StatThink/)
  * [Formula syntax in R](https://cran.r-project.org/doc/manuals/R-intro.html#Formulae-for-statistical-models)
  * The "Model Basics" and "Model Building" Chapters in [R for Data Science](http://r4ds.had.co.nz) (Chapters 18 and 19 in the print edition, Chapters [23](http://r4ds.had.co.nz/model-basics.html) and [24](http://r4ds.had.co.nz/model-building.html) online) 
  * The [modelr](https://modelr.tidyverse.org) and [tidymodels](https://github.com/tidymodels/tidymodels) packages in R
  * An animation of [gradient descent](http://jakehofman.com/gd/) and a related [blog post](https://spin.atomicobject.com/2014/06/24/gradient-descent-linear-regression/)



# Day 5

## Regression (cont'd)

  * See this notebook on [model evaluation](model_evaluation.ipynb) 
  * See if you can reproduce the table in ISRS 5.29 using the original dataset in [body.dat.txt](body.dat.txt), taken from [here](http://jse.amstat.org/v11n2/datasets.heinz.html)
  * Do Labs 3.6.3 through 3.6.6 of [Intro to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/) to get practice with linear models in R
  * Read Sections 6.1 through 6.3 of ISRS on regression with multiple features
  * Do Exercises 6.1, 6.2, and 6.3, and use the original data set in [babyweights.txt](babyweights.txt), taken from [here](https://web.archive.org/web/20040906234424/http://www.ma.hw.ac.uk/~stan/aod/library/babies.dat.txt), to reproduce the results from the book


## References
  * Sections 3.2 and 3.3 of [Intro to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/) on regression with multiple features

-->




