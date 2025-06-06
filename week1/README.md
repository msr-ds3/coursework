This week covers:

  * An intro to Git and Github for sharing code
  * Command line tools
  * R and the Tidyverse

# Day 1

## Setup

Install tools: Visual Studio Code, Git for Windows, R


### Visual Studio Code
  * Install [Visual Studio Code](https://code.visualstudio.com) which will be your main text editor
  * Install the [GitHub Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot) and [GitHub Copilot Chat](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot-chat) extensions for Visual Studio Code

### Git for Windows
  * Install [Git for Windows](https://github.com/git-guides/install-git#install-git-on-windows) using the "Git for Windows installer"
  * Open Git Bash and check that you have git under bash by typing `git --version` in the terminal
<!--  * Configure git to deal with line endings in a cross-platform friendly way: `git config --global core.autocrlf true` -->
  * Do the same within Visual Studio Code

### R
  
  * Download and install R from a [CRAN mirror](https://cloud.r-project.org/)
<!--
  * Download and install [RStudio](https://www.rstudio.com/products/rstudio/download/)
  * Open RStudio and install the `tidyverse` package, which includes  `dplyr`, `ggplot2`, and more: `install.packages('tidyverse', dependencies = T)`
-->

### Filesystem setup
  * Verify that you can see the same set of files through Git Bash and your Windows Explorer by opening Git Bash and typing `ls` and `pwd` to see the contents of your current directory and its location
  * Navigate to Windows Explorer and see if you can find the same directory and check its contents


## Intro to Git(Hub)

### Make your first commit and pull request
  * [Sign up](https://github.com/join) for a free GitHub account
  * Then follow this guide to [fork your own copy](https://guides.github.com/activities/forking/) of the course repository
  * [Clone a copy of your forked repository](https://help.github.com/articles/cloning-a-repository/), which should be located at ``https://github.com/<yourusername>/coursework.git``, to your local machine
  * Once that's done, create a new file in the ``week1/students`` directory, ``<yourfirstname>.txt`` (e.g., ``jake.txt``)
  * Use ``git add`` to add the file to your local repository
  * If needed, set your [git username and email](https://docs.github.com/en/get-started/git-basics/setting-your-username-in-git#setting-your-git-username-for-every-repository-on-your-computer) with ``git config --global user.name "Your Name"`` and ``git config --global user.email "you@youremail.com"``
  * Set your [default git editor to VSCode](https://docs.github.com/en/get-started/git-basics/associating-text-editors-with-git#using-visual-studio-code-as-your-editor) using ``git config --global core.editor "code --wait"``
  * Use ``git commit`` and ``git push`` to commit and push your changes to your copy of the repository
  * Then issue a [pull request](https://guides.github.com/activities/forking/#making-a-pull-request) to send the changes back to the original course repository
  * Finally, [sync changes from the main repo](https://help.github.com/articles/syncing-a-fork/) to your fork with ``git pull upstream master`` (if your machine doesn't recognize `upstream`, do the following to create the `upstream` shortcut: `git remote add upstream https://github.com/msr-ds3/coursework.git`)

### Learn more (optional)
  * Codecademy's [interactive introduction to git](https://www.codecademy.com/learn/learn-git)
  * A full hour-long [introductory video](https://www.youtube.com/watch?v=U8GBXvdmHT4)
  * More resources from GitHub available [here](https://services.github.com/resources/) and [here](https://help.github.com/articles/good-resources-for-learning-git-and-github/)
  * And here's a handy [cheatsheet](https://services.github.com/on-demand/downloads/github-git-cheat-sheet/)

## Extra

Think about how to write a `musical_pairs.sh` script to determine your programming partner each day. We want the script to do the following:

* Produce a (pseudo)random pairing of 6 groups of 2 people who get to work together each day on pair programming assignments
* Any one of us should be able to run the script and get the same pairing on a given day (i.e., as long as our computers agree on the year/month/day)
* It's interesting to think about how we might avoid repeated pairs from one day to the next, but for a first cut (and maybe final cut) version of the script you can ignore that issue




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
  * Finish by submitting a pull request with your solutions so we can review them! (We won't merge the request, but it's a good way for the TA to provide feedback.)


# Day 3

## R in Visual Studio Code
  * Install the [R extension for VSCode](https://marketplace.visualstudio.com/items?itemName=REditorSupport.r)
  * Install the R language server by typing the following in an R terminal: `install.packages("languageserver")`
  * Install the `tidyverse` package, which includes  `dplyr`, `ggplot2`, and more, in an R terminal: `install.packages('tidyverse', dependencies = T)`

## Intro to R

  * See the [Data Wrangling in R](https://speakerdeck.com/jhofman/modeling-social-data-lecture-3-data-manipulation-in-r) slides
  * Review [intro_to_r.ipynb](intro_to_r.ipynb) for an introduction to R
  * See Chapter 3 of the 2nd edition of [R for Data Science](https://r4ds.hadley.nz) for the basics of dplyr

## R counting exercises
  * Use the [musical pairs script](students/musical_pairs.sh) to determine your programming partner each day
  * Fill in solutions to the counting exercises under each comment in [citibike.R](citibike.R)
  * Do the following exercises from Chapter 5 of the 1st edition of [R for Data Science](http://r4ds.had.co.nz):
    * Section [5.2.4](https://r4ds.had.co.nz/transform.html#exercises-8), exercises 1 and 3
    * Section [5.5.2](https://r4ds.had.co.nz/transform.html#exercises-11), exercise 2
    * Section [5.7.1](https://r4ds.had.co.nz/transform.html#exercises-13), exercise 3

## Learn more
  * See [this video tutorial](https://www.youtube.com/watch?v=9xXBDU2z_8Y) for tips for R in VSCode
  * Do the free portion of [Codecademy's introduction to R](https://www.codecademy.com/learn/learn-r), chapters 1, 2, and 3
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
  * Do the following exercises from Chapter 3 of the 1st edition of [R for Data Science](http://r4ds.had.co.nz) and do the following exercises:
    * Section [3.3.1](https://r4ds.had.co.nz/data-visualisation.html#exercises-1), exercises 1, 2, and 3
    * Section [3.5.1](https://r4ds.had.co.nz/data-visualisation.html#exercises-2), exercises 1 and 4
    * Section [3.6.1](https://r4ds.had.co.nz/data-visualisation.html#exercises-3), exercises 5 and 6
    * Section [3.8.1](https://r4ds.had.co.nz/data-visualisation.html#exercises-5), exercises 1 and 2
  * Citibike plots
    * Run the [load_trips.R](load_trips.R) file to generate `trips.RData`
    * Write code in [plot_trips.R](plot_trips.R) to create visualizations using `trips.RData`

## Learn more
  * Read Chapters 1, 9, and 10 of the 2nd edition of [R for Data Science](https://r4ds.hadley.nz) on visualization
  * Tutorials:
    * DataCamp's [Data Visualization with ggplot2 (part 1)](https://campus.datacamp.com/courses/data-visualization-with-ggplot2-1/) tutorial
  * References:
    * RStudio's [ggplot2 cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)
    * Sean Anderson's [ggplot2 slides](http://seananderson.ca/courses/12-ggplot2/ggplot2_slides_with_examples.pdf) ([code]((http://github.com/seananderson/datawranglR))) for more examples 
    * The [R Graphics Cookbook](http://www.cookbook-r.com/Graphs/)
    * The [official ggplot2 docs](http://docs.ggplot2.org/current/)
    * Videos on [Visualizing Data with ggplot2](http://varianceexplained.org/RData/lessons/lesson2/)

<!--

# Day 5

## Combining and reshaping data
  * Review [combine_and_reshape_in_r.ipynb](combine_and_reshape_in_r.ipynb) on joins with dplyr and reshaping with tidyr

## Plotting exercises
  * Finish up the Citibike plotting exercises in [plot_trips.R](plot_trips.R), including the plots that involve reshaping data

## Combining and reshaping exercises
  * Read chapters 5 and 19 of the 2nd edition of [R for Data Science](http://r4ds.had.co.nz) on reshaping and joins
  * Do the following exercises from the 1st edition of [R for Data Science](http://r4ds.had.co.nz):
    * Section [12.2.1](https://r4ds.had.co.nz/tidy-data.html#exercises-23), exercise 2
    * Section [12.3.3](https://r4ds.had.co.nz/tidy-data.html#exercises-24) exercises 1 and 3 

## Rmarkdown

  * Read Chapter 27 of the 1st edition of [R for Data Science](http://r4ds.had.co.nz) on Rmarkdown
  * Do the following exercises from the 1st edition of [R for Data Science](http://r4ds.had.co.nz):
    * Section [27.2.1](https://r4ds.had.co.nz/r-markdown.html#exercises-71), exercises 1 and 2 (try keyboard shortcuts: ctrl-shift-enter to run chunks, and ctrl-shift-k to knit the document)
    * Section [27.3.1](https://r4ds.had.co.nz/r-markdown.html#exercises-72) exercise 3, using [this file](diamond-sizes.Rmd)
    * Section [27.4.7](https://r4ds.had.co.nz/r-markdown.html#exercises-72), exercise 1

## Learn more

  * Do part 1 of Datacamp's [Cleaning Data in R](https://www.datacamp.com/courses/cleaning-data-in-r) tutorial
  * Additional references:
    * The tidyr [vignette on tidy data](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html)
    * The dplyr [vignette on two-table verbs](https://cran.r-project.org/web/packages/dplyr/vignettes/two-table.html) for joins
    * A [visual guide to joins](http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/)

-->