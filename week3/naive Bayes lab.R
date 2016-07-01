train <- data.frame(class=c("spam","ham","ham","ham"), 
                    viagra=c("yes","no","no","yes"))
train


library(e1071)
classifier <- naiveBayes(class ~ viagra,train)
classifier


test <- data.frame(viagra=c("yes"))
test$viagra <- factor(test$viagra, levels=c("no","yes"))
test


prediction <- predict(classifier, test ,type="raw")
prediction

####Doing the same with two predictors

train <- data.frame(type=c("spam","ham","ham","ham"), 
                    viagra=c("yes","no","no","yes"),
                    meet=c("yes","yes","yes", "no"))
train



classifier <- naiveBayes(type ~ viagra + meet,train)
classifier

#####Using estimated model to calculate conditional probability
test <- data.frame(viagra=c("yes"), meet=c("yes"))
test$viagra <- factor(test$viagra, levels=c("no","yes"))
test$meet <- factor(test$meet, levels=c("no","yes"))
test


prediction <- predict(classifier, test ,type="raw")
prediction

###Excercises
##1.Suppose you have a database on four customers. You know their income and whether or not they bought your product. 
##Create a data frame with this data.

df <- data.frame( buy=c("yes", "no", "no", "yes"),
                 income=c("high", "high", "medium", "low"))

df

##2.Using Bayes rule calculate the probability that a customer 
##will buy your product given that he or she has high income.

exercice_classifier <- naiveBayes(buy ~ income,df)
exercice_classifier

#income
#    high 
#no   0.5 0.0  
#yes  0.5 0.5  


####3.Estimate naive Bayes model using your data above. What is the prior probability of someone buying your product? What is the probability that a customer has 
###a high income give that he or she bought your product?

exer_prediction <- predict(exercice_classifier, df ,type="raw")
exer_prediction

## answer: 0.500000000

###4. Using the model you estimated above predict the probability of buying given that a customer has high income. 
##Is your result the same as the one you calculated by hand in question 1?

yes

###5. Suppose you have a database on four customers. You know their gender, income and whether or not they bought your product. 
##Create a data frame with this data.

df2 <- data.frame( buy=c("yes", "no", "no", "yes"),
                  income=c("high", "high", "medium", "low"),
                    gender=c("male","female","female", "male"))

df2

###6. Using Bayes rule calculate the probability that 
##a customer will buy your product given that he has high income and male.

ex_classifier <- naiveBayes(buy ~ income + gender, df2)
ex_classifier

#income
#Y     high low medium
#no   0.5 0.0    0.5
#yes  0.5 0.5    0.0

#gender
#Y     female male
#no       1    0
#yes      0    1


####7. Estimate naive Bayes model using your data above.

#What is the prior probability of someone buying your product? 
test <- data.frame(income=c(""), gender=c(""), buy=c("yes"))
test$income <- factor(test$income, levels=c("high","medium","low"))
test$gender <- factor(test$gender, levels=c("male","female"))
test$buy <- factor(test$buy, levels=c("yes","no"))
test
exer_prediction2 <- predict(ex_classifier, test ,type="raw")
exer_prediction2
############no yes
########[1,] 0.5 0.5





#What is the probability that a customer has a high income given that he or she bought your product? 
test <- data.frame(income=c("high"), gender=c(""), buy=c("yes"))
test$income <- factor(test$income, levels=c("high","medium","low"))
test$gender <- factor(test$gender, levels=c("male","female"))
test$buy <- factor(test$buy, levels=c("yes","no"))
test
exer_prediction3 <- predict(ex_classifier, test ,type="raw")
exer_prediction3


############no yes
##########[1,] 0.5 0.5

#What is the probability that a customer is male given that he bought your product?

test <- data.frame(income=c(""), gender=c("male"), buy=c("yes"))
test$income <- factor(test$income, levels=c("high","medium","low"))
test$gender <- factor(test$gender, levels=c("male","female"))
test$buy <- factor(test$buy, levels=c("yes","no"))
test
exer_prediction4 <- predict(ex_classifier, test ,type="raw")
exer_prediction4

##   no         yes
###[1,] 0.999001 0.000999001


######8. Using the model you estimated above, predict the probability of 
##buying given that a customer has a high income and is male. 
test <- data.frame(income=c("high"), gender=c("male"), buy=c(""))
test$income <- factor(test$income, levels=c("high","medium","low"))
test$gender <- factor(test$gender, levels=c("male","female"))
test$buy <- factor(test$buy, levels=c("yes","no"))
test
exer_prediction5 <- predict(ex_classifier, test ,type="raw")
exer_prediction5


######no         yes
#[1,] 0.999001 0.000999001

###Is your result the same as the one you calculated by hand in question 1?
No
