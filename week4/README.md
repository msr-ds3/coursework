## Day 1
  * Finish up last week's classification exercises
  * Go through [this notebook](http://rpubs.com/jhofman/nb_vs_lr) comparing naive Bayes and logistic regression on the spam dataset from [Elements of Statistical Learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/)
    * See [ROC Curve, Lift Chart, and Calibration plot](http://mrvar.fdv.uni-lj.si/pub/mz/mz3.1/vuk.pdf), [An introduction to ROC analysis](https://ccrma.stanford.edu/workshops/mir2009/references/ROCintro.pdf) and [interactive demo](http://www.navan.name/roc/) to understand ROC curves, precision, recall, etc.
    * See Figures 2 and 3 in [this paper](http://faculty.engr.utexas.edu/bickel/Papers/TWC_Calibration.pdf) for calibration plots for predicting rain
  * More on [Hypothetical Outcome Plots](https://medium.com/hci-design-at-uw/hypothetical-outcomes-plots-experiencing-the-uncertain-b9ea60d7c740) from [Jessica Hullman's](http://faculty.washington.edu/jhullman/) talk
  * [David Robinson](http://varianceexplained.org/about/) gave a guest lecture on his work as a data scientist at [Stack Exchange](https://en.wikipedia.org/wiki/Stack_Exchange)

## Day 2
  * Start the [Codecademy Python tutorial](https://www.codecademy.com/learn/python)
  * See [intro.py](intro.py) for in-class python examples
  * See [learnpython's advanced tutorials](http://www.learnpython.org) on generators and list comprehensions
  * Fill in the details of [stream_stats.py](stream_stats.py) to create a script that takes as input a text file with two tab-separated columns with one observation per line and outputs summary statistics for each group in the data. The first column in the input file is a "key" that represents the group and the second column is a numeric value for the observation within that group. You'll implement several versions of this script:
    * First, compute the minimum, mean, and maximum value within each group, assuming that the observations are ordered arbitrarily
	* Next, modify this to compute the median within each group as well and comment on how this changes the memory usage of your program
	* Finally, assume that the data are given to you sorted by the key, so that all of a group's observations are listed consecutively within the file and comment on how this assumption changes the minimum memory footprint needed by your program
    * [Sample input](sample_input.tsv) and [output](sample_output.tsv) are provided, where the output gives the key followed by all statistics (min, median, mean, and max)
  * [Fernando](http://research.microsoft.com/jump/164338) gave a guest lecture on [how to read research papers](reading-papers.pptx)
  * Read [Exposure to ideologically diverse news and opinion on Facebook](http://www.sciencemag.org/content/348/6239/1130.abstract). Also check out the [supplemental material](http://www.sciencemag.org/content/348/6239/1130/suppl/DC1) and open sourced [data and code](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/LDJ7MS)