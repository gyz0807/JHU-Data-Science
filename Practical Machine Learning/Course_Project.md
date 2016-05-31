*Abstract*
----------

Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, our goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways.

*Analysis*
----------

### Libraries

``` r
library(caret); library(ggplot2); library(dplyr)
```

### Download and Read Data

``` r
training.url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
test.url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

# download.file(url = training.url, destfile = "training.csv", method = "curl")
# download.file(url = test.url, destfile = "testing.csv", method = "curl")

training.f <- read.csv("training.csv")
testing.f <- read.csv("testing.csv")
dim(training.f); dim(testing.f)
```

    ## [1] 19622   160

    ## [1]  20 160

### Remove zero covariates

Zero covariates are poor predictors because of their low variability, so we remove them from the original dataset to reduce the size of the data.

``` r
zero.cov.index <- nearZeroVar(subset(training.f, select=-classe))
training.processed <- training.f[,-zero.cov.index]
dim(training.processed)
```

    ## [1] 19622   100

### Remove variables with more than 80% of NAs

Variables with more than 80% of NAs can hardly be good predictors, so we remove them from the original dataset to reduce the size of the data.

``` r
na.prop <- apply(is.na(training.processed), 2, function(x){sum(x)/nrow(training.processed)})
na.index <- unname(which(na.prop > 0.8))
training.processed1 <- training.processed[, -na.index]
dim(training.processed1)
```

    ## [1] 19622    59

### Manually unselect some variables

We don't need a user name or a specific time for generalized predictions, so we remove related variables from the data set.

``` r
training.processed2 <- training.processed1 %>%
        select(-(X:num_window))
```

### Create training and testing data sets

``` r
inTrain <- createDataPartition(training.processed2$classe, p=0.7, list=FALSE)
training <- training.processed2[inTrain, ]
testing <- training.processed2[-inTrain, ]
dim(training); dim(testing)
```

    ## [1] 13737    53

    ## [1] 5885   53

### Preprocess using PCA

We use PCA to find out weighted combinations of predictors that can capture 95% of the variance. In this way, we can reduce the number of predictors and noise.

``` r
data.prepro <- preProcess(select(training, -classe), method="pca")
data.prepro
```

    ## Created from 13737 samples and 52 variables
    ## 
    ## Pre-processing:
    ##   - centered (52)
    ##   - ignored (0)
    ##   - principal component signal extraction (52)
    ##   - scaled (52)
    ## 
    ## PCA needed 26 components to capture 95 percent of the variance

``` r
trainPC <- predict(data.prepro, training)
```

### Apply Random Forest Model

We choose to apply random forest model on the preprocessed data

``` r
mod.fit1 <- train(classe ~ ., data=trainPC, method="rf",
                  trControl=trainControl(method="cv", number=3))
mod.fit1
```

    ## Random Forest 
    ## 
    ## 13737 samples
    ##    26 predictor
    ##     5 classes: 'A', 'B', 'C', 'D', 'E' 
    ## 
    ## No pre-processing
    ## Resampling: Cross-Validated (3 fold) 
    ## Summary of sample sizes: 9158, 9158, 9158 
    ## Resampling results across tuning parameters:
    ## 
    ##   mtry  Accuracy   Kappa    
    ##    2    0.9586518  0.9476811
    ##   14    0.9567591  0.9452883
    ##   26    0.9517362  0.9389291
    ## 
    ## Accuracy was used to select the optimal model using  the largest value.
    ## The final value used for the model was mtry = 2.

### Check the accuracy on testing data

``` r
testPC <- predict(data.prepro, testing)
pred1 <- predict(mod.fit1, testPC)
confusionMatrix(pred1, testPC$classe)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction    A    B    C    D    E
    ##          A 1660   21    1    3    0
    ##          B    5 1097   18    2    5
    ##          C    6   21  999   35    9
    ##          D    1    0    8  923    3
    ##          E    2    0    0    1 1065
    ## 
    ## Overall Statistics
    ##                                           
    ##                Accuracy : 0.976           
    ##                  95% CI : (0.9718, 0.9798)
    ##     No Information Rate : 0.2845          
    ##     P-Value [Acc > NIR] : < 2.2e-16       
    ##                                           
    ##                   Kappa : 0.9697          
    ##  Mcnemar's Test P-Value : 2.068e-07       
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: A Class: B Class: C Class: D Class: E
    ## Sensitivity            0.9916   0.9631   0.9737   0.9575   0.9843
    ## Specificity            0.9941   0.9937   0.9854   0.9976   0.9994
    ## Pos Pred Value         0.9852   0.9734   0.9336   0.9872   0.9972
    ## Neg Pred Value         0.9967   0.9912   0.9944   0.9917   0.9965
    ## Prevalence             0.2845   0.1935   0.1743   0.1638   0.1839
    ## Detection Rate         0.2821   0.1864   0.1698   0.1568   0.1810
    ## Detection Prevalence   0.2863   0.1915   0.1818   0.1589   0.1815
    ## Balanced Accuracy      0.9928   0.9784   0.9795   0.9775   0.9918

### Quiz (19/20)

``` r
testing.processed2 <- select(testing.f, -zero.cov.index) %>%
        select(-na.index) %>%
        select(-(X:num_window))
testPC.f <- predict(data.prepro, testing.processed2)
predict(mod.fit1, testPC.f)
```

    ##  [1] B A B A A B D B A A B C B A E E A B B B
    ## Levels: A B C D E
