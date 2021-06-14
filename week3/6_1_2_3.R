BWeights <- read.table("babyweights.txt", header=TRUE)
head(BWeights)

# 6.1

bwt_smoke = lm(bwt ~ smoke, data=BWeights)
summary(bwt_smoke)

bwt_parity = lm(bwt ~ parity, data=BWeights)
summary(bwt_parity)

bwt_all = lm(bwt ~ ., data=BWeights)
summary(bwt_all)
