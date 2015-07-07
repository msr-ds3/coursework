library(glmnet)
library(Matrix)

y = read.table('labels.csv', sep=',', header=T)
y = as.factor(y$Label)

dtm = read.table(gzfile('ta_dtm_sparse.csv.gz'), sep=',', header=T)
x = sparseMatrix(i = dtm$i, j= dtm$j, x = dtm$v)

