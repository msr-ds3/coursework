library(glmnet)

N=100
K=100

#These fields store youre mses
#(l for lasso, r for ridge, o for ols, te for test, tr for train)
mse_l_te=c()
mse_l_tr=c()

mse_r_te=c()
mse_r_tr=c()

mse_o_te=c()
mse_o_tr=c()

#Generate Sparse Beta
#b_true = matrix(c(c(5,5,5,5),c(rep(0,K-4))),K,1)

#Loop over 20 simulations
for (j in 1:20)
{
  print(j)
#Genrate Random Beta (not sparse)
b_true=matrix( rnorm(1*K,mean=0,sd=1), K, 1) #Comment this line out to use sparse true model

#Data generating Process for training data
X_tr=matrix( rnorm(N*K,mean=0,sd=1), N, K) 
e_tr=matrix( rnorm(1*N,mean=0,sd=1), N, 1) 
Y_tr=X_tr %*% b_true + e_tr

#Data generating Process for testing data
X_te=matrix( rnorm(N*K,mean=0,sd=1), N, K) 
e_te=matrix( rnorm(1*N,mean=0,sd=1), N, 1) 
Y_te=X_te %*% b_true + e_te

#Train Models
ols<-glm(Y_tr~X_tr)
las<-cv.glmnet(X_tr,Y_tr,alpha=1,lambda=10^seq(-5,-1,.1))
rid<-cv.glmnet(X_tr,Y_tr,alpha=0,lambda=10^seq(-5,-1,.1))

#Get Lasso predictions
Yh_tr_l<-predict(las,X_tr)
Yh_te_l<-predict(las,X_te)

#Get Ridge Predictions
Yh_tr_r<-predict(rid,X_tr)
Yh_te_r<-predict(rid,X_te)

#Get OLS Predictions
Yh_tr_o<-predict(ols,data.frame(X_tr))
Yh_te_o<-predict(ols,data.frame(X_te))

#Append mse of current simulation to lists
mse_l_tr<-c(mse_l_tr,mean((Y_tr-Yh_tr_l)^2))
mse_r_tr<-c(mse_r_tr,mean((Y_tr-Yh_tr_r)^2))
mse_o_tr<-c(mse_o_tr,mean((Y_tr-Yh_tr_o)^2))
mse_l_te<-c(mse_l_te,mean((Y_te-Yh_te_l)^2))
mse_r_te<-c(mse_r_te,mean((Y_te-Yh_te_r)^2))
mse_o_te<-c(mse_o_te,mean((Y_te-Yh_te_o)^2))


}

#Compute avg. MSE for training data
training_err<-c(mean(mse_l_tr),mean(mse_r_tr),mean(mse_o_tr))
testing_err<-c(mean(mse_l_te),mean(mse_r_te),mean(mse_o_te))

#Resulsts should roughtly be (Sparse Model):
#      Lasso      Ridge        OLS
#tr: 6.490641e-01 8.623535e-02 2.293337e-26
#te: 1.276259*   9.903393 211.245304


#Resulsts should roughtly be (Non-sparse Model):
#      Lasso      Ridge        OLS
#tr: 7.423908e-01 9.797229e-02 2.271638e-27
#te: 17.63317  10.43026* 194.61785

#* denotes winner

#Result Summary:
#(1) For ols: training error is always the lowest and testing error is VERY high
#(2) Sparse model: lasso has lowest MSE in the test set
#(3) Non-sparse model: ridge has lowest MSE in the test set
#(4) OLS training error exactly 0 (up to numerical error) because K=N.