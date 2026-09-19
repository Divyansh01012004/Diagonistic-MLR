#IMPORTING THE DATASET
library(ISLR2)
Boston
sum(is.na(Boston))
is.na(Boston)
Boston$age[is.na(Boston$age)]=mean(Boston$age,na.rm=TRUE)
sum(is.na(Boston))
#we have removed all na values 
#now consider various regression model with 4 predictors and choose one with best R^2 prediction
#problem:we are plotting house rate medv as response and crim,rm,dis and rad
#we will have 15 models to check and we will select the one with best R^2 adjusted(in terms of fitting)
lmfit1=lm(medv~crim+rm+rad+dis,Boston)
lmfit2=lm(medv~crim+rm+rad,Boston)
lmfit3=lm(medv~crim+rm+dis,Boston)
lmfit4=lm(medv~crim+rad+dis,Boston)
lmfit5=lm(medv~rm+rad+dis,Boston)
lmfit6=lm(medv~crim+rm,Boston)
lmfit7=lm(medv~crim+rad,Boston)
lmfit8=lm(medv~crim+dis,Boston)
lmfit9=lm(medv~rm+rad,Boston)
lmfit10=lm(medv~rm+dis,Boston)
lmfit11=lm(medv~rad+dis,Boston)
lmfit12=lm(medv~crim,Boston)
lmfit13=lm(medv~rm,Boston)
lmfit14=lm(medv~rad,Boston)
lmfit15=lm(medv~dis,Boston)
lmfit16=lm(medv~1,Boston)
summary(lmfit1)
summary(lmfit2)
summary(lmfit3)
summary(lmfit4)
summary(lmfit5)
summary(lmfit6)
summary(lmfit7)
summary(lmfit8)
summary(lmfit9)
summary(lmfit10)
summary(lmfit11)
summary(lmfit12)
summary(lmfit13)
summary(lmfit14)
summary(lmfit15)
# model 2 have largest R^2 adjusted value so we will perform diagnostic on this model
#diagnostic of model 6
# 1.influential points (Outliers)
#we will check this with the help of cooks distance
cook=cooks.distance(lmfit2)
for(i in 1:506)
{
  if(cook[i]>4/502)
  {
    print(cook[i])
  }
}
#we will check this with the help of df fits
df_fit=dffits(lmfit2)
for(i in 1:506)
{
  if(df_fit[i]>4/502)
  {
    print(df_fit[i])
  }
}
#2.now we will check whether  errors are uncorrelated or not with the help of DW test
library(DescTools)
DurbinWatsonTest(lmfit2,alternative="less")
DurbinWatsonTest(lmfit2,alternative="greater")
DurbinWatsonTest(lmfit2,alternative="two.sided")

# errors are positively correlated

# 3. now we will check if data has hetroscadasticity or not 
plot(lmfit2$fitted.values,lmfit$residuals,xlab="Fitted values",ylab="Residuals")
# we can see that our data is homoscadastic 

# 4.now we will check normality assumption i.e whether residuals are normally distributed or not 
qqnorm(rstudent(lmfit2))
qqline(rstudent(lmfit2),col="red")
shapiro.test(rstudent(lmfit1))

# residuals are not normally distributed 

# 5.let us check linearity assumption
library(car)
avPlots(lmfit2)
#linearity assumption is valid as we are getting slope in each graph

#6. let us check multicollinearity
library(mctest)
imcdiag(lmfit2,method="VIF")

#multicollinearity is not present in this model





