### Question 1

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv>

and load the data into R. The code book, describing the variable names is here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf>

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.

which(agricultureLogical)

What are the first 3 values that result?

``` r
# Load Data
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
#               "SurveyData.csv", method = "curl")
SurveyData <- read.csv("SurveyData.csv")

# Get the required data
agricultureLogical <- SurveyData$ACR == 3 & SurveyData$AGS == 6
which(agricultureLogical)[1:3]
```

    ## [1] 125 238 262

### Question 2

Using the jpeg package read in the following picture of your instructor into R

<https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg>

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

``` r
library(jpeg)

# Load data
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
#               "Picture.jpg", method = "curl")
pic <- readJPEG("Picture.jpg", native = TRUE)
quantile(pic, probs = c(0.3, 0.8))
```

    ##       30%       80% 
    ## -15259150 -10575416

### Question 3

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv>

Load the educational data from this data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv>

Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

Original data sources:

<http://data.worldbank.org/data-catalog/GDP-ranking-table>

<http://data.worldbank.org/data-catalog/ed-stats>

``` r
library(dplyr)
# Downloading data
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
#               "Product.csv", method = "curl")
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "Education.csv", method = "curl")

# Loading product data
product <- "Product.csv" %>%
        read.csv(skip = 4, nrows = 231) %>%
        tbl_df() %>%
        select(1:5) %>%
        filter(!is.na(X.1))
names(product)[1:2] <- c("CountryCode", "Rank")

# Loading education data
education <- read.csv("Education.csv")

# Merging
mergedData <- merge(product, education)
nrow(mergedData)
```

    ## [1] 189

``` r
mergedData1 <- tbl_df(mergedData)
descData <- mergedData1 %>%
        arrange(desc(Rank))
as.character(descData$Long.Name)[13]
```

    ## [1] "St. Kitts and Nevis"

### Question 4

What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

``` r
mergedData1 %>%
        filter(Income.Group == "High income: OECD" | 
                       Income.Group == "High income: nonOECD") %>%
        group_by(Income.Group) %>%
        summarise(AverageGDP = mean(Rank))
```

    ## Source: local data frame [2 x 2]
    ## 
    ##           Income.Group AverageGDP
    ##                 (fctr)      (dbl)
    ## 1 High income: nonOECD   91.91304
    ## 2    High income: OECD   32.96667

### Question 5

Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

``` r
library(grid); library(lattice); library(survival); library(Formula); library(ggplot2); library(Hmisc)

quantiles <- cut2(mergedData1$Rank, g = 5)
table(quantiles, mergedData1$Income.Group)
```

    ##            
    ## quantiles      High income: nonOECD High income: OECD Low income
    ##   [  1, 39)  0                    4                18          0
    ##   [ 39, 77)  0                    5                10          1
    ##   [ 77,115)  0                    8                 1          9
    ##   [115,154)  0                    5                 1         16
    ##   [154,190]  0                    1                 0         11
    ##            
    ## quantiles   Lower middle income Upper middle income
    ##   [  1, 39)                   5                  11
    ##   [ 39, 77)                  13                   9
    ##   [ 77,115)                  12                   8
    ##   [115,154)                   8                   8
    ##   [154,190]                  16                   9
