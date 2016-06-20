# Intro to Statistics and Machine Learning
## Day 1
  * See [Intro to Estimators and Sampling](estimators-and-sampling.pptx) slides
  * Review and modify [this code](http://rpubs.com/jhofman/statistical_inference) to simulate flipping a biased coin and estimating the bias on the coin:
    * Use the ``estimate_coin_bias(N,p)`` function that simulates flipping a coin with probability ``p`` of landing heads ``N`` times and returns an estimate of the bias using the sample mean ``p_hat``
	* Run this simulation 1000 times, for all combinations of ``N = {10,100,100}`` and ``p = {0.1, 0.5, 0.9}``
	* Plot the distribution of ``p_hat`` values for each ``N, p`` setting
	* Plot the standard deviation of the ``p_hat`` distribution as a function of the sample size ``N``
	* Create one plot of the ``p_hat`` distributions, faceted by different ``N`` values for ``p = 0.5`` using ``ggplot``
  * Review the third chapter of [An Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/index.html) and work on the associated lab
  * Also check out Chapters 7, 8, and 9 of [Introduction to Statistical Thinking (With R, Without Calculus)](http://pluto.huji.ac.il/~msby/StatThink/)
 