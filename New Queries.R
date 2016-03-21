DataUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(DataUrl, "Restaurant.csv", method = "curl")
restData <- read.csv("Restaurant.csv")

# Creating sequences
seq(1, 10, by = 2)
seq(1, 10, length = 3)
x <- c(1, 3, 8, 25, 100); seq(along = x)

# Creating binary variables
restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)

# Creating categorical variables
restData$zipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)

# Easier cutting
library(Hmisc)
restData$zipGroups <- cut2(restData$zipCode, g=4)
table(restData$zipGroups)

# Creating factor variables
restData$zcf <- factor(restData$zipCode)

# Levels of factor variables
yesno <- sample(c("yes", "no"), size = 10, replace = TRUE)
yesnofac <- factor(yesno, levels = c("yes", "no"))
relevel(yesnofac, ref = "yes")
as.numeric(yesnofac)  #  [1] 2 1 1 1 1 1 1 2 2 2

# Common transforms
abs(x)
sqrt(x)
ceiling(x)
floor(x)
round(x, digits = n)
signif(x, digits = n)
cos(x)
log(x)
log2(x); log10(x)
exp(x)

# Merging Data
merge(data1, data2, by.x = "", by.y = "", all = TRUE)


##################################### Exercise

# Reshaping Data
library(dplyr); library(tidyr)
head(mtcars)
mtcars$carname <- rownames(mtcars)
mtcars <- tbl_df(mtcars)
Melt <- mtcars %>%
        select(carname, gear, cyl, mpg, hp) %>%
        gather(variable, value, mpg, hp)
View(Melt)

# Casting data frames
cydData <- mtcars %>%
        filter(cyl %in% c(4,6,8)) %>%
        group_by(cyl) %>%
        summarise(mpg = mean(mpg), hp = mean(hp))


# Averaging values
head(InsectSprays)
with(InsectSprays, tapply(count, spray, sum))

# Split, apply, combine
spIns <- split(InsectSprays$count, InsectSprays$spray)
sprCount <- lapply(spIns, sum)
unlist(sprCount)
sapply(spIns, sum)

# dplyr
InsectSprays %>%
        group_by(spray) %>%
        summarize(sum = sum(count))



