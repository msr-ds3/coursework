
## Day 1
  * [Said Bleik](https://www.linkedin.com/pub/said-bleik/56/551/34b) is guest lecturing on machine learning and [AzureML](https://studio.azureml.net) this week
  * Sign up for a [free trial Azure account](https://azure.microsoft.com/en-us/pricing/free-trial/)
  * Use [last week's digit data](../week3/perceptron) to create logistic regression and perceptron classifiers in AzureML
  * Reproduce your Citibike regression exercise in AzureML using the ``trips_per_day.csv`` data, comparing linear regression with [other available regression methods](http://gallery.azureml.net/Experiment/f35e1ba8a0a34ccd9ce2dc0758de34cb), including non-linear methods
  * Review several examples from the AzureML gallery:
    * [Letter classification](http://gallery.azureml.net/Experiment/bbe8503e4740473a9836aae6a914e3c0)
	* [Demand forecasting](http://gallery.azureml.net/Experiment/d92ab449519a46be9b8f31776c1e638b)
	* [News categorization](http://gallery.azureml.net/Experiment/fcb1bf27ee26443fb19bd07852a620c4)
	* [Clustering for color quantization](http://gallery.azureml.net/Experiment/92bcba7c206649c2ab2152df916dd666)
  * References:
    * See [these slides](http://www.slideshare.net/jakehofman/datadriven-modeling-lecture-10) for an overview of k-means and color quantization
	* See [here](http://modelingsocialdata.org/lectures/2015/03/27/clustering.html) for more clustering notes

## Day 2
  * Read this [overview of JSON](http://code.tutsplus.com/tutorials/understanding-json--active-8817) and review the first two sections of this overview of [Python's json module](http://pymotw.com/2/json/)
  * Read the first three sections of [Zapier's Introduction to APIs](https://zapier.com/learn/apis/)
  * Complete [CodeAcademy's Sunlight API tutorial](http://www.codecademy.com/en/tracks/sunlight_python)
  * Work through this [comparison of naive Bayes and logistic regression](http://rpubs.com/jhofman/nb_vs_lr) in R
  * Download the [TripAdvisor](tripadvisor/) reviews Said worked with in class using [download_reviews.sh](tripadvisor/download_reviews.sh)
  * Run through the [preprocess.r](tripadvisor/preprocess.r) script to generate a document-term matrix and labels, commenting the file to explain what it does
  * Use glmnet to fit a model to the [sparse matrix](http://amunategui.github.io/sparse-matrix-glmnet/) ``x`` of words in each document to predict the sentiment in the ``y`` vector ("P" for positive, "N" for negative) in the [classification.r](tripadvisor/classification.r) script
  * Compare this to naive Bayes, for which you'll need to use the dense matrix representation
  * [Publish a web service](https://azure.microsoft.com/en-us/documentation/articles/machine-learning-walkthrough-5-publish-web-service/) for one of the AzureML experiments you created yesterday
  * Adapt the [sample python code](https://azure.microsoft.com/en-us/documentation/articles/machine-learning-connect-to-azure-machine-learning-web-service/#python_sample) to connect to your web service, pass in data, and get back a prediction
  * References:
    * Some notes on [naive Bayes for text classification](http://modelingsocialdata.org/lectures/2015/02/27/lecture-6-classification-naive-bayes.html) including a simple [script one-word spam classifier](https://github.com/jhofman/msd2015/blob/master/lectures/lecture_6/enron_naive_bayes.sh)
    * [An introduction to ROC analysis](https://ccrma.stanford.edu/workshops/mir2009/references/ROCintro.pdf) and [interactive demo](http://www.navan.name/roc/) to understand ROC curves, precision, recall, etc.

## Day 3
  * See Said's [name origin classifier](nameorigin/)
  * Work through the [main.R](nameorigin/R/main.R) script to generate training data for name classification, commenting the file to explain what it does
  * Use this to train a name classifier in AzureML and create a web service using the trained model
  * New reading assignment, to be discussed next week: [A Few Useful Things to Know About Machine Learning](https://homes.cs.washington.edu/~pedrod/papers/cacm12.pdf)

## Day 4
  * Game theory, guest lecture by Vasilis (see [notes from class](Game_theory_notes.pdf))
  * Dominant strategies, Nash equilibrium, Mixed Nash equilibrium, zero-sum games, fictitious play, no-regret learning
  * Assignment: implement fictitious play for two player normal form games in python, using [numpy](http://www.numpy.org/)
  * Solution to assigmnent: [here](fictitious.py)
  * Resources:
	* Chapter 1 of Algorithmic Game Theory book: [AGT book](http://www.cambridge.org/journals/nisan/downloads/Nisan_Non-printable.pdf)
	* Lecture notes on zero-sum games and fictitious play by Daskalakis: [Lecture 1](http://people.csail.mit.edu/costis/6896sp10/lec2.pdf), [Lecture 2](http://people.csail.mit.edu/costis/6896sp10/lec3.pdf), [Lecture 3](http://people.csail.mit.edu/costis/6896sp10/lec3.pdf)
	* Relevant courses in CS schools: [Cornell](http://www.cs.cornell.edu/Courses/CS6840/2014sp/), [Stanford](http://theory.stanford.edu/~tim/f13/f13.html), [MIT](https://stellar.mit.edu/S/course/6/sp15/6.891/materials.html)

## Day 5
  * [David Abel](http://cs.brown.edu/~dabel/) is guest lecturing on computer vision today.
  * First we'll talk about [Change Blindness](https://en.wikipedia.org/wiki/Change_blindness) and talk a bit about [mammal vision](https://www.youtube.com/watch?v=KE952yueVLA)
  * If you'd like, take a look at this reading on [features](http://opencv-python-tutroals.readthedocs.org/en/latest/py_tutorials/py_feature2d/py_features_meaning/py_features_meaning.html#features-meaning)
  * We'll talk histograms and corner detection and go through this [Histogram Demo](http://opencv-python-tutroals.readthedocs.org/en/latest/py_tutorials/py_imgproc/py_histograms/py_histogram_begins/py_histogram_begins.html) as well as this [Corner Demo](http://opencv-python-tutroals.readthedocs.org/en/latest/py_tutorials/py_feature2d/py_features_harris/py_features_harris.html#harris-corners) (feel free to ignore the math, we won't go into detail)
  * Rest of class: Object recognition and Data-driven techniques in computer vision!
  * Useful Resources:
    * Excellent Computer Vision textbook freely available online [here](http://szeliski.org/Book/)
    * Python's SimpleCV library has some nice tutorials to get you started in python, available [here](http://tutorial.simplecv.org/en/latest/)
    * James Hays' course on Computer Vision, assignments and slides available [here](http://cs.brown.edu/courses/cs143/)
    * Alexei Efros' course on Learning-Based Methods in vision with slides and recent scientific papers available [here](https://docs.google.com/document/pub?id=1jGBn7zPDEaU33fJwi3YI_usWS-U6gpSSJotV_2gDrL0)

  * [Sébastien Lahaie](http://slahaie.net/) is lecturing on network flows today in the afternoon.
  * Resources:
    * Lecture slides are available [here](network_flows/network-flows.pptx).
    * We'll use the [NetworkX](https://networkx.github.io/) python package to demo the algorithms.
    * The demo is available [here](network_flows/network-flows.ipynb) as an [IPython notebook](http://ipython.org/notebook.html).
    * The python script is [here](network_flows/network-flows.py).
    * Suggested steps to install and run an ipython notebook:
      1. sudo apt-get install setuptools
      2. pip install networkx
      3. pip install "ipython[notebook]"
      4. ipython notebook network-flows.ipynb
    
