#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict HP from MPG"),
  
  # Sidebar with a slider input for number of bins
  # sidebarLayout(
  #   sidebarPanel(
  #     sliderInput("sliderMPG",
  #                 "What is Car's MPG?",
  #                 min = 10,
  #                 max = 35,
  #                 value = 20)
  #   ),
    
    # Show a plot of the generated distribution
    mainPanel(
      sliderInput("sliderMPG",
                  "What is Car's MPG?",
                  min = 10,
                  max = 35,
                  value = 20),
      plotly::plotlyOutput("plot1"),
      h3("LM prediction (model 1 - red):"),
      textOutput('pred1'),
      h3("Random Forest prediction (model 2 - green):"),
      textOutput('pred2'),
      h3("Support Vector Machine prediction (model 3 - blue):"),
      textOutput('pred3'),
      h3("Decision Tree prediction (model 4 - yellow):"),
      textOutput('pred4')
    )
  )
)
