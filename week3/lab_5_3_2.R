glm.fit = glm(mpg ~ horsepower, data = Auto)
coef(glm.fit)

lm.fit = lm(mpg ~ horsepower, data = Auto)
coef(lm.fit)

library(boot)
glm.fit = glm(mpg ~ horsepower, data = Auto)
cv.err = cv.glm(Auto, glm.fit)
cv.err$delta

cv.error = rep(0, 5)
for(i in 1:5) {
  glm.fit = glm(mpg ~ poly(horsepower, i), data=Auto)
  cv.error[i] = cv.glm(Auto, glm.fit)$delta[1]
}
cv.error































