

model <- lm(numtrip ~ day_of_week + tmax*prcp + is_holiday + season, data= df)

save(model, file='model.RData')
