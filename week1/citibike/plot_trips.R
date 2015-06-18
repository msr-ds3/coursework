########################################
# load libraries
########################################

# load some packages that we'll need
library(dplyr)
library(ggplot2)
library(reshape)
library(scales)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# set the data and figure directories
data_dir <- '.'
figure_dir <- '.'


########################################
# load weather and trip data
########################################

# load RData file output by load_trips.R
load(sprintf('%s/trips.RData', data_dir))


########################################
# plot trip and weather data
########################################

# plot the distribution of trip times across all rides

# plot the distribution of trip times by rider type

# plot the number of trips over each day

# plot the number of trips by gender and age
