library(shiny)

shinyUI(
        pageWithSidebar(

                headerPanel("Diabetes Prediction"),
                
                sidebarPanel(
                        numericInput("glucose", "Glucose mg/dl", 90, 50, 200, 5),
                        submitButton("Submit")
                ),
                
                mainPanel(
                        h3("Results of prediction"),
                        h4("You entered"),
                        verbatimTextOutput("inputValue"),
                        h4("Which resulted in a prediction of "),
                        verbatimTextOutput("prediction")
                )
        )
)