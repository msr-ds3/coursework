
# Day 1

 * Make sure to finish and commit your solution to last week's Citibike modeling problem, with a new Rmd file that loads the 2015 weather and trip data, makes predictions using your model, and summarizes the model's performance

## Classification: Naive Bayes
  * Review the [slides](https://www.slideshare.net/jakehofman/modeling-social-data-lecture-6-classification-with-naive-bayes) on classification
  * The [(super) naive Bayes](enron_naive_bayes.sh) shell script from lecture
  * Complete this [naive Bayes lab](https://rpubs.com/dvorakt/144238)
  * Think about the complexity of naive Bayes:
    * Assume you're given D documents that contain words from a vocabulary of total size V, and that documents contain w words, on average. For instance, you might have D = 1,000 emails that are labeled spam or not spam, with a vocabulary of V = 100,000 possible words, where emails contains 100 words, on average.
    * What is the running time for estimating the parameters for version of naive Bayes described in the slides?
    * What are the space requirements?
    * What is the cost of making a prediction on a new document once you've estimated the paramters?
    * State all of your answers in terms of D, V, and w.

## Computational Complexity
  * [Sid Sen](http://www.cs.princeton.edu/~sssix/) gave a guest lecture on computational complexity, data structures, and algorithms. Some references:
    * [Typed notes](https://github.com/jhofman/msd2017-notes/blob/master/lecture_3/lecture_3.pdf) that cover Sid's lecture
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

# Day 2

## Fitting linear models

  * See [here](http://modelingsocialdata.org/lectures/2017/02/24/lecture-6-regression-1.html) for a table of complexity for model fitting and [here](https://github.com/jhofman/msd2017-notes/blob/master/lecture_6/lecture_6.pdf) for the gory details behind solving the normal equations and gradient descent
  * See this animation of [gradient descent](http://htmlpreview.github.io/?https://github.com/jhofman/msd2017/blob/master/lectures/lecture_6/gradient_descent.html)

## Classification: Evaluation, logistic regression
  * Review this [code](classification.ipynb) for classification
  * See [here](https://github.com/jhofman/msd2017-notes/blob/master/lecture_9/lecture_9.pdf) for notes on logistic regression and classifier evaluation
  * For more on ROC curves, see [this video](http://www.dataschool.io/roc-curves-and-auc-explained/) and the accompanying [interactive demo](http://www.navan.name/roc/)
  * Do this [logistic regression lab](https://rpubs.com/dvorakt/255527) using copies of the `lending_club_cleaned.csv` ([source](https://www.lendingclub.com/info/download-data.action)) and `titanic_train.csv` ([source](https://www.kaggle.com/c/titanic/data)) datasets that are checked into this repo

<!--
  * Complete the next [naive Bayes lab](https://rpubs.com/dvorakt/245720), see [here](https://en.wikipedia.org/wiki/Confusion_matrix) for terminology (sensitivity = recall, specificity = true negative rate)
-->

# Day 3

  * See [code](plotting_logit_models.R) from class for plotting logit models (preview output [here](http://htmlpreview.github.io/?https://raw.githubusercontent.com/msr-ds3/coursework/master/week3/plotting_logit_models.html))
  * Review the [slides](experiments.pptx) on causality and randomized experiments
  * See the [references](http://modelingsocialdata.org/lectures/2017/04/21/lecture-12-causality-and-experiments-2.html) in this post for more on the reproducibility crisis

## Causality and Experiments
  * Review chapter 12 of Intro to Statistical Thinking (IST) and do question 12.1
  * Review chapter 13 of IST and do question 13.1. Answer the following two additional questions for this problem:
    * Make a plot of the distribution of outcomes (`change`) split by the treatment (`active`), similar to [this plot](http://rpsychologist.com/d3/cohend/)
    * Estimate the effect size by calculating [Cohen's d](https://en.wikiversity.org/wiki/Cohen%27s_d). Think about whether the effect seems practically meaningful.

# Day 4
  * See the [slides](Day%204%20-%20Inferring%20Causality%20with%20Observational%20Settings.pptx) on causal inference from observational data and natural experiments
  * Do the [homework](Homework%204.pdf) on difference-in-differences

# Day 5
  * See the [slides](Day%205%20-%20RD%20%26%20IV.pptx) on regression discontinuity designs and instrumental variables
  * Do the [homework](Homework%205%20-%20RD.pdf) on regression discontinuity 