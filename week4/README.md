This week covers replications and extensions of [this article](https://github.com/msr-ds3/coursework/blob/master/week4/ft_police_complaints.pdf) on complaints filed against police officers in NYC, Chicago, and Philadelphia. You'll work in groups of 2 for this.

1. Start by reading the paper. Focus on the first figure, the three panels showing how complaints are disproportionately concentrated among the top decile of officers who draw the most complaints. This will be the main result to replicate in the paper.

2. Then read the methodology details at the end of the article, and follow the links to the datasets that were used. Take a look at the NYC data set and read the specific steps that were done to filter the data and deal with complaints containing more than one allegation. Sketch out a plan for how you can use this data to get the results in the main figure.

3. Write reproducible code to create the middle panel of the figure for officers in NYC. Follow the template for the [ngrams assignment](../week3/ngrams) in organizing your code. For instance, you might want a file called `01_download_nyc_complaints.sh` to download the data for NYC complaints to a `data/` subdirectory in your repository, and maybe an `02_clean_nyc_complaints.R` script to prepare the data for analysis, and so on. Do all of your work in your group's project repository, which you have direct read/write access to (no need to fork and issue pull requests, etc.):

    * https://github.com/msr-ds3/officer-complaints-2021-group-1
    * https://github.com/msr-ds3/officer-complaints-2021-group-2
    * https://github.com/msr-ds3/officer-complaints-2021-group-3
    * https://github.com/msr-ds3/officer-complaints-2021-group-4
    * https://github.com/msr-ds3/officer-complaints-2021-group-5
    * https://github.com/msr-ds3/officer-complaints-2021-group-6

4. Do the same as steps 2 and 3, but for Chicago and Philadelphia, looking at the data and noting differences in how they were cleaned or handled based on the methodology writeup at the end of the article.

5. From here think about extensions to the article. Each group will probably come up with different questions to ask of the data. Write down the questions your group is interested in along with a plan for how you can tackle them with the data you have. 

6. Write one Rmarkdown notebook file that contains all of your results, including the replication of the article figure and your extension. Commit the source code and rendered notebook to your group's Github repository (links for that coming soon), with a README that explains what each file does.
