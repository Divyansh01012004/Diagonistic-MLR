# Boston Housing Price Prediction: OLS, Ridge and Lasso Regression

## Project Overview

This project uses the Boston Housing dataset from the `ISLR2` package in R to explore the factors associated with median house values and compare different regression techniques.

The project has two main objectives:

1. **Multiple Linear Regression and Model Selection:** Construct regression models using different combinations of four selected predictors, compare them using adjusted \(R^2\), and perform diagnostic checks on the selected model.
2. **Regularized Regression Comparison:** Fit Ordinary Least Squares (OLS), Ridge Regression, and Lasso Regression models using all available predictors. Compare their predictive performance using test Mean Squared Error (MSE), with the regularization parameters selected through cross-validation.

The response variable throughout the project is `medv`, representing the median value of owner-occupied homes in thousands of US dollars.

## Dataset

The Boston Housing dataset is provided by the `ISLR2` R package.

- **Observations:** 506
- **Variables:** 14 columns, including the response variable
- **Response variable:** `medv`
- **Predictor variables:** 13 housing, environmental, socioeconomic, and geographical attributes

### Response Variable

- `medv` — Median value of owner-occupied homes, measured in thousands of US dollars.

### Predictors Used in the Initial Model Selection

- `crim` — Per-capita crime rate by town.
- `rm` — Average number of rooms per dwelling.
- `rad` — Index of accessibility to radial highways.
- `dis` — Weighted mean distance to five Boston employment centres.

The second part of the project uses all 13 available predictors to model `medv`.

## Project Methodology

### 1. Data Loading and Inspection

- Load the dataset using `ISLR2`.
- Examine its dimensions, variable names, summary statistics, and missing values.
- Investigate missing observations and apply an appropriate treatment if necessary.

### 2. Multiple Linear Regression and Model Selection

Multiple linear regression models are fitted using different combinations of the four selected predictors: `crim`, `rm`, `rad`, and `dis`.

The analysis considers all 16 possible subsets, including the intercept-only model.

The models are compared using **adjusted \(R^2\)** to identify the model with the highest adjusted explanatory power while accounting for the number of predictors.

### 3. Regression Diagnostics

The selected subset regression model is examined using several diagnostic techniques to assess the assumptions of linear regression.

- **Cook's Distance:** Identifies potentially influential observations.
- **DFFITS:** Examines the influence of individual observations on fitted values.
- **Durbin–Watson Test:** Checks for first-order autocorrelation in residuals.
- **Residuals vs. Fitted Plot:** Helps assess non-linearity and non-constant error variance.
- **Q–Q Plot and Shapiro–Wilk Test:** Examine the normality of residuals.
- **Added-Variable Plots:** Help assess the contribution and linear relationship of predictors conditional on the other predictors.
- **Variance Inflation Factor (VIF):** Evaluates potential multicollinearity among predictors.

These diagnostic results help identify possible departures from model assumptions and observations requiring further investigation.

### 4. Full-Predictor OLS Model

An OLS regression model is fitted using all available predictors, with an 80:20 training–test split.

The model is trained on the training data, and predictions are generated for the held-out test data.

Its predictive performance is evaluated using test MSE.

### 5. Ridge Regression

Ridge regression introduces an \(L_2\) penalty to shrink regression coefficients and help control model complexity.

The model is fitted using the `glmnet` package with `alpha = 0`.

- A grid of candidate regularization parameters, \(\lambda\), is considered.
- Ten-fold cross-validation on the training set selects the value of \(\lambda\) that minimizes cross-validation MSE.
- The fitted model predicts house values in the test set.
- Test MSE is calculated to evaluate predictive performance.

### 6. Lasso Regression

Lasso regression introduces an \(L_1\) penalty that shrinks coefficients and can set some coefficients exactly to zero.

The model is fitted using `glmnet` with `alpha = 1`.

- Ten-fold cross-validation selects the regularization parameter, \(\lambda\).
- Predictions are generated for the same held-out test observations.
- Test MSE is calculated for comparison with OLS and Ridge.
- The estimated coefficients are examined to identify predictors retained or excluded by Lasso.

### 7. Model Comparison

The three full-predictor models are compared using a common test set.

| Model | Main objective | Evaluation |
|---|---|---|
| OLS | Minimize residual sum of squares without regularization | Test MSE |
| Ridge | Shrink coefficients using an \(L_2\) penalty | Optimal \(\lambda\) and test MSE |
| Lasso | Shrink coefficients and perform variable selection using an \(L_1\) penalty | Optimal \(\lambda\), nonzero coefficients, and test MSE |

The model with the lowest test MSE is identified as the best-performing model among the three for the chosen data split.

## Tools and Libraries

- **R and RStudio** — Statistical computing and analysis.
- **ISLR2** — Boston Housing dataset.
- **glmnet** — Ridge and Lasso regression with cross-validation.
- **DescTools** — Durbin–Watson testing.
- **car** — Added-variable plots and regression diagnostics.
- **mctest** — Multicollinearity diagnostics.

## Key Findings

The project investigates two complementary aspects of regression analysis:

1. **Model selection and diagnostics:** Compares subsets of four selected predictors using adjusted \(R^2\), then investigates the assumptions and potential weaknesses of the selected model.
2. **Predictive performance and regularization:** Compares full-predictor OLS, Ridge, and Lasso models using test MSE, with cross-validation used to tune the regularization parameters.

The final comparison illustrates the trade-off between fitting a regression model, controlling coefficient magnitudes, selecting predictors, and predicting unseen observations.

The best-performing model is determined from the actual test MSE results rather than assuming in advance that one regression method will outperform the others.

## How to Run the Project

1. Install R and RStudio.
2. Install the required packages.
3. Open the project script in RStudio.
4. Run the script from beginning to end.
5. Examine the regression summaries, diagnostic plots, cross-validation plots, selected regularization parameters, coefficient estimates, and final test MSE comparison.

**Note:** The Boston Housing dataset is historical and is intended here for statistical learning and regression analysis, not for estimating present-day Boston property prices.
