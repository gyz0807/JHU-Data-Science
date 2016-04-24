### Question 1

A pharmaceutical company is interested in testing a potential blood pressure lowering medication. Their first examination considers only subjects that received the medication at baseline then two weeks later. The data are as follows (SBP in mmHg)

Subject Baseline Week 2
1 140 132
2 138 135
3 150 151
4 148 146
5 135 130

Consider testing the hypothesis that there was a mean reduction in blood pressure? Give the P-value for the associated two sided T test.

(Hint, consider that the observations are paired.)

``` r
wk1 <- c(140, 138, 150, 148, 135)
wk2 <- c(132, 135, 151, 146, 130)
t.test(wk2, wk1, alternative = "two.sided", paired = TRUE)$p.value
```

    ## [1] 0.08652278

### Question 2

A sample of 9 men yielded a sample average brain volume of 1,100cc and a standard deviation of 30cc. What is the complete set of values of μ0 that a test of H0:μ=μ0 would fail to reject the null hypothesis in a two sided 5% Students t-test?

``` r
1100 + c(-1,1)*qt(0.975,8)*30/3
```

    ## [1] 1076.94 1123.06

### Question 3

Researchers conducted a blind taste test of Coke versus Pepsi. Each of four people was asked which of two blinded drinks given in random order that they preferred. The data was such that 3 of the 4 people chose Coke. Assuming that this sample is representative, report a P-value for a test of the hypothesis that Coke is preferred to Pepsi using a one sided exact test.

``` r
binom.test(3, 4, p = 0.5, alternative = "greater")$p.value
```

    ## [1] 0.3125

### Question 4

Infection rates at a hospital above 1 infection per 100 person days at risk are believed to be too high and are used as a benchmark. A hospital that had previously been above the benchmark recently had 10 infections over the last 1,787 person days at risk. About what is the one sided P-value for the relevant test of whether the hospital is below the standard?

``` r
ppois(10, 0.01*1787)
```

    ## [1] 0.03237153

### Question 5

Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo. Subjects’ body mass indices (BMIs) were measured at a baseline and again after having received the treatment or placebo for four weeks. The average difference from follow-up to the baseline (followup - baseline) was −3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group. Does the change in BMI appear to differ between the treated and placebo groups? Assuming normality of the underlying data and a common population variance, give a pvalue for a two sided t test.

``` r
n1 <- 9
n2 <- 9
x1 <- -3
x2 <- 1
s1 <- 1.5
s2 <- 1.8
se <- sqrt(((n1-1)*s1^2 + (n2-1)*s2^2)/(n1+n2-2))
t <- (x1 - x2) / (se * sqrt(1/n1+1/n2))
pt(t, n1+n2-2) * 2
```

    ## [1] 0.0001025174

### Question 6

Brain volumes for 9 men yielded a 90% confidence interval of 1,077 cc to 1,123 cc. Would you reject in a two sided 5% hypothesis test of

H0:μ=1,078?

``` r
# 1077 = x - qt(0.95,8)*se
# 1123 = x + qt(0.95,8)*se
x <- (1123+1077)/2
# 46 = qt(0.95,8)*se + qt(0.95,8)*se
se <- 46 / (qt(0.95,8)*2)
q = (x - 1078)/se
pt(q, df = 8, lower.tail = FALSE)
```

    ## [1] 0.05658751

Since it's bigger than 0.05, we fail to reject H0.

### Question 7

Researchers would like to conduct a study of 100 healthy adults to detect a four year mean brain volume loss of .01 mm3. Assume that the standard deviation of four year volume loss in this population is .04 mm3. About what would be the power of the study for a 5% one sided test versus a null hypothesis of no volume loss?

``` r
# H0: µ = 0
n <- 100
sd <- 0.04
mu0 <- 0
mua <- 0.01
alpha <- 0.05

power.t.test(n=n, delta=mua-mu0, sd=sd, type = "one.sample", alternative = "one.sided")$power
```

    ## [1] 0.7989855

### Question 8

Researchers would like to conduct a study of n healthy adults to detect a four year mean brain volume loss of .01 mm3. Assume that the standard deviation of four year volume loss in this population is .04 mm3. About what would be the value of n needed for 90% power of type one error rate of 5% one sided test versus a null hypothesis of no volume loss?

``` r
mu0 <- 0
mua <- 0.01
sd <- 0.04
power <- 0.9

power.t.test(delta = mua-mu0, sd=sd, power = power, type = "one.sample", alternative = "one.sided")$n
```

    ## [1] 138.3856

### Question 9

As you increase the type one error rate, α, what happens to power?

Answer: You will get larger power, since more likely to reject H0.
