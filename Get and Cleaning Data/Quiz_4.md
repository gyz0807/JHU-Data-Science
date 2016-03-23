### Question 1

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv>

and load the data into R. The code book, describing the variable names is here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf>

Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

``` r
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
#               "housing.csv", "curl")
housingData <- read.csv("housing.csv")
list <- strsplit(names(housingData), "wgtp")
list[[123]]
```

    ## [1] ""   "15"

### Question 2

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv>

Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

Original data sources:

<http://data.worldbank.org/data-catalog/GDP-ranking-table>

``` r
library(dplyr)
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
#               "GDP.csv", "curl")
GDPdata <- read.csv("GDP.csv", skip = 4, nrows = 231)
numbers <- GDPdata %>%
        tbl_df() %>%
        filter(X.1 <= 190) %>%
        select(X.4)
numbers <- as.numeric(as.character(gsub(",", "", numbers$X.4)))
mean(numbers[!is.na(numbers)])
```

    ## [1] 377652.4

### Question 3

In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

``` r
GDPdata <- GDPdata %>%
        tbl_df()
grep("^United", GDPdata$X.3)
```

    ## [1]  1  6 32

### Question 4

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv>

Load the educational data from this data set:

<https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv>

Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

Original data sources:

<http://data.worldbank.org/data-catalog/GDP-ranking-table>

<http://data.worldbank.org/data-catalog/ed-stats>

``` r
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "education.csv", "curl")
educationData <- read.csv("Education.csv")
names(GDPdata)[1] <- "CountryCode"
GDPdata <- GDPdata %>%
        filter(!is.na(X.1)) %>%
        select(CountryCode:X.4)
merged <- merge(GDPdata, educationData)
merged <- merged %>%
        tbl_df()
length(grep("end: June", merged$Special.Notes))
```

    ## [1] 13

### Question 5

You can use the quantmod (<http://www.quantmod.com/>) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.

``` r
library(xts); library(zoo); library(quantmod); library(lubridate)
amzn <- getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn)

ndays(amzn['2012'])
```

    ## [1] 250

``` r
dates <- index(amzn['2012'])
sum(wday(dates) == 2)
```

    ## [1] 47
