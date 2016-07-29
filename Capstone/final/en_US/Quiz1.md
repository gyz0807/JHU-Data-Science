Question 1
----------

The en\_US.blogs.txt file is how many megabytes?
Answer: 200

Question 2
----------

The en\_US.twitter.txt has how many lines of text?

``` r
library(readr)
library(stringr)

twitter <- readLines("en_US.twitter.txt")
news <- readLines("en_US.news.txt")
blogs <- readLines("en_US.blogs.txt")
```

``` r
length(twitter)
```

    ## [1] 2360148

Question 3
----------

What is the length of the longest line seen in any of the three en\_US data sets?

``` r
max(c(max(str_count(twitter)), max(str_count(news)), max(str_count(blogs))))
```

    ## [1] 40833

Question 4
----------

In the en\_US twitter data set, if you divide the number of lines where the word "love" (all lowercase) occurs by the number of lines the word "hate" (all lowercase) occurs, about what do you get?

``` r
length(grep("love", twitter)) / length(grep("hate", twitter))
```

    ## [1] 4.108592

Question 5
----------

The one tweet in the en\_US twitter data set that matches the word "biostats" says what?

``` r
grep("biostats", twitter,value = TRUE)
```

    ## [1] "i know how you feel.. i have biostats on tuesday and i have yet to study =/"

Question 6
----------

How many tweets have the exact characters "A computer once beat me at chess, but it was no match for me at kickboxing". (I.e. the line matches those characters exactly.)

``` r
length(grep("A computer once beat me at chess, but it was no match for me at kickboxing", twitter,value = TRUE))
```

    ## [1] 3
