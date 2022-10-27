#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(plotly)
library(randomForest)
library(e1071)
library(rpart)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  model1 <- lm(hp~mpg, data=mtcars)
  model2 <- randomForest(hp~mpg, data= mtcars)
  model3 <- svm(hp~mpg, data= mtcars)
  model4 <- rpart(hp~mpg, data= mtcars)
  
  model1pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model1, newdata= data.frame(mpg= mpgInput))
  })
  
  model2pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model2, newdata= data.frame(mpg= mpgInput))
  })
  
  model3pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model3, newdata= data.frame(mpg= mpgInput))
  })
  
  model4pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model4, newdata= data.frame(mpg= mpgInput))
  })
  
  
  output$plot1 <- renderPlotly({  
    mpgInput <- input$sliderMPG
    g <- mtcars %>%
      ggplot(aes(mpg, hp)) +
      geom_point() +
      coord_cartesian(xlim=c(10,35), ylim=c(50,350)) +
      geom_line(aes(x= mpg, y= predict(model1)), col='red') +
      geom_point(aes(x=mpgInput, y=model1pred()), col='red', size=3) +
      geom_line(aes(x= mpg, y= predict(model2)), col='green') +
      geom_point(aes(x=mpgInput, y=model2pred()), col='green', size=3) +
      geom_line(aes(x= mpg, y= predict(model3)), col='blue') +
      geom_point(aes(x=mpgInput, y=model3pred()), col='blue', size=3) +
      geom_line(aes(x= mpg, y= predict(model4)), col='orange') +
      geom_point(aes(x=mpgInput, y=model4pred()), col='orange', size=3) +
      theme_classic()
    ggplotly(g)
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
  
  output$pred3 <- renderText({
    model3pred()
  })
  
  output$pred4 <- renderText({
    model4pred()
  })
  
})
