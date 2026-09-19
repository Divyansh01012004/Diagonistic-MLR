# Boston Housing Price Prediction using Multiple Linear Regression

## Project Overview

This project analyzes the Boston Housing dataset using multiple linear
regression in R. The objective is to model the median value of houses
(`medv`) using different combinations of predictor variables.

## Dataset

The Boston Housing dataset is obtained from the `ISLR2` package.

### Response Variable
- `medv` - Median value of owner-occupied homes

### Predictor Variables
- `crim` - Per capita crime rate
- `rm` - Average number of rooms per dwelling
- `rad` - Index of accessibility to radial highways
- `dis` - Weighted distance to employment centers

## Methodology

1. Load and inspect the Boston dataset.
2. Check for missing values.
3. Replace the missing value in `age` with its mean.
4. Construct multiple regression models using different combinations
   of predictors.
5. Compare models using Adjusted R².
6. Select the model with the highest Adjusted R².
7. Perform regression diagnostics on the selected model.

## Regression Diagnostics

The selected model is evaluated using:

- Cook's Distance – influential observations
- DFFITS – influence of observations on fitted values
- Durbin-Watson Test – autocorrelation of residuals
- Residual vs Fitted Plot – homoscedasticity
- Q-Q Plot and Shapiro-Wilk Test – normality of residuals
- Added-Variable Plots – linearity
- Variance Inflation Factor (VIF) – multicollinearity

## Tools & Libraries

- R
- ISLR2
- DescTools
- car
- mctest

## Key Findings

The analysis compares 16 regression models and selects a model based on
Adjusted R². The selected model is subsequently examined using multiple
regression diagnostic techniques to assess whether the assumptions of
linear regression are satisfied.