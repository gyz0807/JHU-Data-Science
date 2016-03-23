################## Question 1
library(httr); library(jsonlite)

oauth_endpoints("github")

myapp <- oauth_app("github",
                   key = "xxxxxx",
                   secret = "xxxxxx")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
json1 <- content(req)
json2 <- fromJSON(toJSON(json1))
json2[json2$name=="datasharing", "created_at"]


################## Question 2
library(DBI); library(RSQLite); library(proto); library(gsubfn); library(sqldf)

## Loading data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "Survey.csv", "curl")
acs <- read.csv("Survey.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")


################## Question 3
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")


################## Question 4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
nchar(htmlCode[10]); nchar(htmlCode[20]); nchar(htmlCode[30]); nchar(htmlCode[100])


################## Question 5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", "Data.for", "curl")
mydf <- read.fwf("Data.for", widths = c(12, 7, 4, 9, 4, 9, 4, 9, 4), skip = 4)
sum(mydf$V4)

