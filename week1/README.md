This week covers:

  * An intro to Git and Github for sharing code
  * Command line tools
  * Exploratory data analysis with R

# Setup

Install git, R, and RStudio:

  * Install git: ``sudo apt-get install git``
  * In the terminal, type ``sudo gedit``
  * Create a new document containing a [CRAN mirror](http://cran.r-project.org/mirrors.html): ``deb http://lib.stat.cmu.edu/R/CRAN/bin/linux/ubuntu trusty/``
  * Save it as ``/etc/apt/sources.list.d/cran.list`` and close gedit
  * In the terminal, type ``sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9`` to authorize a server with the latest R packages
  * Then ``sudo apt-get update`` to update the package list
  * Install R with  ``sudo apt-get install r-base``
  * Download the [latest RStudio .deb](http://www.rstudio.com/products/rstudio/download/) package: ``wget http://download1.rstudio.org/rstudio-0.99.442-amd64.deb``
  * Install a dependency for RStudio: ``sudo apt-get install libjpeg62``
  * Install the package: ``sudo dpkg -i rstudio-0.99.442-amd64.deb``
  * Start RStudio, either with ``rstudio`` from the command line or through the Ubuntu launcher
  * Follow Rstudio's [initial set up](http://r-pkgs.had.co.nz/git.html#git-init) to create an RSA key and upload the public portion to Github

# Intro to Git(Hub)

## Your first pull request
  * [Sign up](https://github.com/join) for a free GitHub account
  * Then [fork your own copy](https://guides.github.com/activities/forking/) of the course repository
  * See these [screenshots](http://www.princeton.edu/~mjs3/soc504_s2015/submitting_homework.shtml) for details, with one modification: use the *ssh clone URL* in the repository URL field, which should read ``git@github.com:yourusername/ds3-2015.git``
  * Once that's done, edit the ``week1/students.txt`` file and add your first name<sup>[1](#improvement1)</sup>
  * Commit and push your changes to your copy of the repository through RStudio
  * Then issue a [pull request](https://guides.github.com/activities/forking/#making-a-pull-request) to send the changes back to the original repository
  * Finally, [configure a remote repository](https://help.github.com/articles/configuring-a-remote-for-a-fork/) called ``upstream`` to point here:
```
    git remote add upstream git@github.com:jhofman/ds3-2015
```
  * This will allow you to [sync future changes](https://help.github.com/articles/syncing-a-fork/) to your fork with:
```
    git fetch upstream
	git merge upstream/master
```

## Learn more
  * Complete this [free online git course](https://try.github.io) and watch this [introductory video](https://www.youtube.com/watch?v=U8GBXvdmHT4)
  * More resources are available [here](https://help.github.com/articles/good-resources-for-learning-git-and-github/)
  * And here's a handy [cheatsheet](https://training.github.com/kit/downloads/github-git-cheat-sheet.pdf)

# Intro to the Command line

  * Review [intro.sh](shell/intro.sh) for an introduction to the command line
  * Download one month of the Citibike data: ``wget https://s3.amazonaws.com/tripdata/201402-citibike-tripdata.zip``
  * Decompress it: ``unzip 201402-citibike-tripdata.zip``
  * Rename the resulting file to get rid of ugly spaces: ``mv 2014-02*.csv 201402-citibike-tripdata.csv``
  * Go through the one-liners in the [explore_trips.sh](citibike/explore_trips.sh) file
  * Fill in solutions of your own under each comment in [exercises.sh](citibike/exercises.sh)
  * Additional command line references:
    * [Lifehacker's primer](http://lifehacker.com/5633909/who-needs-a-mouse-learn-to-use-the-command-line-for-almost-anything) and a [crash course](http://cli.learncodethehardway.org/book/) with an overview of commonly used commands
    * Software Carpentry's [slides and videos](http://software-carpentry.org/v4/shell/) (updates [here](http://swcarpentry.github.io/shell-novice/))
    * A wikibook on [data analysis on the command line](http://en.wikibooks.org/wiki/Ad_Hoc_Data_Analysis_From_The_Unix_Command_Line), covering ``cut``, ``grep``, ``wc``, ``uniq``, ``sort``, etc
    * [introduction to awk](http://ferd.ca/awk-in-20-minutes.html)
    * A comprehensive and freely available [command line book](http://softlayer-dal.dl.sourceforge.net/project/linuxcommand/TLCL/13.07/TLCL-13.07.pdf)
	* A more advanced book on [Data Science at the Command Line](http://datascienceatthecommandline.com)

# Intro to R

  * Review [intro.Rmd](r/intro.Rmd) for an introduction to R
  * Complete the [Code School](http://tryr.codeschool.com) and [DataCamp](http://datacamp.com/courses/free-introduction-to-r) tutorials (or Hadley's [Advanced R](http://adv-r.had.co.nz) if you're a pro)
  * References:
    * [Basic types](http://www.r-tutor.com/r-introduction/basic-data-types): (numeric, character, logical, factor)
    * Vectors, lists, dataframes: a [one page reference](http://www.statmethods.net/input/datatypes.html) and [more details](https://en.wikibooks.org/wiki/R_Programming/Data_types)
	* [Cyclismo's](http://www.cyclismo.org/tutorial/R/index.html) more extensive tutorial

# Counting

  * See [slides](http://www.slideshare.net/jakehofman/lecture-2-44332354)
  * Use the [download_movielens.sh](movielens/download_movielens.sh) script to download the [MovieLens data](http://grouplens.org/datasets/movielens/)
  * Review the [movielens.Rmd](movielens/movielens.Rmd) file we covered in class
<!--  * Complete the [DataCamp dplyr tutorial](https://www.datacamp.com/courses/dplyr-data-manipulation-r-tutorial) -->
  * Go through the [dplyr vignette](http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
  * Review these [examples for ggplot2](http://had.co.nz/stat480/r/graphics.html)
  * Run the [load_trips.R](citibike/load_trips.R) file with one month (201402) of data in your citibike folder to generate ``trips.RData``
  * Fill in details in [plot_trips.R](citibike/plot_trips.R)
  * References
    * Rstudio's [dplyr cheetsheat](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
	* [Intro to ggplot2](http://superbobry.github.io/slides/ggplot2/) slides
	* [Visualizing Data with ggplot2](http://varianceexplained.org/RData/lessons/lesson2/)

<!--
# cheatsheets and reference cards:
    http://cran.r-project.org/doc/contrib/Baggott-refcard-v2.pdf
    http://cran.r-project.org/doc/contrib/Torfs+Brauer-Short-R-Intro.pdf
    http://had.co.nz/stat480/r/
    http://www.rstudio.com/wp-content/uploads/2015/01/data-wrangling-cheatsheet.pdf
-->

# Guest lectures
  * [Fernando](http://research.microsoft.com/jump/164338) spoke about [regular expressions](regular-expressions.pdf)
  * See his last two slides for exercises, some of which involve the [20 newsgroups](http://qwone.com/~jason/20Newsgroups/) data
  * Use ``wget`` to download the data and ``tar zxvf <filename>`` to decompress it


<a name="improvement1">1</a>: In the future we'll change this to one file per student in a subdirectory to avoid merge conflicts
