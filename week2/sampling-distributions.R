library(tidyverse)

####################################################################################
# IST Chapter 4, Exercise 4.1
#
# Table 4.4 presents the probabilities of the random variable Y:
#
tab1 <-tribble(
   ~Value, ~Probability,
#  ------|------------
     0   ,   "1p",
     1   ,   "2p",
     2   ,   "3p",
     3   ,   "4p",
     4   ,   "5p",
     5   ,   "6p")
tab1<- tab1%>% mutate(prob_fac = row_number())
# These probabilities are a function of the number p, the probability of
# the value "0". Answer the following questions:
#
# 1. What is the value of p?
P <-1/(select(tab1,prob_fac)%>%summarize(p=sum(prob_fac)))
p<-(pull(P["p"]))
tab1<-tab1%>%mutate(probs =p*pull(value['prob_fac']) )
# 2. P(Y < 3) = 0.2857143
tab1<-tab1%>%mutate(P_cumilitive = cumsum(probs) )%>%select(Value, probs, P_cumilitive)
filter(tab1,tab1$Value==2)%>%pull("P_cumilitive")

# 3. P(Y = odd) =  0.571
filter(tab1,tab1$Value%%2 !=0)%>%summarize(sum(probs))
# 4. P(1 <= Y < 4) = 0.429
filter(tab1,tab1$Value>=1 & tab1$Value<4)%>%summarize(sum(probs))
# 5. P(|Y - 3| < 1.5) = 0.571
filter(tab1,abs(tab1$Value-3)<1.5)%>%summarize(sum(probs))
# 6. E(Y) = 3.33
tab1<-tab1%>%mutate(E_Y = Value*probs )
tab1%>%summarize(sum(E_Y))
# 7. Var(Y) = 2.22
Var = tab1%>%mutate(E_Y_Y =(Value -sum(E_Y))^2*probs)%>%summarize(sum(E_Y_Y))
Var
# 8. What is the standard deviation of Y? =  1.490712
Var^(1/2)

####################################################################################
# IST Chapter 4, Exercise 4.2
#
# One invests $2 to participate in a game of chance. In this game a coin
# is tossed three times. If all tosses end up "Head" then the player wins
# $10. Otherwise, the player loses the investment.
#
# 1. What is the probability of winning the game?
# Prob(Head) = 1/2 so for three consequtive events = P(head)*P(head)*P(head) = 1/8
# 2. What is the probability of losing the game?
# (1- 1/8) = 7/8
# 3. What is the expected gain for the player that plays this game?
#    (Notice that the expectation can obtain a negative value.)
# 8*(1/8)+(-2*(1-1/8)) = 1-7/4 = -3/4


####################################################################################
# IST Chapter 6, Exercise 6.1
#
# Consider the problem of establishing regulations concerning the maximum
# number of people who can occupy a lift. In particular, we would like to
# assess the probability of exceeding maximal weight when 8 people are
# allowed to use the lift simultaneously and compare that to the probability
# of allowing 9 people into the lift.
#
# Assume that the total weight of 8 people chosen at random follows a
# Normal distribution with a mean of 560kg and a standard deviation of 57kg.
# Assume that the total weight of 9 people chosen at random follows a
# Normal distribution with a mean of 630kg and a standard deviation of 61kg.
#
# 1. What is the probability that the total weight of 8 people exceeds 650kg?
1-pnorm(650,560,57)
# 2. What is the probability that the total weight of 9 people exceeds 650kg?
1-pnorm(650,630,61)
# 3. What is the central region that contains 80% of distribution of the
#    total weight of 8 people?
560+qnorm(0.1)*57 # from here to 
560+qnorm(0.9)*57 #till here
# 4. What is the central region that contains 80% of distribution of the
#    total weight of 9 people?
qnorm(0.1,630,61) # from here
qnorm(0.9,630,61) # till here
# Hint: use pnorm() and qnorm().
####################################################################################
# IST Chapter 7, Exercise 7.1
#
# The file "pop2.csv" contains information associated to the blood pressure
# of an imaginary population of size 100,000:
# http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv
#
# Variables: id, sex, age, bmi, systolic, diastolic, group
#
# Our goal is to investigate the sampling distribution of the sample average
# of the variable "bmi". We assume a sample of size n = 150.
#
# 1. Compute the population average of the variable "bmi".
# 2. Compute the population standard deviation of the variable "bmi".
# 3. Compute the expectation of the sampling distribution for the sample
#    average of the variable.
# 4. Compute the standard deviation of the sampling distribution for the
#    sample average of the variable.
# 5. Identify, using simulations, the central region that contains 80% of
#    the sampling distribution of the sample average.
# 6. Identify, using the Central Limit Theorem, an approximation of the
#    central region that contains 80% of the sampling distribution of the
#    sample average.

pop2 <- read_csv("http://pluto.huji.ac.il/~msby/StatThink/Datasets/pop2.csv")
pop2%>%summarize(mean(bmi))# true mean of bmi
pop2%>%summarize(sd(bmi)) # std in actual data
sample_avg <-replicate(1e5,sample(pop2$bmi,150)%>%mean())
exp = mean(sample_avg)# expectation value of mean distribution
exp
std = sd(sample_avg)# standard error in mean distribution
std
data.frame(sample_avg)%>%ggplot(aes(x=sample_avg))+geom_histogram()
quantile(sample_avg,0.1) # from this 
quantile(sample_avg,0.9) # till here 80% lies
qnorm(0.1,exp,std) #from this 
qnorm(0.9,exp,std)# till here 80% lies

# Hint: for (5), use replicate() to draw many samples of size 150,
# compute the mean of bmi for each, then use quantile().
# For (6), use qnorm() with the expectation and sd from (3) and (4).
