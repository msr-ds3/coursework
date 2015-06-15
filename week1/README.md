This week covers:

  * An intro to Git and Github for sharing code
  * Command line tools
  * Exploratory data analysis with R

# Setup

Install git, R, and RStudio:

  * Install git: ``sudo apt-get install git``
  * In the terminal, type ``sudo gedit``
  * Create a new document containing this: ``deb http://lib.stat.cmu.edu/R/CRAN/bin/linux/ubuntu trusty/``
  * Save it as ``/etc/apt/sources.list.d/cran.list`` and close gedit
  * In the terminal, type ``sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9`` to authorize a server with the latest R packages
  * Then ``sudo apt-get update`` to update the package list
  * Install R with  ``sudo apt-get install r-base``
  * Download the RStudio .deb package: ``wget http://download1.rstudio.org/rstudio-0.99.442-amd64.deb``
  * Install a dependency for RStudio: ``sudo apt-get install libjpeg62``
  * Install the package: ``sudo dpkg -i rstudio-0.99.442-amd64.deb``
  * Start RStudio, either with ``rstudio`` from the command line or through the Ubuntu launcher

# Intro to Git(Hub)

If you don't already have one, [sign up](https://github.com/join) for a free GitHub account. Then [fork your own copy](https://guides.github.com/activities/forking/) of the course repository. See these [screenshots](http://www.princeton.edu/~mjs3/soc504_s2015/submitting_homework.shtml) for details.

Once that's done, edit the ``week1/students.txt`` file and add your first name. Commit and push your changes to your copy of the repository through RStudio. Then issue a [pull request](https://guides.github.com/activities/forking/#making-a-pull-request) to send the changes back to the original repository.

See this [free online git course](https://try.github.io) and [introductory video](https://www.youtube.com/watch?v=U8GBXvdmHT4) as well.
More resources [here](https://help.github.com/articles/good-resources-for-learning-git-and-github/).

# Command line

  * Download one month of the Citibike data: ``wget https://s3.amazonaws.com/tripdata/201402-citibike-tripdata.zip``
  * Unzip it: ``unzip 201402-citibike-tripdata.zip``
  * Rename the file to get rid of spaces: ``mv 2014-02*.csv 201402-citibike-tripdata.csv``
  * Go through the ``explore_trips.sh`` file
  * Fill in solutions for ``exercises.sh``
