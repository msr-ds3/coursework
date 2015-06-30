## Day 1
  * See today's lecture slides (to be posted)
  * Complete the Chapter 4 lab in ISL (pgs 154-168) and write up a full lab report in an [Rmarkdown](http://rmarkdown.rstudio.com) document
  * Go through [CodeAcademy's Python tutorial](http://www.codecademy.com/en/tracks/python)
  * See [learnpython's advanced tutorials](http://www.learnpython.org) on generators and list comprehensions
  * References
    * Rstudio's [Rmarkdown cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
	* [Pandoc](http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html) will let you convert markdown to [many different formats](http://pandoc.org)

## Day 2
  * See [intro.py](python/intro.py) for in-class python examples
  * Fill in the details of [stream_stats.py](python/stream_stats.py) to create a script that takes as input a text file with two tab-separated columns with one observation per line and outputs summary statistics for each group in the data. The first column in the input file is a "key" that represents the group and the second column is a numeric value for the observation within that group. You'll implement several versions of this script:
    * First, compute the minimum, mean, and maximum value within each group, assuming that the observations are ordered arbitrarily.
	* Next, modify this to compute the median within each group as well. Comment on how this changes the memory usage of your program.
	* Finally, assume that the data are given to you sorted by the key, so that all of a group's observations are listed consecutively within the file. Comment on how this assumption changes the minimum memory footprint needed by your program.
    * [Sample input](python/sample_input.tsv) and [output](python/sample_output.tsv) are provided, where the output gives the key followed by all statistics (min, median, mean, and max).

<!-- 
  gedit: http://learnpythonthehardway.org/book/ex0.html
  plugin: https://wiki.gnome.org/Apps/Gedit/PythonPluginHowTo
          https://help.gnome.org/users/gedit/stable/gedit-plugins-pyconsole.html.en
  options: https://wiki.python.org/moin/IntegratedDevelopmentEnvironments
-->
<!-- repeat chapter 4 lab w/ ggplot2, broom, etc -->
