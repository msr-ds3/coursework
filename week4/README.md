
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
  * New reading assignment: [A Few Useful Things to Know About Machine Learning](https://homes.cs.washington.edu/~pedrod/papers/cacm12.pdf)
