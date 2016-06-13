This week covers:

  * An intro to Git and Github for sharing code
  * Command line tools
  * Exploratory data analysis with R using ``dplyr`` and ``ggplot2``

# Setup

Install git, R, and RStudio:

  * Install git: ``sudo apt-get install git``
  * In the terminal, type ``sudo gedit``
  * Create a new document containing a [CRAN mirror](http://cran.r-project.org/mirrors.html): ``deb http://cran.rstudio.com/bin/linux/ubuntu xenial/``
  * Save it as ``/etc/apt/sources.list.d/cran.list`` and close gedit
  * In the terminal, type ``gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9`` followed by ``gpg -a --export E084DAB9 | sudo apt-key add -`` to authorize a server with the latest R packages
  * Then ``sudo apt-get update`` to update the package list
  * Install R with ``sudo apt-get install r-base r-base-dev``
  * Download the [latest RStudio .deb](http://www.rstudio.com/products/rstudio/download/) package: ``wget https://download1.rstudio.org/rstudio-0.99.902-amd64.deb``
  * Install gdebi to help with package dependencies: ``sudo apt-get install gdebi-core``
  * Use gdebi to install the RStudio package: ``sudo gdebi -n rstudio-0.99.902-amd64.deb``
  * Start RStudio, either with ``rstudio`` from the command line or through the Ubuntu launcher
  * Follow Rstudio's [initial set up](http://r-pkgs.had.co.nz/git.html#git-init) to create an RSA key and upload the public portion to Github

# Intro to Git(Hub)

## Make your first commit and pull request
  * Complete this [free online git course](https://try.github.io) and 
  * [Sign up](https://github.com/join) for a free GitHub account
<!--  * Follow [these instructions](https://help.github.com/articles/generating-an-ssh-key/) to generate a new SSH key and add it to your GitHub account -->
  * Then follow this guide to [fork your own copy](https://guides.github.com/activities/forking/) of the course repository
  * [Clone a copy of your forked repository](https://help.github.com/articles/cloning-a-repository/), which should have a url of ``https://github.com/<yourusername>/coursework.git`` to your local machine
  * Once that's done, create a new file in the ``week1/students`` directory, ``<yourfirstname>.txt`` (e.g., ``jake.txt``)
  * Use ``git add`` to add the file to your local repository
  * Use ``git commit`` and ``git push`` to commit and push your changes to your copy of the repository
  * Then issue a [pull request](https://guides.github.com/activities/forking/#making-a-pull-request) to send the changes back to the original course repository
  * Finally, [configure a remote repository](https://help.github.com/articles/configuring-a-remote-for-a-fork/) called ``upstream`` to point here:
```
    git remote add upstream https://github.com:msr-ds3/coursework
```
  * This will allow you to [sync future changes](https://help.github.com/articles/syncing-a-fork/) to your fork with:
```
    git fetch upstream
	git merge upstream/master
```
  * Note: this is equivalent to ``git pull upstream master``

## Learn more
  * Watch this [introductory video](https://www.youtube.com/watch?v=U8GBXvdmHT4)
  * More resources are available [here](https://help.github.com/articles/good-resources-for-learning-git-and-github/)
  * And here's a handy [cheatsheet](https://training.github.com/kit/downloads/github-git-cheat-sheet.pdf)
