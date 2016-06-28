## Day 1
  * Continue last week's exercise on developing the best model you can to [predict daily Citibike trips](https://github.com/msr-ds3/coursework/tree/master/week2#predicting-daily-citibike-trips)
  * Do Lab 2, "Ridge Regression and the Lasso" in Chapter 6 of Introduction to Statistical Learning; see sections 5.1 and 6.2 for related reading and background material


## Day 2
  * Revise the Citibike model in a few ways:
    * Look at feature distributions to get a sense of what tranformations (e.g., ``log`` or manually created factors) might improve model performance
    * Add holiday effects and look at how much of the overall error is coming from holidays compared to regular days
    * Use the predicted vs. actual plots to diagnose which examples in the training set you're doing poorly on, and see if there's anything systematic that can be adjusted
  * After completing yesterday's Lab 2 from Chapter 6 in ISL, use ``cv.glmnet`` to potentially improve upon your best model for the Citibike data. What is your overall R^2 and mean-squared error?
