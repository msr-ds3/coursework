
# Day 1

 * Make sure to finish and commit your solution to last week's Citibike modeling problem, with a new Rmd file that loads the 2015 weather and trip data, makes predictions using your model, and summarizes the model's performance

## Classification
  * Review the [slides](https://www.slideshare.net/jakehofman/modeling-social-data-lecture-6-classification-with-naive-bayes) and [code](classification.ipynb) on classification
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

<!--
  * And this [logistic regression lab](https://rpubs.com/dvorakt/151334)

# Day 2
  * [Notes](https://github.com/jhofman/msd2017-notes/blob/master/lecture_9/lecture_9.pdf) on naive Bayes, logistic regression, and classifier evaluation
  * A video explaining [ROC curves](http://www.dataschool.io/roc-curves-and-auc-explained/) with an accompanying [interactive demo](http://www.navan.name/roc/)
-->

<!-- https://github.com/msr-ds3/coursework/blob/2016/week4/README.md#day-3 -->