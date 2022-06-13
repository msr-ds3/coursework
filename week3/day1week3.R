library(tidyverse)


df <- read.delim("bodydata.txt", header = FALSE, sep = "")
head(df)
df %>% rename('weight'= V23, 'height'= V24)
#view(df)

ggplot(df, aes(x=V24, y=V23)) + geom_point() + xlab('Height')+ ylab('Weight')


lm.fit <- lm(V23 ~ V24, data = df)
summary(lm.fit)
