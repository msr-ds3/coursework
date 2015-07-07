library(glmnet)
library(Matrix)
library(e1071)

y = read.table('labels.csv', sep=',', header=T)
y = as.factor(y$Label)

dtm = read.table(gzfile('ta_dtm_sparse.csv.gz'), sep=',', header=T)
x = sparseMatrix(i = dtm$i, j= dtm$j, x = dtm$v)

# use the sparse x with glmnet

# convert this to a dense matrix with as.matrix(x) for naiveBayes
