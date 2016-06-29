This week covers:

  * An intro to Git and Github for sharing code
  * Command line tools
  * Exploratory data analysis with R using ``dplyr`` and ``ggplot2``

# Day 1

## Setup

Install git, R, and RStudio:

  * Install git: ``sudo apt-get install git``
  * In the terminal, type ``sudo gedit``
  * Create a new document containing a [CRAN mirror](http://cran.r-project.org/mirrors.html): ``deb http://cran.rstudio.com/bin/linux/ubuntu xenial/``
  * Save it as ``/etc/apt/sources.list.d/cran.list`` and close gedit
  * In the terminal, authorize a server with the latest R packages by typing
```
      gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
	  gpg -a --export E084DAB9 | sudo apt-key add -
```
  * Then ``sudo apt-get update`` to update the package list
  * Install R with ``sudo apt-get install r-base r-base-dev``
  * Download the [latest RStudio .deb](http://www.rstudio.com/products/rstudio/download/) package: ``wget https://download1.rstudio.org/rstudio-0.99.902-amd64.deb``
  * Install gdebi to help with package dependencies: ``sudo apt-get install gdebi-core``
  * Use gdebi to install the RStudio package: ``sudo gdebi -n rstudio-0.99.902-amd64.deb``
  * Start RStudio, either with ``rstudio`` from the command line or through the Ubuntu launcher (note: you can use ctrl-z followed by ``bg`` in the terminal to place the rstudio process in the background)

## Intro to Git(Hub)

### Make your first commit and pull request
  * Complete this [free online git course](https://try.github.io) and 
  * [Sign up](https://github.com/join) for a free GitHub account
  * Follow Rstudio's [initial set up](http://r-pkgs.had.co.nz/git.html#git-init) to create an RSA key and upload the public portion to Github (steps 2-5 of "Initial set up" only)
  * Then follow this guide to [fork your own copy](https://guides.github.com/activities/forking/) of the course repository
  * [Clone a copy of your forked repository](https://help.github.com/articles/cloning-a-repository/), which should be located at ``git@github.com/<yourusername>/coursework.git``, to your local machine
  * Once that's done, create a new file in the ``week1/students`` directory, ``<yourfirstname>.txt`` (e.g., ``jake.txt``)
  * Use ``git add`` to add the file to your local repository
  * Use ``git commit`` and ``git push`` to commit and push your changes to your copy of the repository
  * Then issue a [pull request](https://guides.github.com/activities/forking/#making-a-pull-request) to send the changes back to the original course repository
  * Finally, [configure a remote repository](https://help.github.com/articles/configuring-a-remote-for-a-fork/) called ``upstream`` to point here:
```
    git remote add upstream git@github.com:msr-ds3/coursework
```
  * This will allow you to [sync future changes](https://help.github.com/articles/syncing-a-fork/) to your fork with:
```
    git fetch upstream
	git merge upstream/master
```
  * Note: this is equivalent to ``git pull upstream master``

### Learn more (optional)
  * Watch this [introductory video](https://www.youtube.com/watch?v=U8GBXvdmHT4)
  * More resources are available [here](https://help.github.com/articles/good-resources-for-learning-git-and-github/)
  * And here's a handy [cheatsheet](https://services.github.com/kit/downloads/github-git-cheat-sheet.pdf)
  
## Intro to the Command Line
  * Read through [Lifehacker's command line primer](http://lifehacker.com/5633909/who-needs-a-mouse-learn-to-use-the-command-line-for-almost-anything)
  * See this [crash course](http://cli.learncodethehardway.org/book/) for more details on commonly used commands
  * Check out Software Carpentry's [guide to the Unix shell](http://swcarpentry.github.io/shell-novice/)
  * Review this wikibook on [data analysis on the command line](http://en.wikibooks.org/wiki/Ad_Hoc_Data_Analysis_From_The_Unix_Command_Line), covering ``cut``, ``grep``, ``wc``, ``uniq``, ``sort``, etc
  * Learn [awk in 20 minutes](http://ferd.ca/awk-in-20-minutes.html)
  * Check out some more advanced tools for [Data Science at the Command Line](http://datascienceatthecommandline.com)

# Day 2

## Command line exercises

  * Review [intro.sh](shell/intro.sh) for an introduction to the command line
  * Download one month of the [Citibike data](https://www.citibikenyc.com/system-data): ``wget https://s3.amazonaws.com/tripdata/201402-citibike-tripdata.zip``
  * Decompress it: ``unzip 201402-citibike-tripdata.zip``
  * Rename the resulting file to get rid of ugly spaces: ``mv 2014-02*.csv 201402-citibike-tripdata.csv``
  * Review the one-liners in the [explore_trips.sh](citibike/explore_trips.sh) file
  * Fill in solutions of your own under each comment in [exercises.sh](citibike/exercises.sh)

## Intro to R

  * Start the [Code School](http://tryr.codeschool.com) and [DataCamp](http://datacamp.com/courses/free-introduction-to-r) tutorials (or Hadley's [Advanced R](http://adv-r.had.co.nz) if you're a pro)
  * References:
    * [Basic types](http://www.r-tutor.com/r-introduction/basic-data-types): (numeric, character, logical, factor)
    * Vectors, lists, dataframes: a [one page reference](http://www.statmethods.net/input/datatypes.html) and [more details](https://en.wikibooks.org/wiki/R_Programming/Data_types)
	* [Cyclismo's](http://www.cyclismo.org/tutorial/R/index.html) more extensive tutorial
    * Hadley Wickham's [style guide](http://adv-r.had.co.nz/Style.html)

# Day 3

## Counting and Plotting
  * See these [Introduction to Counting](http://www.slideshare.net/jakehofman/lecture-2-44332354) slides
  * Install these [recommended packages](http://r4ds.had.co.nz/introduction.html#r-packages)
    * Note: if ``readr`` fails to install, run the following in the terminal and try installing again: ``sudo apt-get install libcurl4-gnutls-dev``
  * Review [intro.Rmd](r/intro.Rmd) for an introduction to R
  * Complete yesterday's Intro to R tutorials if you haven't already
  * Plotting with ``ggplot2``
    * Read the [data visualization](http://r4ds.had.co.nz/data-visualisation.html) of ["R for Data Science"](http://r4ds.had.co.nz) chapter and go over the included exercises
    * Review Sean Anderson's [ggplot2 slides](http://seananderson.ca/courses/12-ggplot2/ggplot2_slides_with_examples.pdf) ([code]((http://github.com/seananderson/datawranglR)) and reproduce the ``diamonds`` plots in these slides.
    * Bookmark Rstudio's [data visualization cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/12/ggplot2-cheatsheet-2.0.pdf)
    * Optionally do the free portion of DataCamp's [Data Visualization with ggplot2](https://campus.datacamp.com/courses/data-visualization-with-ggplot2-1/) tutorial    
  * Data manipulation with ``dplyr``
    * Read the [data transformation](http://r4ds.had.co.nz/transform.html) chapter of "R for Data Science" and go over the included exercises
    * Review Sean Anderson's [dplyr and pipes examples](http://seananderson.ca/2014/09/13/dplyr-intro.html) ([code](https://github.com/seananderson/dplyr-intro-2014) on github)
    * Bookmark Rstudio's [data wrangling cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
    * Optionally do the free portion of DataCamp's [Data Manipulation in R](https://campus.datacamp.com/courses/dplyr-data-manipulation-r-tutorial) tutorial
  * Additional references
    * The [dplyr vignette](http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html) 
	* The [R Graphics Cookbook](http://www.cookbook-r.com/Graphs/)
	* [Intro to ggplot2](http://superbobry.github.io/slides/ggplot2/) slides, with somewhat tricky navigation
	* [Visualizing Data with ggplot2](http://varianceexplained.org/RData/lessons/lesson2/)
    * The [official ggplot2 docs](http://docs.ggplot2.org/current/)


# Day 4

## Counting and Plotting (cont'd)
  * We wrote [musical pairs](r/musical_pairs.R) to randomly pair up people to work together each day
  * Use the [download_trips.sh](citibike/download_trips.sh) script to download a year of the Citibike data
  * Run the [load_trips.R](citibike/load_trips.R) file with data in your citibike folder to generate ``trips.RData``
  * Fill in the missing code in [explore_trips.R](citibike/explore_trips.R) to redo the counts we did in the shell, this time in R
  * Write code in [plot_trips.R](citibike/plot_trips.R) to recreate the plots we made this morning 
  * Use the [download_movielens.sh](movielens/download_movielens.sh) script to download the [MovieLens data](http://grouplens.org/datasets/movielens/)
  * Fill in code in the [movielens.R](movielens/movielens.R) file to reproduce the plots from this morning's "Introduction to Counting" lecture
  
# Day 5

## Guest lecture: Computational Complexity
  * [Sid Sen](http://www.cs.princeton.edu/~sssix/) gave a guest lecture on computational complexity, data structures, and algorithms. Some references:
    * [Big-O notation](https://www.interviewcake.com/big-o-notation-time-and-space-complexity)
	* A [beginner's guide](https://rob-bell.net/2009/06/a-beginners-guide-to-big-o-notation/) to big-O notation
    * The [bigocheatsheet](http://bigocheatsheet.com)
    * Hash tables on [Wikipedia](https://en.wikipedia.org/wiki/Hash_table) and [Spark Notes](http://www.sparknotes.com/cs/searching/hashtables/summary.html)

    
## Joining and reshaping
  
  * Continue working on yesterday's Citibike and Movielens exercises
  * Joining data
    * Review the [joins.R](r/joins.R) examples from class
    * Go through this [visual guide to joins](http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/) and the join functions in the [dplyr two-table verb](http://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html) vignette
    * Read the [relational data](http://r4ds.had.co.nz/relational-data.html) chapter of "R for Data Science" and go over the included exercises
  * Reshaping data
    * Review the [tidy.R](r/tidy.R) example from class
    * Read the [tidy data](http://r4ds.had.co.nz/transform.html) chapter of "R for Data Science" and go over the included exercises

## Save your work
  * Make sure to save your work and push it to GitHub. Do this is three steps:
  	1. ``git add`` and ``git commit`` and new files to your local repository. (Omit large data files.)
  	2. ``git pull upstream master`` to grab changes from this repository, and resolve any merge conflicts, commiting the final results.
  	3. ``git push origin master`` to push things back up to your GitHub fork of the course repository. 