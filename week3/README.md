This week covers:

  * More statistics: hypothesis testing, effect sizes, and regression

# Day 1

## Hypothesis testing (cont'd)

  * We reviewed hypothesis testing and power calculations on the whiteboard (see [notes](https://github.com/jhofman/msd2019-notes/blob/master/lecture_5/lecture_5.pdf))
  * We went over the quiz in [Mindless Statistics](http://library.mpib-berlin.mpg.de/ft/gg/GG_Mindless_2004.pdf) by Gigerenzer about common misconceptions around testing and p-values

  * Finish up [last week's stats exercises](https://github.com/msr-ds3/coursework/tree/master/week2#stats-again)

## References

  * [Understanding Statistical Power and Significance Testing](https://rpsychologist.com/d3/NHST/)
  * [Calculating the power of a test](http://www.cyclismo.org/tutorial/R/power.html)
  * The American Statistical Association's [statement on p-values](https://amstat.tandfonline.com/doi/abs/10.1080/00031305.2016.1154108#.XE8wl89KjRY) by Wasserstein & Lazar
  * [Inference by eye](https://apastyle.apa.org/manual/related/cumming-and-finch.pdf) by Cumming and Finch
  * [Statistical tests, P values, confidence intervals, and power: a guide to misinterpretations](https://link.springer.com/article/10.1007%2Fs10654-016-0149-3) by Greenland et al.
  * [The Insignificance of Significance Testing](https://www.jstor.org/stable/3802789?seq=1#metadata_info_tab_contents) by Johnson
  * [The Insignificance of Null Hypothesis Significance Testing](https://journals.sagepub.com/doi/abs/10.1177/106591299905200309) by Gill

# Day 2

## Field trip

  * We took a field trip to the American Museum of Natural History to visit there [AstroCom data science program](https://cunyastro.org/astrocom/)!


# Day 3

## Effect sizes

  * We talked about false discoveries and effect sizes on the whiteboard (see [notes](https://github.com/jhofman/msd2019-notes/blob/master/lecture_6/lecture_6.pdf))

  * Replicate and extend the results of the [Google n-grams "culturomics" paper](https://science.sciencemag.org/content/331/6014/176) using the template [here](../week2/ngrams)

## References

  * [Why Most Published Research Findings Are False](http://journals.plos.org/plosmedicine/article/file?id=10.1371/journal.pmed.0020124&type=printable)
  * Felix Schönbrodt's [blog post](http://www.nicebread.de/whats-the-probability-that-a-significant-p-value-indicates-a-true-effect/) and 
[shiny app](http://shinyapps.org/apps/PPV/) on misconceptions about p-values and false discoveries
  * [Interpreting Cohen's d effect size](https://rpsychologist.com/d3/cohend/)
  * [The New Statistics: Why and How](https://journals.sagepub.com/doi/pdf/10.1177/0956797613504966) by Cummings
  * A guide on [effect sizes](https://transparentstats.github.io/guidelines/effectsize.html) and related [blog post](https://transparentstatistics.org/2018/07/05/meanings-effect-size/)


# Day 4

## Regression

  * We introduced regression and derived the best-fit parameters for a simple linear model
  * See [slides](https://speakerdeck.com/jhofman/modeling-social-data-lecture-7-regression-part-1) for a high-level framing and [notes](https://github.com/jhofman/msd2019-notes/blob/master/lecture_7/lecture_7.pdf) for derivation
  
  * Read Chapter 5 of [Intro to Stats with Randomization and Simulation](https://drive.google.com/file/d/0B-DHaDEbiOGkRHNndUlBaHVmaGM/edit), do exercises 5.20, 5.29
  * Read Section 3.1 of [Intro to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/), do Lab 3.6.2
  * See if you can reproduce the table in ISRS 5.29 using [the original dataset](http://jse.amstat.org/v11n2/datasets.heinz.html)

## References

  * This interactive [shiny app](https://jmhmsr.shinyapps.io/modelfit/) on manual model fitting
  * Chapters 1 and 2 of [Advanced Data Analysis from an Elementary Point of View](http://www.stat.cmu.edu/%7Ecshalizi/ADAfaEPoV/)

  
# Day 5

## Regression (cont'd)

  * See this [notebook](linear_models.ipynb) on fitting and visualizing linear models and this [notebook](model_evaluation.ipynb) on model evaluation
  * Read Sections 6.1 through 6.3 of [Intro to Stats with Randomization and Simulation](https://drive.google.com/file/d/0B-DHaDEbiOGkRHNndUlBaHVmaGM/edit)
  * Do Exercises 6.1, 6.2, and 6.3, and use the original data set in [babyweights.txt](babyweights.txt), taken from [here](https://web.archive.org/web/20040906234424/http://www.ma.hw.ac.uk/~stan/aod/library/babies.dat.txt), to reproduce the results from the book
  * Read Sections 3.2 and 3.3 of [Intro to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/)
  * Do Labs 3.6.3 through 3.6.6

  
## References
  * A [visualization of ordinary least squares regression](https://seeing-theory.brown.edu/regression-analysis/index.html#section1)
  * The "Model Basics" and "Model Building" Chapters in [R for Data Science](http://r4ds.had.co.nz) (Chapters 18 and 19 in the print edition, Chapters [23](http://r4ds.had.co.nz/model-basics.html) and [24](http://r4ds.had.co.nz/model-building.html) online) 
  * The [modelr](https://modelr.tidyverse.org) and [tidymodels](https://github.com/tidymodels/tidymodels) packages in R