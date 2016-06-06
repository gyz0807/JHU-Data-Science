library(shiny)
shinyUI(
        pageWithSidebar(
                headerPanel("Illustrating markup"),
                sidebarPanel(
                        h1("Sidebar panel"),
                        h1("H1 text"),
                        h2("H2 text"),
                        h3("H3 text"),
                        h3("H4 text")
                ),
                mainPanel(
                        h3("Main Panel Text"),
                        code('some code'),
                        p("some ordinary text")
                )
        )
)