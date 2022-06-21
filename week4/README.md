This week covers replications and extensions of [this article]([https://github.com/msr-ds3/coursework/blob/master/week4/ft_police_complaints.pdf](https://onlinelibrary.wiley.com/doi/full/10.1111/irv.12816)) on correlations between socioeconomic factors and mobility with COVID-19 caseloads in NYC in early 2020. You'll work in groups of 2 for this.

1. Start by reading the paper. Focus on figures 1 and 2 and table 1. These will be the main results to replicate in the paper. Time permitting we will try to replicate Table 2 as well.

2. Follow the links to the datasets that were used, and try to track down the COVID case count and American Community Survey (ACS) data. Sketch out a plan for how you can use these data sets to get the results in the paper.

3. Write reproducible code to create the results in the paper. Follow the template for the [ngrams assignment](../week3/ngrams) in organizing your code. For instance, you might want a file called `01_download_covid_case_counts.sh` to download the data for NYC case counts to a `data/` subdirectory in your repository. Do all of your work in your group's project repository, which you have direct read/write access to (no need to fork and issue pull requests, etc.):

    * https://github.com/msr-ds3/covid-nyc-2022-group-1
    * https://github.com/msr-ds3/covid-nyc-2022-group-2
    * https://github.com/msr-ds3/covid-nyc-2022-group-3
    * https://github.com/msr-ds3/covid-nyc-2022-group-4
    * https://github.com/msr-ds3/covid-nyc-2022-group-5
    * https://github.com/msr-ds3/covid-nyc-2022-group-6

4. From here think about extensions to the article. Each group will probably come up with different questions to ask of the data. Write down the questions your group is interested in along with a plan for how you can tackle them with the data you have. 

6. Write one Rmarkdown notebook file that contains all of your results, including the replications and your extension. Commit the source code and rendered notebook to your group's Github repository (links for that coming soon), with a README that explains what each file does.
