setwd("/Users/invitado/Documents/Temas_compu/ISLR_curso/ch06")
## 6_a
y = 2
l = 2
bs = seq(-5, 5, 0.1)
f = (y - bs)^2 + l * bs^2
est.beta = y/(1 + l)
est.f = (y - est.beta)^2 + l * est.beta^2
png("ch6_ex6_a.png")
plot(bs, f, pch = 20, xlab = "Beta", ylab = "Optimization")
points(est.beta, est.f, col = 2, pch = 4, lwd = 5, cex = est.beta)
dev.off()

## 6_b
y = 2
l = 2
bs = seq(-5, 5, 0.01)
f = (y - bs)^2 + l * abs(bs)
est.beta = y - l/2
est.f = (y - est.beta)^2 + l * abs(est.beta)
png("ch6_ex6_b.png")
plot(bs, f, pch = 20, xlab = "Beta", ylab = "Optimization")
points(est.beta, est.f, col = 2, pch = 4, lwd = 5, cex = est.beta)
dev.off()

## 8_a
set.seed(1)
x <- rnorm(100)
e <- rnorm(100)

## 8_b
y <- 5 + 4*x - 3*x^2 + 2*x^3 + e
png("ch6_ex8_b.png")
plot(x,y)
dev.off()

## 8_c
library(leaps)
data = data.frame(y = y, x = x)
mod = regsubsets(y ~ poly(x, 10, raw = T), data = data, nvmax = 10)
mod.summary = summary(mod)
which.min(mod.summary$cp)
png("ch6_ex8_c1.png")
plot(mod.summary$cp, xlab = "Subset Size", ylab = "Cp", pch = 20, type = "l")
points(3, mod.summary$cp[3], pch = 4, col = 2, lwd = 2)
dev.off()
which.min(mod.summary$bic)
png("ch6_ex8_c2.png")
plot(mod.summary$bic, xlab = "Subset Size", ylab = "BIC", pch = 20, type = "l")
points(3, mod.summary$bic[3], pch = 4, col = 2, lwd = 2)
dev.off()
which.max(mod.summary$adjr2)
png("ch6_ex8_c3.png")
plot(mod.summary$adjr2, xlab = "Subset Size", ylab = "Adjusted R^2", pch = 20, type = "l")
points(5, mod.summary$adjr2[5], pch = 4, col = 2, lwd = 2)
dev.off()

## 8_d
mod.fwd = regsubsets(y ~ poly(x, 10, raw = T), data = data, nvmax = 10,method = "forward")
mod.bwd = regsubsets(y ~ poly(x, 10, raw = T), data = data, nvmax = 10,method = "backward")
fwd.summary = summary(mod.fwd)
bwd.summary = summary(mod.bwd)
which.min(fwd.summary$cp)
which.min(bwd.summary$cp)
which.min(fwd.summary$bic)
which.min(bwd.summary$bic)
which.max(fwd.summary$adjr2)
which.max(bwd.summary$adjr2)

png("ch6_ex8_d.png")
par(mfrow = c(3, 2))
plot(fwd.summary$cp, xlab = "Subset Size", ylab = "Forward Cp", pch = 20, type = "l")
points(3, fwd.summary$cp[3], pch = 4, col = 2, lwd = 2)
plot(bwd.summary$cp, xlab = "Subset Size", ylab = "Backward Cp", pch = 20, type = "l")
points(5, bwd.summary$cp[5], pch = 4, col = 2, lwd = 2)
plot(fwd.summary$bic, xlab = "Subset Size", ylab = "Forward BIC", pch = 20,
    type = "l")
points(3, fwd.summary$bic[3], pch = 4, col = 2, lwd = 2)
plot(bwd.summary$bic, xlab = "Subset Size", ylab = "Backward BIC", pch = 20,
    type = "l")
points(5, bwd.summary$bic[5], pch = 4, col = 2, lwd = 2)
plot(fwd.summary$adjr2, xlab = "Subset Size", ylab = "Forward Adjusted R^2",
    pch = 20, type = "l")
points(6, fwd.summary$adjr2[6], pch = 4, col = 2, lwd = 2)
plot(bwd.summary$adjr2, xlab = "Subset Size", ylab = "Backward Adjusted R^2",
    pch = 20, type = "l")
points(7, bwd.summary$adjr2[7], pch = 4, col = 2, lwd = 2)
dev.off()

## 8_e
library(glmnet)
xmat = model.matrix(y ~ poly(x, 10, raw = T), data = data)[, -1]
mod.lasso = cv.glmnet(xmat, y, alpha = 1)
best.lambda = mod.lasso$lambda.min
png("ch6_ex8_e.png")
plot(mod.lasso)
dev.off()
best.model = glmnet(xmat, y, alpha = 1)
predict(best.model, s = best.lambda, type = "coefficients")

## 6_f
y2 = 1 + 2 * x^7 + e
data = data.frame(y = y2, x = x)
mod = regsubsets(y2 ~ poly(x, 10, raw = T), data = data, nvmax = 10)
mod.summary = summary(mod)
which.min(mod.summary$cp)
which.min(mod.summary$bic)
which.max(mod.summary$adjr2)

xmat = model.matrix(y2 ~ poly(x, 10, raw = T), data = data)[, -1]
mod.lasso = cv.glmnet(xmat, y2, alpha = 1)
best.lambda = mod.lasso$lambda.min
best.model = glmnet(xmat, y2, alpha = 1)
predict(best.model, s = best.lambda, type = "coefficients")


##9
##9_a
library(ISLR)
index <- sample(1:nrow(College), nrow(College)/2)
D.train <- College[index,]
D.test <- College[-index,]
##9_b
lm.fit = lm(Apps~., data=D.train)
lm.pred = predict(lm.fit,D.test)
lm.RSS = mean((D.test$Apps - lm.pred)^2)
lm.RSS
##9_c
mat.train = model.matrix(Apps~., data=D.train)
mat.test = model.matrix(Apps~., data=D.test)
lambda = 10 ^ seq(4, -2, length=100)
mod.ridge = cv.glmnet(mat.train, D.train$Apps, alpha=0, lambda=lambda)
lambda.best = mod.ridge$lambda.min
lambda.best
pred.ridge = predict(mod.ridge, newx=mat.test, s=lambda.best)
ridge.RSS = mean((D.test$Apps - pred.ridge)^2)
ridge.RSS
##9_d
mod.lasso = cv.glmnet(mat.train, D.train$Apps, alpha=1, lambda=lambda)
lambda.best = mod.lasso$lambda.min
lambda.best
pred.lasso = predict(mod.lasso, newx=mat.test, s=lambda.best)
lasso.RSS = mean((D.test$Apps - pred.lasso)^2)
lasso.RSS
##9_e
library(pls)
pcr.fit = pcr(Apps~., data=D.train, scale=TRUE, validation="CV")
png("ch6_ex9_e.png")
validationplot(pcr.fit, val.type="MSEP")
dev.off()
pred.pcr = predict(pcr.fit, D.test, ncomp=10)
pcr.RSS = mean((D.test$Apps - pred.pcr)^2)
pcr.RSS
##9_f
pls.fit = plsr(Apps~., data=D.train, scale=TRUE, validation="CV")
png("ch6_ex9_f.png")
validationplot(pls.fit, val.type="MSEP")
dev.off()
pred.pls = predict(pls.fit, D.test, ncomp=10)
pls.RSS = mean((D.test$Apps - pred.pls)^2)
pls.RSS
##9_g
png("ch6_ex9_g.png")
plot(1:5,c(lm.RSS,ridge.RSS,lasso.RSS,pcr.RSS,pls.RSS),ylab="RSS",xlab="Method")
axis(1,at = 1:5,labels=c("lm","Ridge","Lasso","PCR","PLS"))
dev.off()
#10
##10_a
p = 20
n = 1000
x = matrix(rnorm(n * p), n, p)
b = rnorm(p)
b[1] = 0
b[7] = 0
b[9] = 0
b[13] = 0
e = rnorm(p)
y = x %*% b + e
##10_b
index = sample(seq(1000), 100, replace = FALSE)
y.train = y[index, ]
y.test = y[-index, ]
x.train = x[index, ]
x.test = x[-index, ]
D.train = data.frame(x = x.train, y = y.train)
D.test = data.frame(x = x.test, y = y.test)
##10_c
reg = regsubsets(y ~ ., data = D.train, nvmax = p)
errors = rep(0, p)
x_cols = colnames(x, do.NULL = FALSE, prefix = "x.")
for (i in 1:p) {
    coefs = coef(reg, id = i)
    pred = as.matrix(x.train[, x_cols %in% names(coefs)]) %*% coefs[names(coefs) %in% x_cols]
    errors[i] = mean((y.train - pred)^2)
}
png("ch6_ex10_c.png")
plot(errors, ylab = "MSE de training", type = "b")
dev.off()
#10_d
errors = rep(0, p)
for (i in 1:p) {
    coefs = coef(reg, id = i)
    pred = as.matrix(x.test[, x_cols %in% names(coefs)]) %*% coefs[names(coefs) %in% x_cols]
    errors[i] = mean((y.test - pred)^2)
}
png("ch6_ex11_d.png")
plot(errors, ylab = "MSE de test",type="b")
dev.off()
##10_e
which.min(errors)
##10_f
coef(reg, id = 19)
##10_g
errors = rep(0, p)
l = rep(0, p)
sqsm = rep(0, p)
for (i in 1:p) {
    coefs = coef(reg, id = i)
    l[i] = length(coefs) - 1
    sqsm[i] = sqrt(sum((b[x_cols %in% names(coefs)] - coefs[names(coefs) %in% x_cols])^2) +
        sum(b[!(x_cols %in% names(coefs))])^2)
}
png("ch6_ex11_g.png")
plot(x = l, y = sqsm, xlab = "No. de coeficientes", ylab = "Error")
dev.off()
##11
##11_a
library(MASS)
index <- sample(1:nrow(Boston), nrow(Boston)/2)
D.train <- Boston[index,]
D.test <- Boston[-index,]
##Usando Ridge
mat.train = model.matrix(crim~., data=D.train)
mat.test = model.matrix(crim~., data=D.test)
lambda = 10 ^ seq(4, -2, length=100)
mod.ridge = cv.glmnet(mat.train, D.train$crim, alpha=0, lambda=lambda)
png("ch6_ex11_a1.png")
plot(mod.ridge)
dev.off()
lambda.best = mod.ridge$lambda.min
lambda.best
pred.ridge = predict(mod.ridge, newx=mat.test, s=lambda.best)
ridge.RSS = mean((D.test$crim - pred.ridge)^2)
ridge.RSS
##Usando Lasso
mod.lasso = cv.glmnet(mat.train, D.train$crim, alpha=1, lambda=lambda)
png("ch6_ex11_a2.png")
plot(mod.lasso)
dev.off()
lambda.best = mod.lasso$lambda.min
lambda.best
pred.lasso = predict(mod.lasso, newx=mat.test, s=lambda.best)
lasso.RSS = mean((D.test$crim - pred.lasso)^2)
lasso.RSS
##Usando PCR
pcr.fit = pcr(crim~., data=D.train, scale=TRUE, validation="CV")
png("ch6_ex11_a3.png")
validationplot(pcr.fit, val.type="MSEP")
dev.off()
pred.pcr = predict(pcr.fit, D.test, ncomp=10)
pcr.RSS = mean((D.test$crim - pred.pcr)^2)
pcr.RSS
##11_c
coef(mod.ridge)
coef(mod.lasso)
