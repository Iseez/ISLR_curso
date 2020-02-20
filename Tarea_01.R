### Iván Eduardo Sedeño Jiménez
### R code for ISLR chapter 2.

##Ex.3
setwd("/Users/invitado/Documents/Temas compu")
bias = function(x)350*exp(-0.65*x)
variance = function(x)x^3/3
train_error = function(x)450/(exp(0.7*x-1.5)+1)+15
test_error = function(x)variance(x)+bias(x)+bayes_error(x)+rnorm(1,mean=100,sd=20)
bayes_error = function(x)rnorm(1,mean=100,sd=11)+0*x
png("ch2_ex3.png")
curve(bias, xlim=c(0,10), ylim=c(0,600), xlab="flexibility", ylab="", col=1)  # bias
curve(variance, add = TRUE, col=2)    # variance
curve(train_error, add=TRUE, col=3)   # train error
curve(bayes_error, add=TRUE, col=4)   # irreducible error
curve(test_error, add = TRUE, col=5)  # test error
legend(1,600,legend=c("bias","variance","train error","bayes error","test error"),col=1:5,lwd=1)
dev.off()

 ###Ex.7
#Observations
o1 = c(0,3,0)
o2 = c(2,0,0)
o3 = c(0,1,3)
o4 = c(0,1,2)
o5 = c(-1,0,1)
o6 = c(1,1,1)

#Origin
orig = c(0,0,0)

#All observations together
obs = matrix(c(o1,o2,o3,o4,o5,o6),ncol=3,byrow = T)

#Computing distances
dist = function(x){sqrt(sum((x-orig)^2))}
by(obs,1:nrow(obs),dist,simplify = FALSE)

###EX.8
###a)
getwd()
setwd("./ISLR-master/")
college = read.csv("College.csv")

###b)
rownames(college)=college[,1]
fix(college)
college=college[,-1]
fix(college)

###c)
###.1
summary(college)
###.2
png("ch02_ex08_c_2.png")
pairs(college[,1:10])
dev.off()
###.3
png("ch02_ex08_c_3.png")
plot(college$Outstate~college$Private)
dev.off()
###.4
Elite=rep("No",nrow(college))
Elite[college$Top10perc >50]="Yes"
Elite=as.factor(Elite)
college=data.frame(college ,Elite)

summary(college)
png("ch02_ex08_c_4.png")
plot(college$Outstate~college$Elite)
dev.off()
###.5
png("ch02_ex08_c_5.png")
par(mfrow=c(2,2))
hist(College$Apps, breaks=30, main="Apps")
hist(College$Accept, breaks=25, main="Accept")
hist(College$Enroll, breaks=20, main="Expend")
hist(College$Top10perc, breaks=15, main="Top10perc")
dev.off()
###.6
summary(college)
plot(college)
plot(college[,-c(1:2,8:12,15:19)])
png("ch02_ex08_c_6.png")
par(mfrow=c(2,2))
plot(college$PhD,college$Terminal)
plot(college$Enroll,college$F.Undergrad)
plot(college$Accept,college$Enroll)
plot(college$Top10perc,college$Top25perc)
dev.off()

###EX.9
library(ISLR)
data(Auto)
###We make sure there are no na`s
Auto = na.omit(Auto)
###a)
summary(Auto)
str(Auto)
###b)
lapply(Auto[,1:7],range)
###c)
lapply(Auto[,1:7],mean)
lapply(Auto[,1:7],sd)
###d)
lapply(Auto[-(10:85),1:7],range)
lapply(Auto[-(10:85),1:7],mean)
lapply(Auto[-(10:85),1:7],sd)
###e)
png("ch02_ex09_e.png")
pairs(Auto[,1:7])
dev.off()

###10
###a)
library(MASS)
Boston
###b)
names(Boston)
png("ch02_ex10_b.png")
pairs(Boston)
dev.off()
###c)
library(ggplot2)
library(reshape2)
scatter_crim =ggplot(melt(Boston,id="crim"),aes(x=value,y=crim)) +
    geom_point() +
    facet_wrap(~variable, scales = 'free_x')

png("ch02_ex10_c.png")
scatter_crim
dev.off()
###d)
png("ch02_ex10_d.png")
ggplot(melt(t(Boston)),aes(x=Var2,y=value)) +
geom_point() +
facet_wrap(~Var1, scales = 'free')
dev.off()

###e)
table(Boston$chas)
median(Boston$ptratio)

###g)
min_medv = Boston$medv == min(Boston$medv)
Boston[min_medv,]
sapply(Boston,quantile)

###h)
nrow(Boston[Boston$rm > 7,])
nrow(Boston[Boston$rm > 8,])

rbind(sapply(Boston[Boston$rm > 8,], mean), sapply(Boston, quantile))
