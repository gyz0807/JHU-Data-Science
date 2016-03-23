<span style="color:red">Lesson 1: Editing Test Variables</span>
===============================================================

### tolower(), toupper()

``` r
# fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
# download.file(fileUrl, destfile = "cameras.csv", method = "curl")
cameraData <- read.csv("cameras.csv")

names(cameraData)
```

    ## [1] "address"      "direction"    "street"       "crossStreet" 
    ## [5] "intersection" "Location.1"

``` r
# Converting all capital letters into lowercases
tolower(names(cameraData))
```

    ## [1] "address"      "direction"    "street"       "crossstreet" 
    ## [5] "intersection" "location.1"

``` r
toupper(names(cameraData))
```

    ## [1] "ADDRESS"      "DIRECTION"    "STREET"       "CROSSSTREET" 
    ## [5] "INTERSECTION" "LOCATION.1"

### strsplit()

Good for automatically splitting variable names "Location.1" is separated by "."

``` r
splitNames <- strsplit(names(cameraData), "\\.")
splitNames
```

    ## [[1]]
    ## [1] "address"
    ## 
    ## [[2]]
    ## [1] "direction"
    ## 
    ## [[3]]
    ## [1] "street"
    ## 
    ## [[4]]
    ## [1] "crossStreet"
    ## 
    ## [[5]]
    ## [1] "intersection"
    ## 
    ## [[6]]
    ## [1] "Location" "1"

### lists

``` r
mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
```

    ## $letters
    ## [1] "A" "b" "c"
    ## 
    ## $numbers
    ## [1] 1 2 3
    ## 
    ## [[3]]
    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    6   11   16   21
    ## [2,]    2    7   12   17   22
    ## [3,]    3    8   13   18   23
    ## [4,]    4    9   14   19   24
    ## [5,]    5   10   15   20   25

### sapply

Applies a function to each element in a vector or list

``` r
splitNames[[6]][1]
```

    ## [1] "Location"

``` r
firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)
```

    ## [1] "address"      "direction"    "street"       "crossStreet" 
    ## [5] "intersection" "Location"

Peer review data
----------------

``` r
# fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
# fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
# download.file(fileUrl1,destfile = "reviews.csv", "curl")
# download.file(fileUrl2, "solutions.csv", "curl")
reviews <- read.csv("reviews.csv"); solutions <- read.csv("solutions.csv")
head(reviews, 2)
```

    ##   id solution_id reviewer_id      start       stop time_left accept
    ## 1  1           3          27 1304095698 1304095758      1754      1
    ## 2  2           4          22 1304095188 1304095206      2306      1

``` r
head(solutions, 2)
```

    ##   id problem_id subject_id      start       stop time_left answer
    ## 1  1        156         29 1304095119 1304095169      2343      B
    ## 2  2        269         25 1304095119 1304095183      2329      C

### sub()

Important parameters: pattern, replacement, x

``` r
names(reviews)
```

    ## [1] "id"          "solution_id" "reviewer_id" "start"       "stop"       
    ## [6] "time_left"   "accept"

Want to remove the underscores from names

``` r
sub("_","",names(reviews))
```

    ## [1] "id"         "solutionid" "reviewerid" "start"      "stop"      
    ## [6] "timeleft"   "accept"

However, sub() can only replace the first "\_"

``` r
testName <- "this_is_a_test"
sub("_","",testName)
```

    ## [1] "thisis_a_test"

### gsub()

``` r
gsub("_", "", testName)
```

    ## [1] "thisisatest"

### grep(), grepl()

Find all of the intersections include "Alameda"

``` r
cameraData$intersection[1:4]
```

    ## [1] Caton Ave & Benson Ave     Caton Ave & Benson Ave    
    ## [3] Wilkens Ave & Pine Heights The Alameda  & 33rd St    
    ## 74 Levels:  & Caton Ave & Benson Ave ... York Rd \n & Gitting Ave

``` r
grep("Alameda", cameraData$intersection)
```

    ## [1]  4  5 36

grepl() will return TRUE or FALSE

``` r
table(grepl("Alameda", cameraData$intersection))
```

    ## 
    ## FALSE  TRUE 
    ##    77     3

``` r
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection), ]
```

### More on grep()

``` r
# Return the value where "Alameda" appears
grep("Alameda", cameraData$intersection, value = TRUE)
```

    ## [1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"   
    ## [3] "Harford \n & The Alameda"

### More useful string functions

``` r
library(stringr)
nchar("Yizhe Ge")
```

    ## [1] 8

``` r
substr("Yizhe Ge", 7, 8)
```

    ## [1] "Ge"

``` r
# Paste everything together without any space
paste0("Yizhe", "Ge")
```

    ## [1] "YizheGe"

``` r
# Trim off any extra spaces at the end of the string
str_trim("Yizhe        ")
```

    ## [1] "Yizhe"

<span style="color:red">Lesson 2: Regular Expressions I</span>
==============================================================

Metacharacters
--------------

### "^"

^i think: get all lines start with "i think"

### "$"

mornings$: get all lines end with "morning"

### Character classes with \[\]

We can list a set of characters we will accept at a given point in the match

\[Bb\]\[Uu\]\[Ss\]\[Hh\]: will match the lines with the word "bush" no matter lower or upper cases

*E.g. ^\[Ii\] am: will match lines start with "I am" no matter lower or upper cases*

\[a-z\] or \[a-zA-Z\]: specifies a range of letters

*E.g. ^\[0-9\]\[a-zA-Z\]: will match "7th", "2nd", "5ft"*

^ also indicates matching characters NOT in the indicated class

*E.g. \[^?.\]$: will match the lines end with neither "?" nor "."*

<span style="color:red">Lesson 3: Regular Expression II</span>
==============================================================

### "."

"." is used to refer to any character

*E.g. 9.11: will match the lines "9-11", "9/11"...*

### "|"

"|" translates to "or"; we can use it to combine two expressions, the subexpressions being called alternatives

*E.g. flood|fire: will match the lines with "firewire", "flood", "floods"...*

*E.g. flood|earthquake|hurricane|coldfire*

The alternative can be real expressions and not just literals

*E.g. ^\[Gg\]ood|\[Bb\]ad: good at the beginning of the line; bad at anywhere*

### "()"

Subexpressions are often contained in parentheses to constrain the alternatives

*E.g. ^(\[Gg\]ood|\[Bb\]ad): both good & bad are at the beginning of the line*

### "?"

The question mark indicates that the indicate expression is optional

*E.g. \[Gg\]eorge( \[Ww\]\\. )? \[Bb\]ush: will match the lines with George Bush with or with not w.*

### "\*" and "+"

The "\*" and "+" signs are metacharacters used to indicate repetition; \* means "any number, including none of the item" and + means "at least one of the item"

*E.g. (.\*): will return something between (), any character repeated by any amount of times*

*E.g. \[0-9\]+ (.\*)\[0-9\]+: will return "number+characters+number", "720 MP battallion, 42nd..."*

### "{}"

{ } are referred to as interval quantifiers; it let us specify the minimum and maximum number of matches of an expression

*E.g. \[Bb\]ush( +\[^ \]+ +){1,5} debate: will match the lines with "space(1 or more) + not space(1 or more) + space(1 or more)"; in "Bush doesn't need these debates", it repeated by 3 times*

Within {}, "m,n" means at least m but not more than n matches

"m" means exactly m matches

"m," means at least m matches

### "()" revised

"()" also can be used to "remember" text matched by the subexpression enclosed

*E.g. +(\[a-zA-Z\]+) + +: will match "night night ", "blah blah "...*

### "\*" is greedy (matches the longest string possible)

*E.g. ^s(.\*)s*

### To make "\*" not that greedy

*E.g. ^s(.\*?)s$*
