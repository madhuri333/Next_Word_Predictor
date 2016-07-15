#=======================================================================================================
# Predict Next Word : Capstone Project (ui.R forApp)
# Purpose: Help user type quickly by predicting next word corresponding to input word/ phrase.
#=======================================================================================================

library(shiny)
library(markdown)

# Define UI for application
shinyUI(navbarPage(
  title = "Next Word Predictor App",
  tabPanel("Predict",
           fluidPage(
             
               helpText("Please enter some text below:"),
               textInput("phrase", label = NULL),
               actionButton("act", "Predict Next Word!"),
               hr(), 
               verbatimTextOutput("prediction"),
               helpText("NOTE: Please wait while the app is loading data, specially during first prediction. Thanks.")
           )
),

tabPanel("About us",
         mainPanel(
           includeMarkdown("about_us.md")
         )
),

tabPanel("How to Use",
         mainPanel(
           includeMarkdown("help.md")
         )
)

)
)
