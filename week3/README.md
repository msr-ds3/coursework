## Day 1
  * See today's lecture slides (to be posted)
  * Complete the Chapter 4 lab in ISL (pgs 154-168) and write up a full lab report in an [Rmarkdown](http://rmarkdown.rstudio.com) document
  * Go through [CodeAcademy's Python tutorial](http://www.codecademy.com/en/tracks/python)
  * References
    * Rstudio's [Rmarkdown cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
	* [Pandoc](http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html) will let you convert markdown to [many different formats](http://pandoc.org)

## Day 2
  * Install iPython: ``sudo apt-get install ipython ipython-notebook`` (or ``sudo apt-get install pip; pip install "ipython[notebook]"``)
    * Tips for using iPython [interactively](http://ipython.org/ipython-doc/stable/interactive/index.html) and [iPython notebooks](http://ipython.org/ipython-doc/stable/notebook/index.html)
  * See [intro.py](python/intro.py) for in-class python examples
  * See [learnpython's advanced tutorials](http://www.learnpython.org) on generators and list comprehensions
  * Fill in the details of [stream_stats.py](python/stream_stats.py) to create a script that takes as input a text file with two tab-separated columns with one observation per line and outputs summary statistics for each group in the data. The first column in the input file is a "key" that represents the group and the second column is a numeric value for the observation within that group. You'll implement several versions of this script:
    * First, compute the minimum, mean, and maximum value within each group, assuming that the observations are ordered arbitrarily.
	* Next, modify this to compute the median within each group as well. Comment on how this changes the memory usage of your program.
	* Finally, assume that the data are given to you sorted by the key, so that all of a group's observations are listed consecutively within the file. Comment on how this assumption changes the minimum memory footprint needed by your program.
    * [Sample input](python/sample_input.tsv) and [output](python/sample_output.tsv) are provided, where the output gives the key followed by all statistics (min, median, mean, and max).

## Day 3
  * Read Section 6.2 of ISL
  * Do the "Ridge Regression and Lasso" lab in Section 6.6 of ISL
  * Go through the first 5 sections of the [glmnet vignette](http://web.stanford.edu/~hastie/glmnet/glmnet_beta.html)

<!-- 
  gedit: http://learnpythonthehardway.org/book/ex0.html
  plugin: https://wiki.gnome.org/Apps/Gedit/PythonPluginHowTo
          https://help.gnome.org/users/gedit/stable/gedit-plugins-pyconsole.html.en
  options: https://wiki.python.org/moin/IntegratedDevelopmentEnvironments
-->
<!-- repeat chapter 4 lab w/ ggplot2, broom, etc -->
