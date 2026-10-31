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
#diagnostic of model 2
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
  
##now we will plot the full model with all predictors and compare 
##it with Ridge and lasso regression in terms of test MSE
# we will first separarte test and train data set 

# BOSTON HOUSING DATASET
# Comparison of OLS, Ridge Regression and Lasso Regression
# Evaluation metric: Test Mean Squared Error (MSE)



library(ISLR2)
library(glmnet)

data("Boston")

# Inspect the dataset
dim(Boston)
names(Boston)
summary(Boston)


# 2. SPLIT DATA INTO TRAINING AND TESTING SETS (80:20)


set.seed(18)

n <- nrow(Boston)

train <- sample(seq_len(n), floor(0.80 * n))
test <- setdiff(seq_len(n), train)

train.mat <- Boston[train, ]
test.mat  <- Boston[test, ]

# Response variable
y <- Boston$medv
y.test <- y[test]

# Verify dimensions
dim(train.mat)
dim(test.mat)
length(train)
length(test)


# 3. OLS REGRESSION


# Fit OLS using training data only
full_OLS <- lm(medv ~ ., data = Boston, subset = train)


summary(full_OLS)

# Predict on test data
ols_pred <- predict(full_OLS, newdata = test.mat)

# Calculate test MSE
ols_MSE <- mean((y.test - ols_pred)^2)

cat("OLS Test MSE:", ols_MSE, "\n")


# 4. PREPARE PREDICTOR MATRIX FOR RIDGE AND LASSO


# Create predictor matrix, excluding the intercept
x <- model.matrix(medv ~ ., data = Boston)[, -1, drop = FALSE]

# Check dimensions
dim(Boston)  # 506 rows, 14 columns
dim(x)       # 506 rows, 12 predictor columns
length(y)    # 506 responses

# Lambda grid
grid <- 10^seq(10, -2, length = 100)


# 5. RIDGE REGRESSION


# alpha = 0 means Ridge Regression
set.seed(18)

cv_ridge <- cv.glmnet(
  x = x[train, , drop = FALSE],
  y = y[train],
  alpha = 0,
  lambda = grid,
  nfolds = 10,
  thresh = 1e-12
)

# Plot cross-validation results
plot(cv_ridge)

# Optimal lambda
best_lambda_ridge <- cv_ridge$lambda.min

cat("Optimal Ridge Lambda:", best_lambda_ridge, "\n")

# Predict test responses using the selected lambda
ridge_pred <- predict(
  cv_ridge,
  newx = x[test, , drop = FALSE],
  s = "lambda.min"
)

# Ridge test MSE
ridge_MSE <- mean((y.test - as.numeric(ridge_pred))^2)

cat("Ridge Test MSE:", ridge_MSE, "\n")


# 6. LASSO REGRESSION


# alpha = 1 means Lasso Regression
set.seed(18)

cv_lasso <- cv.glmnet(
  x = x[train, , drop = FALSE],
  y = y[train],
  alpha = 1,
  lambda = grid,
  nfolds = 10,
  thresh = 1e-12
)

# Plot cross-validation results
plot(cv_lasso)

# Optimal lambda
best_lambda_lasso <- cv_lasso$lambda.min


cat("Optimal Lasso Lambda:", best_lambda_lasso, "\n")

# Predict test responses using the selected lambda
lasso_pred <- predict(
  cv_lasso,
  newx = x[test, , drop = FALSE],
  s = "lambda.min"
)

# Lasso test MSE
lasso_MSE <- mean((y.test - as.numeric(lasso_pred))^2)

cat("Lasso Test MSE:", lasso_MSE, "\n")


# 7. COMPARE THE THREE MODELS


results <- data.frame(
  Model = c("OLS", "Ridge", "Lasso"),
  Optimal_Lambda = c(
    NA,
    best_lambda_ridge,
    best_lambda_lasso
  ),
  Test_MSE = c(
    ols_MSE,
    ridge_MSE,
    lasso_MSE
  )
)

print(results)

# Identify the model with the lowest test MSE
best_model <- results$Model[which.min(results$Test_MSE)]

cat("\nBest model based on test MSE:", best_model, "\n")


# 8. VISUAL COMPARISON OF TEST MSE


barplot(
  results$Test_MSE,
  names.arg = results$Model,
  main = "Comparison of Test MSE",
  xlab = "Regression Model",
  ylab = "Test Mean Squared Error",
  col = "lightblue"
)


# 9. COMPARE REGRESSION COEFFICIENTS


# OLS coefficients
cat("\nOLS Coefficients:\n")
print(coef(full_OLS))

# Ridge coefficients at optimal lambda
cat("\nRidge Coefficients:\n")
print(coef(cv_ridge, s = "lambda.min"))

# Lasso coefficients at optimal lambda
cat("\nLasso Coefficients:\n")
print(coef(cv_lasso, s = "lambda.min"))

# Count the nonzero Lasso coefficients, excluding intercept
lasso_coef <- as.matrix(coef(cv_lasso, s = "lambda.min"))

nonzero_lasso <- sum(lasso_coef[-1, 1] != 0)

cat("\nNumber of nonzero Lasso predictor coefficients:",
    nonzero_lasso, "out of", ncol(x), "\n")
