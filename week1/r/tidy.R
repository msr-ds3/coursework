# create a data frame with different year/gender combinations
# and remove senior females
years <- c('Freshman','Sophmore','Junior','Senior')
genders <- c('Male','Female')
df <- data.frame(expand.grid(year=years, gender=genders), x=1:8)
df <- df[1:7, ]

# spread this data frame out, with one column per gender, with x as the value
df_wide <- spread(df, gender, x)

# gather the previous data frame back in, with a key column called "sex" and a value column called "y"
df_long <- gather(df_wide, "sex", "y", 2:3)

# spread this data frame out, with one column per year, with x as the value
df_wide <- spread(df, year, x)

# gather the previous data frame back in, with a key column called "class" and a value column called "z"
df_long <- gather(df_wide, "class", "z", 2:5)
