This week covers:

  * An intro to Git and Github for sharing code
  * Command line tools
  * Exploratory data analysis with R

# Day 1

## Setup

Install tools: [Ubuntu on Windows](https://msdn.microsoft.com/en-us/commandline/wsl/about), GitHub for Windows, R, and RStudio

### Ubuntu on Windows
  * Type `bash` in the Start Menu, hit enter, and then `y` to install Ubuntu on Windows
  * If this seems like it's hanging, hit enter
  * Create a username and password
  * Updates all packages with `sudo apt-get update` and `sudo apt-get upgrade`

### Git / GitHub for Windows
  * Check that you have git under bash by typing `git --version` in the terminal
  * Install [GitHub for Windows](https://desktop.github.com)

### R and RStudio
  
  * Download and install R from a [CRAN mirror](https://cloud.r-project.org/)
  * Download and install [RStudio](https://www.rstudio.com/products/rstudio/download/)
  * Open RStudio and install the `tidyverse` package, which includes  `dplyr`, `ggplot2`, and more: `install.packages('tidyverse', dependencies = T)`

### Text editor

  * You'll need a plain text editing program
  * [Atom](https://atom.io), [Sublime](http://www.sublimetext.com), and [Visual Studio Code](https://code.visualstudio.com) are all good options

## Intro to Git(Hub)

### Make your first commit and pull request
  * Complete this [free online git course](https://try.github.io) 
  * [Sign up](https://github.com/join) for a free GitHub account
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
  * A full hour-long [introductory video](https://www.youtube.com/watch?v=U8GBXvdmHT4)
  * More resources from GitHub available [here](https://services.github.com/resources/) and [here](https://help.github.com/articles/good-resources-for-learning-git-and-github/)
  * And here's a handy [cheatsheet](https://services.github.com/on-demand/downloads/github-git-cheat-sheet/)
  
## Intro to the Command Line
  * Read through [Lifehacker's command line primer](http://lifehacker.com/5633909/who-needs-a-mouse-learn-to-use-the-command-line-for-almost-anything)
  * Do Codecademy's interactive [command line tutorial](https://www.codecademy.com/courses/learn-the-command-line/lessons/navigation/exercises/your-first-command?action=lesson_resume)

### Learn more (optional)
  * See this [crash course](https://learnpythonthehardway.org/book/appendixa.html) for more details on commonly used commands
  * Check out Software Carpentry's [guide to the Unix shell](http://swcarpentry.github.io/shell-novice/)
  * Review this wikibook on [data analysis on the command line](http://en.wikibooks.org/wiki/Ad_Hoc_Data_Analysis_From_The_Unix_Command_Line), covering ``cut``, ``grep``, ``wc``, ``uniq``, ``sort``, etc
  * Learn [awk in 20 minutes](http://ferd.ca/awk-in-20-minutes.html)
  * Check out some more advanced tools for [Data Science at the Command Line](http://datascienceatthecommandline.com)


# Day 2

## Command line exercises

  * Review [intro_command_line.ipynb](intro_command_line.ipynb) for an introduction to the command line
  * Download one month of the [Citibike data](https://www.citibikenyc.com/system-data): ``wget https://s3.amazonaws.com/tripdata/201402-citibike-tripdata.zip``
  * Decompress it: ``unzip 201402-citibike-tripdata.zip``
  * Rename the resulting file to get rid of ugly spaces: ``mv 2014-02*.csv 201402-citibike-tripdata.csv``
  * See the [download_trips.sh](download_trips.sh) file which automates this, and can be run using `bash download_trips.sh` or `./download_trips.sh`
  * Fill in solutions of your own under each comment in [citibike.sh](citibike.sh)

## Intro to R

  * Start the [Code School](http://tryr.codeschool.com) and [DataCamp](http://datacamp.com/courses/free-introduction-to-r) tutorials (or Hadley's [Advanced R](http://adv-r.had.co.nz) if you're a pro)
  * References:
    * [Basic types](http://www.r-tutor.com/r-introduction/basic-data-types): (numeric, character, logical, factor)
    * Vectors, lists, dataframes: a [one page reference](http://www.statmethods.net/input/datatypes.html) and [more details](https://en.wikibooks.org/wiki/R_Programming/Data_types)
	* [Cyclismo's](http://www.cyclismo.org/tutorial/R/index.html) more extensive tutorial
    * Hadley Wickham's [style guide](http://adv-r.had.co.nz/Style.html)

# Day 3

## Counting

  * See these [Introduction to Counting](https://www.slideshare.net/jakehofman/modeling-social-data-lecture-2-introduction-to-counting) and [Data Wrangling in R](https://www.slideshare.net/jakehofman/modeling-social-data-lecture-3-data-manipulation-in-r?ref=http://modelingsocialdata.org/lectures/2017/02/03/lecture-3-computational-complexity.html) slides
  * Review [intro_to_r.ipynb](intro_to_r.ipynb) for an introduction to R
  * Do the free portion of DataCamp's [Data Manipulation in R](https://campus.datacamp.com/courses/dplyr-data-manipulation-r-tutorial) tutorial
  * Go through chapters [1](http://r4ds.had.co.nz/introduction.html), [2](http://r4ds.had.co.nz/explore-intro.html), and [5](http://r4ds.had.co.nz/transform.html) of [R for Data Science](http://r4ds.had.co.nz)
  * Fill in solutions to the counting exercises under each comment in [citibike.R](citibike.R)
  * Take a look at [The Anatomy of the Long Tail](https://5harad.com/papers/long_tail.pdf) and think about how to generate figures 1 and 2

  * Additional references
	* The [dplyr vignette](http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)
	* Sean Anderson's [dplyr and pipes examples](http://seananderson.ca/2014/09/13/dplyr-intro.html) ([code](https://github.com/seananderson/dplyr-intro-2014) on github)
	* Rstudio's [data wrangling cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)


<!--
  * Plotting
    * Read the [data visualization](http://r4ds.had.co.nz/data-visualisation.html) of ["R for Data Science"](http://r4ds.had.co.nz) chapter and go over the included exercises
    * Review Sean Anderson's [ggplot2 slides](http://seananderson.ca/courses/12-ggplot2/ggplot2_slides_with_examples.pdf) ([code]((http://github.com/seananderson/datawranglR)) and reproduce the ``diamonds`` plots in these slides.
    * Bookmark Rstudio's [data visualization cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/12/ggplot2-cheatsheet-2.0.pdf)
    * Optionally do the free portion of DataCamp's [Data Visualization with ggplot2](https://campus.datacamp.com/courses/data-visualization-with-ggplot2-1/) tutorial    

  * Additional references
    * The [R Graphics Cookbook](http://www.cookbook-r.com/Graphs/)
    * [Intro to ggplot2](http://superbobry.github.io/slides/ggplot2/) slides, with somewhat tricky navigation
    * [Visualizing Data with ggplot2](http://varianceexplained.org/RData/lessons/lesson2/)
    * The [official ggplot2 docs](http://docs.ggplot2.org/current/)
-->




