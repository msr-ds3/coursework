library(tm)
library(Matrix)
library(glmnet)
library(ROCR)
library(ggplot2)

# read business and world articles into one data frame
business <- read.table('business.tsv')
world <- read.table('world.tsv')
articles <- rbind(business, world)

# create a Corpus from the article snippets
corpus <- Corpus(VectorSource(articles$snippet))

# create a DocumentTermMatrix from the snippet Corpus
# remove punctuation and numbers
dtm <- DocumentTermMatrix(corpus, list(weight=weightBin,
                                       stopwords=T,
                                       removePunctuation=T,
                                       removeNumbers=T))

# convert the DocumentTermMatrix to a sparseMatrix
X <- sparseMatrix(i=dtm$i, j=dtm$j, x=dtm$v, dims=c(dtm$nrow, dtm$ncol), dimnames=dtm$dimnames)

# create a train / test split

# cross-validate logistic regression with cv.glmnet, measuring auc

# evaluate performance for the best-fit model

# plot ROC curve and output accuracy and AUC

# show weights on words with top 10 weights for business

# show weights on words with top 10 weights for world
