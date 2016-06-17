# create two data frames with a common column name (x1)
df1 <- data.frame(x1=c('A','B','C','E','A'),
                  x2=c(1,2,3,4,5))
df2 <- data.frame(x1=c('A','B','D'),
                  x3=c(T,F,T))

# match on values in column x1, keep rows that have matches in both df1 and df2
inner_join(df1, df2)

# match on values in column x1, keep all rows in df1 and create NAs for unmatched entries in df2
left_join(df1, df2)

# match on values in column x1, show all rows in df1 without a match in df2
anti_join(df1, df2)

# match on values in column x1, keep all rows in df2 and create NAs for unmatched entries in df1
right_join(df1, df2)

# match on values in column x1, show all rows in df2 without a match in df1
anti_join(df2, df1)

# match on values in column x1, keep all rows in both df1 and df2, and create NAs for unmatched entries
full_join(df1, df2)
