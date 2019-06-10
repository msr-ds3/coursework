# Day 1

## Trees, forests, boosting
  * See the [slides](tree-boost-forest.pdf) from Rob's lecture on Decision trees, boosting, and random forests
  * Also see these interactive tutorials on [decision trees](http://www.r2d3.us/visual-intro-to-machine-learning-part-1/) and [bias and variance](http://www.r2d3.us/visual-intro-to-machine-learning-part-2/)
  * Go through Lab 8.3.1 from [Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/index.html)
  * Then do the exercise at the bottom of this [notebook](https://rpubs.com/dvorakt/248300) on predicting who survived on the Titanic
    * The notebook uses the C50 library, which may be difficult to install, so feel free to use `tree` instead <!-- or rpart -->
  * References:
    * This [notebook](https://rpubs.com/ryankelly/dtrees) has more on regression and classification trees
	* A [cheatsheet](https://www.statmethods.net/advstats/cart.html) on the `rpart` implementation of CART and the `randomForest` package
	* [Documentation](http://www.milbo.org/rpart-plot/prp.pdf) for `rpart.plot` for better decision tree plots
<!--    * Try [rpart.plot](https://stackoverflow.com/a/48881163/76259) as an alternative to the native `plot()` function for trees -->

## Intro to Python
  * See [intro.py](intro.py) for in-class Python examples
  * Install the [Anaconda Python Distribution](https://docs.anaconda.com/anaconda/install/windows) on your machine
  * References:
    * [Codecademy's Python tutorial](https://www.codecademy.com/learn/python)
    * [Learnpython's advanced tutorials](http://www.learnpython.org) on generators and list comprehensions

# Day 2

## APIs, scraping, etc.
  * See the [example](nyt_api.py) we worked on in class for the [NYTimes API](https://developer.nytimes.com/), using the [requests](http://docs.python-requests.org/en/master/user/quickstart/) module for easy http functionality
  * References:
    * [Zapier's Introduction to APIs](https://zapier.com/learn/apis/) 
    * An [overview of JSON](http://code.tutsplus.com/tutorials/understanding-json--active-8817)
    * [Python's json module](http://pymotw.com/2/json/)
  <!-- * Complete [Codecademy's API tutorial](https://www.codecademy.com/courses/50e5bc94ce7f5e4945001d31/) -->

## NYT Article search API
  * Write Python code to download the 1000 most recent articles from the New York Times (NYT) API by section of the newspaper:
      * [Register](https://developer.nytimes.com/signup) for an API key for the [Article Search API](https://developer.nytimes.com/article_search_v2.json)
      * Use the [API console](https://developer.nytimes.com/article_search_v2.json#/Console/GET/articlesearch.json) to figure out how to query the API by section (hint: set the ``fq`` parameter to ``section_name:business`` to get articles from the Business section, for instance), sorted from newest to oldest articles (more [here](https://developer.nytimes.com/article_search_v2.json#/README))
      * Once you've figured out the query you want to run, translate this to working python code
      * Your code should take an API key, section name, and number of articles as command line arguments, and write out a tab-delimited file where each article is in a separate row, with ``section_name``, ``web_url``, ``pub_date``, and ``snippet`` as columns (hint: use the [codecs](https://pymotw.com/2/codecs/#working-with-files) package to deal with unicode issues if you run into them)
      * You'll have to loop over pages of API results until you have enough articles, and you'll want to remove any newlines from article snippets to keep each article on one line
      * Use your code to downloaded the 1000 most recent articles from the Business and World sections of the New york Times.

## Article classification

* After you have 1000 articles for each section, use the code in [classify_nyt_articles.R](classify_nyt_articles.R) to read the data into R and fit a logistic regression to prediction which section an article belongs to based on the words in its snippets
    * The provided code reads in each file and uses tools from the ``tm`` package---specifically ``VectorSource``, ``Corpus``, and ``DocumentTermMatrix``---to parse the article collection into a ``sparseMatrix``, where each row corresponds to one article and each column to one word, and a non-zero entry indicates that an article contains that word (note: this assumes that there's a column named ``snippet`` in your tsv files!)
    * Create an 80% train / 20% test split of the data and use ``cv.glmnet`` to find a best-fit logistic regression model to predict ``section_name`` from ``snippet``
    * Plot of the cross-validation curve from ``cv.glmnet``
    * Quote the accuracy and AUC on the test data and use the ``ROCR`` package to provide a plot of the ROC curve for the test data
    * Look at the most informative words for each section by examining the words with the top 10 largest and smallest weights from the fitted model

# Day 3

Fourth of July!

# Day 4
  * Finish up building the NYTimes article classifier

## Maps
  * See this [notebook](https://rpubs.com/jhofman/nycmaps) on maps, shapefiles, and spatial joins
  * Use the 2014 Citibike data to make a few plots:
    * Create a data frame that has the unique name, latitude, and longitude for each Citibike station that was present in the system in July 2014
    * Make a map showing the location of each Citibike station using ggmap
    * Do the same using leaflet, adding a popup that shows the name of the station when it's clicked on
    * Then do a spatial join to combine this data frame with the Pediacities NYC neighborhood shapefile data
    * Make a map showing the number of unique Citibike stations in each neighborhood
    * First do this using ggmap where the fill color encodes the number of stations
    * Then do the same using leaflet, adding a popup that shows the number of stations in a neighborhood when its shape is clicked on
	* Now create a new data frame that has the total number of trips that depart from each station at each hour of the day on July 14th
	* Do a spatial join to combine this data frame with the Pediacities NYC neighborhood shapefile data
	* Make a ggmap plot showing the number of trips that leave from each neighborhood at 9am, 1pm, 5pm, and 10pm, faceted by hour, where each facet contains a map where the fill color encodes the number of departing trips in each neighborhood
  * References:
    * [Leaflet for R](https://rstudio.github.io/leaflet/)
    * Datacamps [intro to leaflet in R](https://www.datacamp.com/courses/interactive-maps-with-leaflet-in-r)
    * [Previews](https://leaflet-extras.github.io/leaflet-providers/preview/) of different leaflet tile providers
    * The [sf package](http://strimas.com/r/tidy-sf/) for tidy spatial data

# Day 5

  * Complete yesterday's maps
  * Create a function that computes historical trip times between any two stations:
    * Take the trips dataframe and two station names as inputs
    * Return a 168-by-6 dataframe with summary statistics of trip times for each hour of the week (e.g., Monday 9am, Monday 10am, etc.), where the summary statistics include:
      * Average number of trips in that hour
      * Average and median trip times for that hour
      * Standard deviation in trip time for that hour
      * Upper and lower quartiles of trip time for that hour
    * Use this function on trips between Penn Station and Grand Central (you can use the most popular station at each location)
    * Make a plot of the results, where each facet is a day of the week, the x axis shows hour of the day, and the y axis shows average trip time, with transparent ribbons to show the standard deviation in trip time around the mean

## Shiny apps
  * Do RStudio's [written Shiny tutorial](https://shiny.rstudio.com/tutorial/) to get familiar with building shiny apps
  * References:
    * Datacamp's [Building Web Applications in R with Shiny](https://www.datacamp.com/courses/building-web-applications-in-r-with-shiny)
    * Datacamp's [Case studies](https://www.datacamp.com/courses/building-web-applications-in-r-with-shiny-case-studies) for Shiny apps in R
  
<!--

  * We had a guest lecture from [Hal Daume]() on natural language processing
    * Slides on [word sense disambiguation](http://www.cs.umd.edu/class/fall2016/cmsc723/slides/slides_05.pdf), [expectation maximization](http://www.cs.umd.edu/class/fall2016/cmsc723/slides/slides_06.pdf), and [word alignment](http://www.cs.umd.edu/class/fall2016/cmsc723/slides/slides_18.pdf)
    * The [Yarowsky algorithm](https://en.wikipedia.org/wiki/Yarowsky_algorithm) for word sense disambiguation 
    * [A statistical approach to machine translation](http://dl.acm.org/citation.cfm?id=92860)
    * See these interactive demos on [k-means](https://www.naftaliharris.com/blog/visualizing-k-means-clustering/) and [mixture models](http://davpinto.com/ml-simulations/#gaussian-mixture-density)
-->
