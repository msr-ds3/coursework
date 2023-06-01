# load all packages in the tidyverse, although we'll use only dplyr here
library(tidyverse)

# vectors hold values of the same type
# c() is the "concatenation" operator
c(1,2,3)

# the colon operator is handy for generating sequential vectors
1:3

# seq is good for other intervals
seq(1, 10, by=2)

# watch out for silent type coercion
c(1,'a')
c(1,'2')
c('alice','bob')

# vectors can have named columns
v <- c(alice=1, bob=2)
v["alice"]

# factors are for categorical variables
# they have labels that are mapped to levels
v <- c('alice','bob','bob','alice','alice')
v <- as.factor(v)
str(v)

# R tries to perform the right operation based on the data type
# for example, computing a table of counts to summarize categorical data
summary(v)

# data frames hold tabular data, implemented as a list of vectors of the same length

# assign the first 6 rows of the built-in iris dataset as a toy dataframe
df <- head(iris)
df

# inspect the structure of the data frame
str(df)

# compute summary statistics for each column
# notice that the factor in the last column is summarized differently
summary(df)

# look at the fifth row
df[5, ]

# three different ways to look at the second column

# by index
df[ , 2]

# by name
df[ , "Sepal.Width"]

# extracting the column vector
df$Sepal.Width

# select all rows with Sepal.Length at least 5
df[df$Sepal.Length >= 5, ]

# equivalent to selecting rows 1, 5, and 6 using a logical vector
df[c(T,F,F,F,T,T), ]

# nicer syntax for the same thing
# note: the second entry of filter is a logical vector
filter(df, "Sepal.Length" >= 5)

# filter ANDs conditions when given multiple arguments
filter(df, Sepal.Length >= 5, Petal.Length <= 1.4)

# other logical combinations must be manually specified as one argument
# make sure to use the vector-friendly | and & (not || and &&)
filter(df, "Sepal.Length" >= 5 | "Petal.Length" <= 1.4)

# count the rows in the full iris dataframe where the species starts with a v
nrow(filter(iris, grepl('^v', "Species")))






