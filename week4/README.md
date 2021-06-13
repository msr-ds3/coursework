This week covers replications and extensions of [Epidemic Model Guided Machine Learning for
COVID-19 Forecasts in the United States](https://www.medrxiv.org/content/10.1101/2020.05.24.20111989v1.full.pdf) by Zou et al., on using reported historical data about covid-19 and epidemic model to forecast the spread of COVID-19 in the US. You'll work in groups of **?** for this.

1. Start by reading the paper.

2. Get the datasets (in the data folder), implement the SuEIR Model, and train the model for short-term (1 day head) national-level forecasts.
    - The main challenges in implementing a SuEIR model involves
        - Solving a system of ordinary differential equations to get a prediction of the population in each compartment.
        - Optimizing for a small loss (with a particular loss function) to get a set of good model parameters.

    For both these two tasks, you can find corresponding solvers/optimizers from the ```scipy``` library.

    - If you have difficulty in implementing the SuEIR model, you can start from a simpler epidemic model SIR (Hint: Please find a blog about SIR model as a reference [COVID-19 dynamics with SIR model](https://www.lewuathe.com/covid-19-dynamics-with-sir-model.html), where you can use some toy data to run a simulation on SIR model.)

2. Get additional datasets to train both national and state-level forecasts to replicate the results in Table 1 and Table 2 of Section 3.

3. Extension. Ideas to try: How does the stay-home notice and vaccination affect the accuracy of the model? How should we adjust the forecasting procedure accordingly?

4. Write up all of your results in a notebook file. Commit the source code and the rendered notebook to your group's Github repository.