library(dplyr)    # install.packages('dplyr')
library(ggplot2)  # install.packages('ggplot2')
library(scales)   # install.packages('scales')

# set plot theme
theme_set(theme_bw())

# read ratings from csv file
system.time(
  ratings <- read.delim('ratings.csv',
                        sep=',',
			header=F,
                        col.names=c('user_id','movie_id','rating','timestamp'),
                        colClasses=c('integer','integer','numeric','integer'))
)
print(object.size(ratings), units="Mb")

####################
# brief look at data
####################

head(ratings)
nrow(ratings)
str(ratings)

####################
# aggregate stats
####################

# compute aggregate stats
summary(ratings$rating)

# plot distribution of ratings (slide 13)


####################
# per-movie stats
####################

# aggregate ratings by movie, computing mean and number of ratings

# plot distribution of movie popularity (= number of ratings the movie received)

# plot distribution of mean ratings by movie (slide 15)

# rank movies by popularity and compute cdf (slide 17)
# hint: use the cumsum function for a running sum


####################
# per-user stats
####################

# aggregate ratings by user, computing mean and number of ratings

# plot distribution of user activity (= number of ratings the user made)
