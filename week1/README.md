This week covers:

  * An intro to Git and Github for sharing code
  * Command line tools
  * R and the Tidyverse

# Day 1

## Setup

Install tools: [Ubuntu on Windows](https://msdn.microsoft.com/en-us/commandline/wsl/about), GitHub for Windows, R, and RStudio

### Ubuntu on Windows
  * Open [http://aka.ms/wslstore](http://aka.ms/wslstore) and select Ubuntu on Windows
  * If this seems like it's hanging, hit enter
  * Create a username and password
  * Updates all packages with `sudo apt-get update` and `sudo apt-get upgrade`

### Git / GitHub for Windows
  * Check that you have git under bash by typing `git --version` in the terminal
  * Install [GitHub for Windows](https://desktop.github.com)
<!--  * Configure git to deal with line endings in a cross-platform friendly way: `git config --global core.autocrlf true` -->

### R and RStudio
  
  * Download and install R from a [CRAN mirror](https://cloud.r-project.org/)
  * Download and install [RStudio](https://www.rstudio.com/products/rstudio/download/)
  * Open RStudio and install the `tidyverse` package, which includes  `dplyr`, `ggplot2`, and more: `install.packages('tidyverse', dependencies = T)`

### Text editor

  * You'll need a plain text editing program
  * If you are familiar with emacs or vim, you can install them in Ubuntu with `sudo apt-get install emacs` or `sudo apt-get install vim`
  * Otherwise consider [Visual Studio Code](https://code.visualstudio.com), [Atom](https://atom.io), or [Sublime](http://www.sublimetext.com)
  * Check your editor's settings for [unix-friendly line endings](https://askubuntu.com/a/1036364)

<!-- 
* sudo apt-get install dos2unix unzip
* dos2unix for citibike script
-->

### Filesystem setup
  * Files that you create in Ubuntu on Windows get stored in a somewhat hidden location within the Windows filesystem
  * To make it easier to find files you work on in Ubuntu, do the following:
    * Open a bash shell
    * Go to your home directory: `cd ~`
    * Create a symbolic link to your Documents folder: `ln -s /mnt/c/Users/<your name>/Documents ~/Documents`
    * Change to this directory: `cd ~/Documents`
    * Do all of your work, including the following section, from within this folder, which you'll be able to see under "Documents" in the Windows Explorer


## Intro to Git(Hub)

### Make your first commit and pull request
  * [Sign up](https://github.com/join) for a free GitHub account
  * Then follow this guide to [fork your own copy](https://guides.github.com/activities/forking/) of the course repository
  * [Clone a copy of your forked repository](https://help.github.com/articles/cloning-a-repository/), which should be located at ``https://github.com/<yourusername>/coursework.git``, to your local machine
  * Once that's done, create a new file in the ``week1/students`` directory, ``<yourfirstname>.txt`` (e.g., ``jake.txt``)
  * Use ``git add`` to add the file to your local repository
  * Use ``git commit`` and ``git push`` to commit and push your changes to your copy of the repository
  * Then issue a [pull request](https://guides.github.com/activities/forking/#making-a-pull-request) to send the changes back to the original course repository
  * Finally, [sync changes from the main repo](https://help.github.com/articles/syncing-a-fork/) to your fork with ``git pull upstream master``

### Learn more (optional)
  * Codecademy's [interactive introduction to git](https://www.codecademy.com/learn/learn-git)
<!--  * Datacamp's [interactive online git course](https://www.datacamp.com/courses/introduction-to-git-for-data-science) -->
  * A full hour-long [introductory video](https://www.youtube.com/watch?v=U8GBXvdmHT4)
  * More resources from GitHub available [here](https://services.github.com/resources/) and [here](https://help.github.com/articles/good-resources-for-learning-git-and-github/)
  * And here's a handy [cheatsheet](https://services.github.com/on-demand/downloads/github-git-cheat-sheet/)

# Day 2
  
## Intro to the Command Line
  * See this [intro to the command line](intro_command_line.ipynb) notebook 
  * Read through [Lifehacker's command line primer](http://lifehacker.com/5633909/who-needs-a-mouse-learn-to-use-the-command-line-for-almost-anything)
  * See [Linux Journey's shell lesson](https://linuxjourney.com/lesson/the-shell)

### Learn more (optional)
  * See this [crash course](https://learnpythonthehardway.org/book/appendixa.html) for more details on commonly used commands
  * Check out Software Carpentry's [guide to the Unix shell](http://swcarpentry.github.io/shell-novice/)
  * Review this wikibook on [data analysis on the command line](http://en.wikibooks.org/wiki/Ad_Hoc_Data_Analysis_From_The_Unix_Command_Line), covering ``cut``, ``grep``, ``wc``, ``uniq``, ``sort``, etc
  * Learn [awk in 20 minutes](http://ferd.ca/awk-in-20-minutes.html)
  * Check out some more advanced tools for [Data Science at the Command Line](http://datascienceatthecommandline.com)
  * Do Codecademy's interactive [command line tutorial](https://www.codecademy.com/learn/learn-the-command-line) (the free portion)
  * See these [Introduction to Counting](https://speakerdeck.com/jhofman/modeling-social-data-lecture-2-introduction-to-counting) slides

## Command line exercises
  * Pull changes from the msr-ds3/coursework repo: `git pull upstream master`
  * Use the [download_trips.sh](download_trips.sh) file to download Citibike trip data by running `bash download_trips.sh` or `./download_trips.sh`
  * Fill in solutions under each comment in [citibike.sh](citibike.sh) using the `201402-citibike-tripdata.csv` file


## Save your work
  * Make sure to save your work and push it to GitHub. Do this in three steps:
  	1. `git add` and `git commit` and new files to your local repository. (Omit large data files.)
  	2. `git pull upstream master` to grab changes from this repository, and resolve any merge conflicts, commiting the final results.
  	3. `git push origin master` to push things back up to your GitHub fork of the course repository.


## Extra
  * Think about how to write a `musical_pairs.sh` script to determine your programming partner each day
 
<!--

## Counting

  * Take a look at [The Anatomy of the Long Tail](https://5harad.com/papers/long_tail.pdf) and think about how to generate Figures 1 and 2

-->


# Day 3

## Intro to R

  * See the [Data Wrangling in R](https://speakerdeck.com/jhofman/modeling-social-data-lecture-3-data-manipulation-in-r) slides
  * Review [intro_to_r.ipynb](intro_to_r.ipynb) for an introduction to R
  * Do the free portion of [Codecademy's introduction to R](https://www.codecademy.com/learn/learn-r), chapters 1, 2, and 3
  * See chapters 1, 2, and 4 of [R for Data Science](http://r4ds.had.co.nz) for background on using R and Rstudio (chapter numbers correspond to the online edition)
<!--   * Read chapters 2 and 3 of [R for Data Science](http://r4ds.had.co.nz) -->

## R counting exercises
  * Use the [musical pairs script](students/musical_pairs.sh) to determine your programming partner each day
  * Fill in solutions to the counting exercises under each comment in [citibike.R](citibike.R)
  * Read chapter 5 of [R for Data Science](http://r4ds.had.co.nz) and do the following exercises:
    * Section [5.2.4](https://r4ds.had.co.nz/transform.html#exercises-8), exercises 1 and 3
    * Section [5.5.2](https://r4ds.had.co.nz/transform.html#exercises-11), exercise 2
    * Section [5.7.1](https://r4ds.had.co.nz/transform.html#exercises-13), exercise 3

## Learn more
  * References:
    * [Basic types](http://www.r-tutor.com/r-introduction/basic-data-types): (numeric, character, logical, factor)
    * Vectors, lists, dataframes: a [one page reference](http://www.statmethods.net/input/datatypes.html) and [more details](https://en.wikibooks.org/wiki/R_Programming/Data_types)
	* [Cyclismo's](http://www.cyclismo.org/tutorial/R/index.html) more extensive tutorial
	* Rstudio's [data wrangling cheatsheet](http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)
	* The [tidyverse style guide](https://style.tidyverse.org)
	* Hadley Wickham's [style guide](http://adv-r.had.co.nz/Style.html)
	* The [dplyr vignette](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)
	* Sean Anderson's [dplyr and pipes examples](http://seananderson.ca/2014/09/13/dplyr-intro.html) ([code](https://github.com/seananderson/dplyr-intro-2014) on github)

  * Tutorials:
  	* [DataCamp's introduction to R](http://datacamp.com/courses/free-introduction-to-r) tutorials (or Hadley's [Advanced R](http://adv-r.had.co.nz) if you're a pro)
  	* [DataCamp's Data Manipulation in R](https://campus.datacamp.com/courses/dplyr-data-manipulation-r-tutorial) tutorial
  	* [Datacamp's Introduction to the Tidyverse](https://www.datacamp.com/courses/introduction-to-the-tidyverse) tutorial


# Day 4

## Plotting

  * See the [Data visualization](https://speakerdeck.com/jhofman/modeling-social-data-lecture-4-data-visualization) slides
  * Review [visualization_with_ggplot2.ipynb](visualization_with_ggplot2.ipynb) for an introduction to data visualization with ggplot2

## Plotting exercises   
  * Read chapter 3 of the online edition of [R for Data Science](http://r4ds.had.co.nz) and do the following exercises:
    * Section [3.3.1](https://r4ds.had.co.nz/data-visualisation.html#exercises-1), exercises 1, 2, and 3
    * Section [3.5.1](https://r4ds.had.co.nz/data-visualisation.html#exercises-2), exercises 1 and 4
    * Section [3.6.1](https://r4ds.had.co.nz/data-visualisation.html#exercises-3), exercises 5 and 6
    * Section [3.8.1](https://r4ds.had.co.nz/data-visualisation.html#exercises-5), exercises 1 and 2
  * Citibike plots
    * Modify and use the `download_trips.sh` script to grab all months of trip data from 2014
    * Run the [load_trips.R](load_trips.R) file to generate `trips.RData`
    * Write code in [plot_trips.R](plot_trips.R) to create visualizations using `trips.RData`

## Learn more
  * Tutorials:
    * DataCamp's [Data Visualization with ggplot2 (part 1)](https://campus.datacamp.com/courses/data-visualization-with-ggplot2-1/) tutorial
  * References:
    * RStudio's [ggplot2 cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)
    * Sean Anderson's [ggplot2 slides](http://seananderson.ca/courses/12-ggplot2/ggplot2_slides_with_examples.pdf) ([code]((http://github.com/seananderson/datawranglR))) for more examples 
    * The [R Graphics Cookbook](http://www.cookbook-r.com/Graphs/)
    * The [official ggplot2 docs](http://docs.ggplot2.org/current/)
    * Videos on [Visualizing Data with ggplot2](http://varianceexplained.org/RData/lessons/lesson2/)
