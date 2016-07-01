library ( ISLR )
names ( Smarket )
dim ( Smarket )
summary(Smarket)
cor ( Smarket )
cor ( Smarket [ , -9])

attach ( Smarket )
plot ( Volume )


########4.6.2 Logistic Regression


glm.fit = glm(Direction ~Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume , data = Smarket , family = binomial )
summary(glm.fit)

coef (glm.fit)
summary(glm.fit)$coef
summary (glm.fit)$coef[,4]
