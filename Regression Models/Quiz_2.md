------------------------------------------------------------------------

Question 1
----------

Consider the following data with x as the predictor and y as as the outcome.

x &lt;- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62) y &lt;- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

Give a P-value for the two sided hypothesis test of whether β1 from a linear regression model is 0 or not.

``` r
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
fit <- lm(y ~ x)
summary(fit)$coef[2, 4]
```

    ## [1] 0.05296439

Question 2
----------

Consider the previous problem, give the estimate of the residual standard deviation.

``` r
m <- summary(fit)
m$sigma
```

    ## [1] 0.2229981

Question 3
----------

In the 𝚖𝚝𝚌𝚊𝚛𝚜 data set, fit a linear regression model of weight (predictor) on mpg (outcome). Get a 95% confidence interval for the expected mpg at the average weight. What is the lower endpoint?

``` r
data(mtcars)
fit <- lm(mpg ~ wt, data = mtcars)
newdata <- data.frame(wt = mean(mtcars$wt))
predict(fit, newdata = newdata, interval = "confidence")
```

    ##        fit      lwr      upr
    ## 1 20.09062 18.99098 21.19027

Question 4
----------

Refer to the previous question. Read the help file for 𝚖𝚝𝚌𝚊𝚛𝚜. What is the weight coefficient interpreted as?

``` r
# The estimated expected change in mpg per 1,000 lb increase in weight.
```

Question 5
----------

Consider again the 𝚖𝚝𝚌𝚊𝚛𝚜 data set and a linear regression model with mpg as predicted by weight (1,000 lbs). A new car is coming weighing 3000 pounds. Construct a 95% prediction interval for its mpg. What is the upper endpoint?

``` r
y <- mtcars$mpg
x <- mtcars$wt
fit <- lm(y ~ x)
newdata <- data.frame(x = 3)
predict(fit, newdata = newdata, interval = "prediction")
```

    ##        fit      lwr      upr
    ## 1 21.25171 14.92987 27.57355

Question 6
----------

Consider again the 𝚖𝚝𝚌𝚊𝚛𝚜 data set and a linear regression model with mpg as predicted by weight (in 1,000 lbs). A “short” ton is defined as 2,000 lbs. Construct a 95% confidence interval for the expected change in mpg per 1 short ton increase in weight. Give the lower endpoint.

``` r
data("mtcars")
y <- mtcars$mpg
x <- mtcars$wt/2
n <- nrow(mtcars)

fit <- lm(y ~ x)
coef.fit <- summary(fit)$coef
coef.fit[2,1] + c(-1, 1)*coef.fit[2,2]*qt(0.975, fit$df.residual)
```

    ## [1] -12.97262  -8.40527

Question 7
----------

If my X from a linear regression is measured in centimeters and I convert it to meters what would happen to the slope coefficient?

``` r
# It would get multiplied by 100.
```

Question 8
----------

I have an outcome, Y, and a predictor, X and fit a linear regression model with Y=β0+β1X+ϵ to obtain β^0 and β^1. What would be the consequence to the subsequent slope and intercept if I were to refit the model with a new regressor, X+c for some constant, c?

``` r
# The new intercept would be β^0-cβ^1
```

Question 9
----------

Refer back to the mtcars data set with mpg as an outcome and weight (wt) as the predictor. About what is the ratio of the the sum of the squared errors, ∑ni=1(Yi−Y^i)2 when comparing a model with just an intercept (denominator) to the model with the intercept and slope (numerator)?

``` r
data("mtcars")
y <- mtcars$mpg
x <- mtcars$wt

# Model with the intercept and slope (numerator)
fit <- lm(y ~ x)
num <- deviance(fit)

# Model with just an intercept (denominator)
fit1 <- lm(y ~ 1)
den <- deviance(fit1)

num/den
```

    ## [1] 0.2471672

Question 10
-----------

Do the residuals always have to sum to 0 in linear regression?

``` r
# If an intercept is included, then they will sum to 0.
```
