This week covers several assignments on reproducing the results of published research papers.

# Day 1

## The long tail

* Take a look at [The Anatomy of the Long Tail](https://5harad.com/papers/long_tail.pdf) and think about how to generate Figures 1 and 2 (you can ignore the null model in Figure 2)
* Use the [download_movielens.sh](download_movielens.sh) script to download the [MovieLens data](http://grouplens.org/datasets/movielens/)
* Fill in code in the [movielens.Rmd](movielens.Rmd) file to reproduce plots from lecture slides and Figures 1 and 2 from the paper

# Day 2

## N-gram data and "Culturonomics"

* Replicate and extend the results of the [Google n-grams "culturomics" paper](https://science.sciencemag.org/content/331/6014/176) using the template [here](ngrams/)

# Day 3

## Predicting daily Citibike trips (open-ended)

The point of this exercise is to get experience in an open-ended prediction exercise: predicting the total number of Citibike trips taken on a given day. Do all of your work in an RMarkdown file named `predict_citibike.Rmd`. Here are the rules of the game:

1. Use the `trips_per_day.tsv` file that has one row for each day, the number of trips taken on that day, and the minimum temperature on that day.
2. Split the data into randomly selected training, validation, and test sets, with 80% of the data for training the model, 10% for validation, and 10% for a final test set (to be used once and only once towards the end of this exercise). You can adapt the code from last week's [complexity control notebook](../week2/complexity_control.ipynb) to do this. You can use a single validation fold, don't worry about k-fold cross-validation here.
3. Start out with the model in that notebook, which uses only the minimum temperature on each day to predict the number of trips taken that day. Try different polynomial degrees in the minimum temperature and check that you get results similar to what's in that notebook, although they likely won't be identical due to shuffling of which days end up in the train, validation, and test splits. Quantify your performance using [root mean-squared error](https://www.kaggle.com/wiki/RootMeanSquaredError).
4. Now get creative and extend the model to improve it. You can use any features you like that are available prior to the day in question, ranging from the weather, to the time of year and day of week, to activity in previous days or weeks, but don't cheat and use features from the future (e.g., the next day's trips). You can even try adding [holiday](https://gist.github.com/shivaas/4758439) effects. You might want to look at feature distributions to get a sense of what tranformations (e.g., ``log`` or manually created factors such as weekday vs. weekend) might improve model performance. You can also interact features with each other. This [formula syntax in R](https://cran.r-project.org/doc/manuals/R-intro.html#Formulae-for-statistical-models) reference might be useful.
5. Try a bunch of different models and ideas, documenting them in your Rmarkdown file. Inspect the models to figure out what the highly predictive features are, and see if you can prune away any negligble features that don't matter much. Report the model with the best performance on the validation data. Watch out for overfitting.
6. Plot your final best fit model in two different ways. First with the date on the x-axis and the number of trips on the y-axis, showing the actual values as points and predicted values as a line. Second as a plot where the x-axis is the predicted value and the y-axis is the actual value, with each point representing one day.
7. When you're convinced that you have your best model, clean up all your code so that it saves your best model in a ``.RData`` file using the `save` function.
8. Commit all of your changes to git, using ``git add -f`` to add the model ``.Rdata`` file if needed, and push to your Github repository.
9. Finally, use the model you just developed and pushed to Github to make predictions on the 10% of data you kept aside as a test set. Do this only once, and record the performance in your Rmarkdown file. Use this number to make a guess as to how your model will perform on future data (which we'll test it on!). Do you think it will do better, worse, or the same as it did on the 10% test set you used here? Write your answer in your Rmarkdown notebook. Render the notebook and push the final result to Github.

<!--
8. Write a new file that loads in the [weather data for new days](weather_2015.csv) and your saved model, and predicts the number of trips for each day (see [load_trips.R](../week1/load_trips.R) for code snippets to load in the weather data).
9. Modify the [download_trips.sh](../week1/download_trips.sh) script to download trips from 2015 (instead of 2014). 
10. Compute the RMSE between the actual and predicted trips for 2015 and compare the results to what you found with cross-validation.
11. Pair up with a partner who has a different model, run their model, and evaluate the predictions it makes for the 2015 data.
-->