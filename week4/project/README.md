# Replication of "Anti-Immigrant Rhetoric and ICE Reporting Interest: Evidence from a Large-Scale Study of Web Search Data"

This week covers replications and extensions of [this article](https://www.cambridge.org/core/journals/british-journal-of-political-science/article/abs/antiimmigrant-rhetoric-and-ice-reporting-interest-evidence-from-a-largescale-study-of-web-search-data/AF982680AEC49AE65CACFD73352A44AD) on the relationship between media cues and public interest in reporting suspected unauthorized immigrants to Immigration and Customs Enforcement (ICE). The study uses Google Trends and Bing search data, combined with automated content analysis of cable news transcripts.

1. Start by reading the paper. Focus on figures 2-4, and tables 3-4. These will be the main results to replicate in the paper.

2. Follow the links to the data sources that were used. The [Google Trends](https://trends.google.com/trends/) website will be necessary for Figure 4 and Table 3. Put `google_trends_report.csv`, `google_trends_crime.csv`, and `google_trends_welfare.csv` into the `/from_google_trends` directory. Explore the data in the `from_replication_files/` folder and think about how the data can be transformed to create Figures 2 and 3.

3. Sketch out a plan for how you can use these data sets to get the results in the paper and write reproducible code to create the results in the paper. Follow the template for the [ngrams assignment](../week3/ngrams) in organizing your code. For instance, you might want a file called `01_download_google_trends.sh` to download the data for Google Trends search queries to a `data/` subdirectory in your repository. Do all of your work in your group's project repository, which you have direct read/write access to (no need to fork and issue pull requests, etc.):

    * https://github.com/msr-ds3/immigrant-news-2024-group-1
    * https://github.com/msr-ds3/immigrant-news-2024-group-2
    * https://github.com/msr-ds3/immigrant-news-2024-group-3
    * https://github.com/msr-ds3/immigrant-news-2024-group-4
    * https://github.com/msr-ds3/immigrant-news-2024-group-5
    * https://github.com/msr-ds3/immigrant-news-2024-group-6

4. From here think about extensions to the article. Could you have approached this problem differently with the same data (e.g. news transcripts from CNN, Fox, and MSNBC)? Are there other ways to plot the same information? Each group will probably come up with different questions to ask of the data. Write down the questions your group is interested in along with a plan for how you can tackle them with the data you have. 

6. Write one Rmarkdown notebook file that contains all of your results, including the replications and your extension. Commit the source code and rendered notebook to your group's Github repository, with a README that explains what each file does.