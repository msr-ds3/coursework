library(ggplot2)
df = data.frame(id = 1:100)
df$x = df$id/10
df$e = rnorm(100)
df$y = 2*df$x + df$e
ols = lm(y~x, data=df)
pval = summary(ols)$coefficients[2,4]

#Some plots (e.g. ggplot's) can be saved and then shown via print()
#Others like plot(), we'd have to save the output to a graphics file
#(But you should use ggplot anyways!)
plt = ggplot(data=df, aes(x=x, y=y))+geom_point()

save(pval, plt, file="outputs.RData")
