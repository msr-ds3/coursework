train = sample(1:10000, 0.7*10000, replace = F)
test = (1:10000)[-train]

y = as.factor(data$Label)

library(e1071)
nb = naiveBayes(x = as.matrix(dtm[train, ]), y = y[train], laplace = T)
pred.nb = predict(nb, newdata = as.matrix(dtm[test, ]))
Evaluate(pred.nb, y[test])



myDictionary = read.csv("c://temp/vocab.csv")
myDictionary = myDictionary$Vocab
# OR read the vocab.csv file


# score example
t1 = "what terrific thing"
t1.dtm = GetDTM(t1, dictionary = myDictionary, tokenizer = tokenizer)
dim(t1.dtm)
predict(nb, newdata = as.matrix(t1.dtm))



t2 = "bad service"
t2.dtm = GetDTM(t2, dictionary = Terms(dtm), tokenizer = tokenizer)
dim(t2.dtm)
predict(nb, newdata = as.matrix(t2.dtm))
          
          
         