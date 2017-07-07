
library(tm)
library(Matrix)
library(glmnet)
library(ROCR)
library(ggplot2)

# read business and world articles into one data frame

# create a Corpus from the article snippets

# create a DocumentTermMatrix from the snippet Corpus
# remove punctuation and numbers

# convert the DocumentTermMatrix to a sparseMatrix, required by cv.glmnet
# helper function
dtm_to_sparse <- function(dtm) {
 sparseMatrix(i=dtm$i, j=dtm$j, x=dtm$v, dims=c(dtm$nrow, dtm$ncol), dimnames=dtm$dimnames)
}

# create a train / test split

# cross-validate logistic regression with cv.glmnet, measuring auc

# evaluate performance for the best-fit model

# plot ROC curve and output accuracy and AUC

# extract coefficients for words with non-zero weight
# helper function
get_informative_words <- function(crossval) {
  coefs <- coef(crossval, s="lambda.min")
  coefs <- as.data.frame(as.matrix(coefs))
  names(coefs) <- "weight"
  coefs$word <- row.names(coefs)
  row.names(coefs) <- NULL
  subset(coefs, weight != 0)
}

# show weights on words with top 10 weights for business

# show weights on words with top 10 weights for world
