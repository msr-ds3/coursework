
## Day 1

  * [Slides](https://www.slideshare.net/jakehofman/modeling-social-data-lecture-6-classification-with-naive-bayes) and [code](classification.ipynb) on classification
  * The [(super) naive Bayes](enron_naive_bayes.sh) shell script from lecture
  * Complete this [naive Bayes lab](https://rpubs.com/dvorakt/144238)
  * And this [logistic regression lab](https://rpubs.com/dvorakt/151334)

## Day 2
  * [Notes](https://github.com/jhofman/msd2017-notes/blob/master/lecture_9/lecture_9.pdf) on naive Bayes, logistic regression, and classifier evaluation
  * A video explaining [ROC curves](http://www.dataschool.io/roc-curves-and-auc-explained/) with an accompanying [interactive demo](http://www.navan.name/roc/)
  * We had a guest lecture from [Hal Daume]() on natural language processing
    * Slides on [word sense disambiguation](http://www.cs.umd.edu/class/fall2016/cmsc723/slides/slides_05.pdf), [expectation maximization](http://www.cs.umd.edu/class/fall2016/cmsc723/slides/slides_06.pdf), and [word alignment](http://www.cs.umd.edu/class/fall2016/cmsc723/slides/slides_18.pdf)
    * The [Yarowsky algorithm](https://en.wikipedia.org/wiki/Yarowsky_algorithm) for word sense disambiguation 
    * [A statistical approach to machine translation](http://dl.acm.org/citation.cfm?id=92860)
    * See these interactive demos on [k-means](https://www.naftaliharris.com/blog/visualizing-k-means-clustering/) and [mixture models](http://davpinto.com/ml-simulations/#gaussian-mixture-density)

## Day 3
  * See [intro.py](intro.py) for in-class Python examples
  * Do the [Codecademy Python tutorial](https://www.codecademy.com/learn/python)
  * See [Learnpython's advanced tutorials](http://www.learnpython.org) on generators and list comprehensions

## Day 4
  * See the [example](nyt_api.py) we worked on in class for the [NYTimes API](https://developer.nytimes.com/), using the [requests](http://docs.python-requests.org/en/master/user/quickstart/) module for easy http functionality
  * Read the first three sections of [Zapier's Introduction to APIs](https://zapier.com/learn/apis/)
  * Read this [overview of JSON](http://code.tutsplus.com/tutorials/understanding-json--active-8817) and review the first two sections of this overview of [Python's json module](http://pymotw.com/2/json/)
  * Complete [Codecademy's API tutorial](https://www.codecademy.com/courses/50e5bc94ce7f5e4945001d31/)
  * Write Python code to download the 1000 most recent articles from the New
  York Times (NYT) API by section of the newspaper:
      * [Register](https://developer.nytimes.com/signup) for an API key for the [Article Search API](https://developer.nytimes.com/article_search_v2.json)
      * Use the [API console](https://developer.nytimes.com/article_search_v2.json#/Console/GET/articlesearch.json) to figure out how to query the API by section (hint: set the ``fq`` parameter to ``section_name:business`` to get articles from the Business section, for instance), sorted from newest to oldest articles
      * Once you've figured out the query you want to run, translate this to working python code
      * Your code should take an API key, section name, and number of articles as command line arguments, and write out a tab-delimited file where each article is in a separate row, with ``section_name``, ``web_url``, ``pub_date``, and ``snippet`` as columns
      * You'll have to loop over pages of API results until you have enough articles, and you'll want to remove any newlines from article snippets to keep each article on one line
      * Finally, run your code to get articles from the Business and World
      sections of the NYT.
