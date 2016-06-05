Question 1
----------

Consider the following code for the cars data set

library(manipulate)
myPlot &lt;- function(s) {
 plot(cars\(dist - mean(cars\)dist), cars\(speed - mean(cars\)speed))
 abline(0, s)
}

This function plots distance versus speed, each de-meaned and an associated line of slope s.

Which of the following code will make a manipulate plot that creates a slider for the slope?

``` r
# library(manipulate)
# myPlot <- function(s) {
#     plot(cars$dist - mean(cars$dist), cars$speed - mean(cars$speed))
#     abline(0, s)
# }
# 
# manipulate(myPlot(s), s = slider(0, 2, step = 0.1))
```

Question 2
----------

Which of the following code uses the 𝚛𝙲𝚑𝚊𝚛𝚝𝚜 package to create a sortable and searchable data table for the 𝚊𝚒𝚛𝚚𝚞𝚊𝚕𝚒𝚝𝚢 data set? Assume the 𝚛𝙲𝚑𝚊𝚛𝚝𝚜 package and the 𝚊𝚒𝚛𝚚𝚞𝚊𝚕𝚒𝚝𝚢 data set have already been loaded into R.

``` r
# library(rCharts)
# dTable(airquality, sPaginationType = "full_numbers")
```

Question 3
----------

A basic shiny data product requires:

``` r
# A 𝚞𝚒.𝚁 and 𝚜𝚎𝚛𝚟𝚎𝚛.𝚁 file or a A 𝚜𝚎𝚛𝚟𝚎𝚛.𝚁 file and a directory called 𝚠𝚠𝚠 containing the relevant html files.
```

Question 4
----------

What is incorrect about the followig syntax in 𝚞𝚒.𝚁?

library(shiny)
shinyUI(pageWithSidebar(
 headerPanel("Data science FTW!"),
 sidebarPanel(
 h2('Big text')
 h3('Sidebar')
 ),
 mainPanel(
 h3('Main Panel text')
 ) ))

``` r
# Missing a comma in the sidebar panel

# library(shiny)
# shinyUI(pageWithSidebar(  
#   headerPanel("Data science FTW!"),  
#   sidebarPanel(    
#      h2('Big text'),
#      h3('Sidebar')
#   ),  
#   mainPanel(      
#        h3('Main Panel text')  
#   )
# ))
```

Question 5
----------

Consider the following code in 𝚞𝚒.𝚁 shinyUI(pageWithSidebar(
 headerPanel("Example plot"),
 sidebarPanel(
 sliderInput('mu', 'Guess at the mu',value = 70, min = 60, max = 80, step = 0.05,) ), mainPanel(
 plotOutput('newHist')
 ) )) And the following 𝚜𝚎𝚛𝚟𝚎𝚛.𝚁 code.

library(UsingR) data(galton)

shinyServer(
 function(input, output) {
 output\(myHist <- renderPlot({  hist(galton\)child, xlab='child height', col='lightblue',main='Histogram')
 mu &lt;- input\(mu  lines(c(mu, mu), c(0, 200),col="red",lwd=5)  mse <- mean((galton\)child - mu)^2)
 text(63, 150, paste("mu = ", mu))
 text(63, 140, paste("MSE = ", round(mse, 2)))
 }) } ) Why isn't it doing what we want?

``` r
# The server.R output name isn't the same as the plotOutput command used in ui.R.
```
