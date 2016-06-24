library(readr)
library(ggplot2)
library(scales)
library(broom)

##########1.Let’s return to the orange juice assignment and investigate 
#how store demographics are related to demand.
#i.Let’s start with the following model: logmove ~ log(price)*brand*feat and add in 
#the store demographics as linear features (e.g., + AGE60 + EDUC + ETHNIC + INCOME). 
#Try them individually and then all together.

ml.fit <- lm(logmove ~ log(price) * brand * feat + AGE60 , data=oj) #t value : 29.354 
ml.fit <- lm(logmove ~ log(price) * brand * feat + EDUC , data=oj) #t value is 4.460 
ml.fit <- lm(logmove ~ log(price) * brand * feat + ETHNIC, data=oj) #t value is 19.873 
ml.fit <- lm(logmove ~ log(price) * brand * feat + INCOME, data=oj) #t value is -14.921 
ml.fit <- lm(logmove ~ log(price) * brand * feat + HHLARGE, data=oj) #t value is -2.67685  


ml.fit <- lm(logmove ~ log(price) * brand * feat + . , data=oj)
summary(ml.fit)

   
    AGE60                             16.391  
    EDUC                              8.729  
    ETHNIC                            16.151  
    INCOME                           -9.139 
    HHLARGE                          -4.556 
    WORKWOM                          -3.417 
    HVAL150                           9.241  
    


#ii.what demographics are significantly (t > 2 standard deviations) related to demand?
All demographs are significanly related to demand.

#iii.How much did the adjusted R-squared improve with the addition of these variables?
ml.fit <- lm(logmove ~ log(price) * brand * feat, data=oj)
before it was:  0.5352 
and after:  0.5865 

0.6578 - 0.5352 
So it increased  by 0.0513


##########2.Let’s focus on two variables HHLARGE ("fraction of households that are large") 
#and EDUC ("fraction of shoppers with advanced education").
ml.fit <- lm(logmove ~ log(price) * brand * feat + EDUC + HHLARGE, data=oj)
#i.What are the means and percentiles of each of these variables?
meaneducation = oj$EDUC
mean(meaneducation)
0.2252196
quantile(meaneducation)

0%        25%        50%        75%       100% 
0.04955029 0.14598491 0.22939040 0.28439465 0.52836201 

meanHH = oj$HHLARGE
mean(meanHH)
0.1156024

quantile(meanHH)
0%        25%        50%        75%       100% 
0.01350636 0.09793763 0.11122120 0.13516767 0.21635434 




#ii.Using your coefficient estimates from the regression in 1b:
#a....If we move from the median value of HHLARGE to the 75th percentile (3rd quartile), 
#how much does logmove change each week on average?
#You can estimate this visually if you plot the fitted model, 
#or you can compare the predicted values for rows that have the median and 75th percentiles for HHLARGE.


library(readr)
library(ggplot2)
library(scales)
library(broom)
##########################################

model = lm(data = oj, logmove ~ log(price)*HHLARGE + log(price)*EDUC)
oj$predicted = fitted(model)
median_75_oj = oj %>% filter(HHLARGE == quantile(oj$HHLARGE, 0.75) | HHLARGE == median(oj$HHLARGE))
ggplot(median_75_oj, aes(x=HHLARGE, y=predicted)) + geom_smooth(method="lm")

###filter(oj$HHLARGE %in% quantile(oj$HHLARGE , c(0.50,0.75)))

OR #######################################
model = lm(data = oj, logmove ~ HHLARGE + EDUC)
oj$predicted = fitted(model)
median_75_oj = oj %>% filter(HHLARGE == quantile(oj$HHLARGE, 0.75) | HHLARGE == median(oj$HHLARGE))
ggplot(median_75_oj, aes(x=HHLARGE, y=predicted)) + geom_smooth(method="lm")

#############################################################################

l.fit <- lm(logmove ~ log(price) * brand * feat + HHLARGE, data=oj)
ml.fit <- lm(logmove ~ HHLARGE + EDUC, data=oj)
oj$predicted <- fitted(ml.fit)

ggplot(oj, aes(x=log(price), y=exp(1)^logmove, color= HHLARGE)) +
  geom_point(alpha=0.1) +
  geom_line(aes(x=log(price), y=pexp(1)^predicted , color=HHLARGE)) +
facet_wrap(~ brand) +
  scale_x_log10(breaks=c(1,2,3)) +
  scale_y_log10(label=comma, breaks=c(1e3,1e4,1e5)) +
  xlab('Price') +
  ylab('Sales')

#b....If we move from the median value of EDUC to the 75th percentile (3rd quartile), how much does logmove change each week on average?
ml.fit <- lm(logmove ~ log(price) * brand * feat + EDUC, data=oj)
oj$predicted <- fitted(ml.fit)


ggplot(oj, aes(x=log(price), y=exp(1)^logmove, color= EDUC)) +
  geom_point(alpha=0.1) +
  geom_line(aes(x=log(price), y=pexp(1)^predicted , color=EDUC))+
  facet_wrap(~ brand) +
  scale_x_log10(breaks=c(1,2,3)) +
  scale_y_log10(label=comma, breaks=c(1e3,1e4,1e5)) +
  xlab('Price') +
  ylab('Sales')
#c....Based on this analysis, which is the more important predictor of demand?
Education



#iii. Now let’s see if these variables impact price sensitivity. 
#Add two interaction terms (with logprice) to the model to test this.
#a....What are the coefficients on the interaction terms?
ml.fit <- lm(logmove ~ log(price) * ETHNIC * AGE60, data=oj)
summary(ml.fit)

  log(price):ETHNIC       -0.89600   
  log(price):AGE60        -0.33730 
 

#b....Recall, positive values indicate lower price sensitivity and negative values indicate greater price sensitivity.
#Do your estimates make sense based on your intuition?
 
  ETHNIC and AGE60--- greater price sensitivity
  
  
#c....What are the coefficient estimates on the constants EDUC and HHLARGE? 
  ml.fit <- lm(logmove ~ log(price) * EDUC * HHLARGE, data=oj)
  summary(ml.fit)
  
  EDUC                     -0.6981     
  HHLARGE                   4.6602
  
  HHLARGE ---    low price sensitivily
  EDUC --- greater price sensitivity
#How do they compare to your regression from 1b?
  from 1b :
    EDUC                              0.7300203 
    HHLARGE                          -1.0523343 
    
    they are flipped :
      EDUC ---    low price sensitivily
      HHLARGE --- greater price sensitivity
    
  
#d....Similar to 2b, if we move from the median value of each variable to the 3rd quartile, 
      #how much does elasticity change? Based on this, which is more important to price sensitivity?
      
      

#iv. You should notice that the coefficients on EDUC and HHLARGE have flipped 
#sign once we include interaction terms with price. 
#HHLARGE now appears to be a positive demand shifter and increases price sensitivity. 
#Explain in words or pictures what is going on.


########## 3. Let’s split our data into a training set and a test set. An easy way to do this is with the sample command. 
#The following will randomly select 20% of the rows in our data frame: 
indexes <- sample(1:nrow(oj), size=0.2*nrow(oj))

#i. Now let’s use this index to create a training and a test set, try: 
OJtest=oj[indexes, ] 
Ojtrain=oj[-indexes, ] 


#What did this do? How many rows does the test set have? How many rows does the training set have?
spreate the data between the OJtest and Ojtrain

the test set has 5789 rows and the training set has 23158

########## 4. Now let’s run the very simple model logmove ~ log(price) + brand on the training data.
#Use LM on this model and report the R-squared.
ml.fit= lm(logmove ~ log(price) + brand, data=Ojtrain)
summary(ml.fit)
this is the Adjusted R-squared:  0.3915 

##Use predict(model, Ojtest) to predict log sales for the test set.

ml.fit= lm(logmove ~ log(price) + brand, data=OJtest)
OJtest$predicted <- fitted(ml.fit)



#Compute cor(predicted_sales,logmove)^2 on the test set. 
#This is our "honest R-squared". How does it compare to the value in (a)?

cor(OJtest$predicted,OJtest$logmove)^2
0.4022723
 # it's greater than Adjusted R-squared'
  
  
#####5. Now let’s run better models.
  
###Run our "previous favorite" logmove ~ brand*log(price)*feat on the training data. 
ml.fit= lm(logmove ~ brand*log(price)*feat, data=Ojtrain)
summary(ml.fit)
#Use LM to get regular R-squared. Now, follow the procedure in (3) to compute "honest R-squared". What is it? How do they compare?
Adjusted R-squared:  0.5338 
Ojtrain$predicted <- fitted(ml.fit)
cor(Ojtrain$predicted,Ojtrain$logmove)^2

honest R-squared:  0.534037


they are alomost the same.

###Now add in all the demographics. What is the regular R-squared on training data? What is the honest R-squared on the test set?
ml.fit= lm(logmove ~ brand*log(price)*feat + AGE60 + EDUC + INCOME + HHLARGE , data=Ojtrain)
summary(ml.fit)


Adjusted R-squared:  0.5617 





