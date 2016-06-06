library(shiny)

shinyUI(
        pageWithSidebar(
                headerPanel("Go Button Example"),
                
                sidebarPanel(
                        textInput("text1", "Input Text 1"),
                        textInput("text2", "Input Text 2"),
                        actionButton("goButton", "Go!")
                ),
                
                mainPanel(
                        p("Output Text 1"),
                        textOutput("text1"),
                        p("Output Text 2"),
                        textOutput("text2"),
                        p("Outout Text 3"),
                        textOutput("text3")
                )
        )
)