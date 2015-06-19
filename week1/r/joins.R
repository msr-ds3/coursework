df1 <- data.frame(x1=c('A','B','C','E','A'),
                  x2=c(1,2,3,4,5))
df2 <- data.frame(x1=c('A','B','D'),
                  x3=c(T,F,T))

inner_join(df1, df2)

left_join(df1, df2)

right_join(df1, df2)

full_join(df1, df2)

anti_join(df1, df2)
