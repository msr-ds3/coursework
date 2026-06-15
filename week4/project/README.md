# Replication of "College Football Games and Crime" (Rees & Schnepel, 2009)

This week covers replications and extensions of [this paper](https://jvlone.com/sportsdocs/footballGamesCrime2009.pdf) by Daniel Rees and Kevin Schnepel (Journal of Sports Economics, 2009). The paper examines whether college football games lead to increases in crime in the host community. Using daily offense data from 26 police agencies in college towns matched to game schedules, they find that on average home games are associated with a 9% increase in assaults and an 18% increase in vandalism, but that away games have no effect.

1. Start by reading the paper. Focus on:
    * The data section: how they matched FBI's National Incident-Based Reporting System (NIBRS) offense data to 26 Division I-A (now called "FBS") college football programs (2000–2005)
    * Table 3: the main regression results (home game effect on each crime type)
    * Table 4 (optional/stretch): whether wins vs. losses matter

2. You'll need three data sources:

    **Crime data:** The NIBRS data, cleaned by Jacob Kaplan and available from [openICPSR](https://doi.org/10.3886/E118281V11) (free account required). Download the **offense segment CSV** zip file (one CSV per year). You'll need years 2000–2005. Also download the **batch header CSV** — this small file maps each agency's ORI code to its city name and state.

    **College football schedules:** One option is the `cfbfastR` R package that provides college football game schedules via ESPN (should not require an API key).

    **Team-to-agency mapping:** You'll need to figure out which NIBRS agency (identified by its "ORI code") corresponds to which college football town. Use the batch header file to look up the ORI for the city police department in each college town. Rees & Schnepel list their agencies in a footnote. Note that you'll also need to reconcile how team/city names appear in the NIBRS data vs. how they appear in the football schedule data — they won't always match exactly.

3. Write scripts to extract and process the data, following the template for the [ngrams assignment](../../week3/ngrams). The URLs for the NIBRS data won't be accessible via `curl` or `wget` commands without a login, so you can instead just document the most direct URL to the files that you use. The NIBRS offense segment csv files are large. You might use command-line tools to extract specific ORIs from the zip without loading everything into R, or do the filtering one file at a time in R. It's up to you, just make sure you have reproducible code for it.

4. Replicate the core analysis:

    **Descriptive statistics:** Reproduce Appendix Table 1 from the paper: compute the mean, standard deviation, and quartiles of daily assault and vandalism counts across your sample of college town agencies. Also reproduce Table 2 (distribution of games by day of week).

    **Descriptive figures:** Create figures showing the mean number of offenses on Saturdays (with standard errors), broken out by whether a home game, away game, or no game was played. Start with assaults and vandalism (the other offense types in the paper — DUI, disorderly conduct, liquor law violations — can be a stretch goal).

    **Per-team plot:** Show the same comparison separately for each college town / team instead of aggregated across all teams.

    **Regression (Table 3):** Estimate a linear model of daily offense counts on home-game and away-game indicators, controlling for agency fixed effects, day of week, month, and year. (Don't worry about the fancier negative binomial model the authors fit.) Compare your findings to the paper's (+9% assaults and +18% vandalism for home games, with no effect for away games).

    **Optional (Table 4):** Split home games into wins and losses. Does the outcome matter?

5. From here, think about extensions to the paper. Could you have approached this problem differently with the same data? Are there other ways to plot the same information? Are there other questions you could ask of the crime or football data that the paper doesn't explore? Each group will probably come up with different questions. Write down the questions your group is interested in along with a plan for how you can tackle them with the data you have.

6. Do all of your work in your group's project repository:

    * https://github.com/msr-ds3/sports-crime-2026-group-1
    * https://github.com/msr-ds3/sports-crime-2026-group-2
    * https://github.com/msr-ds3/sports-crime-2026-group-3
    * https://github.com/msr-ds3/sports-crime-2026-group-4
    * https://github.com/msr-ds3/sports-crime-2026-group-5
    * https://github.com/msr-ds3/sports-crime-2026-group-6

7. Write one Rmarkdown notebook file that contains all of your results, including the replications and your extensions. Commit the source code and rendered notebook to your group's Github repository, with a README that explains what each file does.
