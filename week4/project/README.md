# Replication of "Community-Based Fact-Checking on Twitter’s Birdwatch Platform"

This week covers replications and extensions of [this article](https://arxiv.org/pdf/2104.07175) on Community Notes on X (formerly known as Birdwatch on Twitter) for crowdsourced annotations of social media content.

1. Start by reading the paper. Focus on 2, 3, 4, 5c, 7, 8, and 9. These will be the main plots to replicate in the paper. Tables 2 and 3, and Figure 6 use some additional data that aren't publicly available, but that the author has shared with us. Time permitting we will try to fit the model in Equation 1 and plot a corresponding version of Figure 10. Figures 5a, 5b are a stretch goal that require special NLP libraries. 

2. Write a script to download the [Community Notes data](https://x.com/i/communitynotes/download-data), including the "Notes data" file and all 20 "Ratings data" files. The [Community Notes documentation](https://communitynotes.x.com/guide/en/under-the-hood/ranking-notes) might helpful. If you don't have an X account, the notes data is available at [this url](https://ton.twimg.com/birdwatch-public-data/2025/06/16/notes/notes-00000.zip) and the ratings data follows this pattern: `https://ton.twimg.com/birdwatch-public-data/2025/06/16/noteRatings/ratings-000xx.zip` where xx ranges from `00` to `19`.

3. Sketch out a plan for how you can use these data sets to get the results in the paper and write reproducible code to create the results in the paper. Follow the template for the [ngrams assignment](../week3/ngrams) in organizing your code. For instance, you might want a file called `01_download_notes_data.sh` to download the data to a `data/` subdirectory in your repository, and you may want to follow that up with a script to filter the data to the date range in the paper, which will be a very small subset of all the data. (Check your basic counts of number of notes and ratings against the paper.) Do all of your work in your group's project repository, which you have direct read/write access to (no need to fork and issue pull requests, etc.):

    * https://github.com/msr-ds3/community-notes-2025-group-1
    * https://github.com/msr-ds3/community-notes-2025-group-2
    * https://github.com/msr-ds3/community-notes-2025-group-3
    * https://github.com/msr-ds3/community-notes-2025-group-4
    * https://github.com/msr-ds3/community-notes-2025-group-5
    * https://github.com/msr-ds3/community-notes-2025-group-6

4. From here think about extensions to the article. Could you have approached this problem differently with the same data? Are there other ways to plot the same information? Or can you reproduce a version of the Birdwatch algorithm from [this paper](https://arxiv.org/pdf/2210.15723)? Each group will probably come up with different questions to ask of the data. Write down the questions your group is interested in along with a plan for how you can tackle them with the data you have. 

6. Write one Rmarkdown notebook file that contains all of your results, including the replications and your extension. Commit the source code and rendered notebook to your group's Github repository, with a README that explains what each file does. Remember: code like everyone's watching, because they are!