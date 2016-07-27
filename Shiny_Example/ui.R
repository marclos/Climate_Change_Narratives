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
  titlePanel("Title"),
  
  tags$h2("Header 2"),
  
  tags$code("Welcome to simple Shiny App that we can use to as a template for our Project blog.  Before you spend too much time playing with Shiny, I suggest you look at this", tags$a(href = "http://shiny.rstudio.com/tutorial/", "tutorial")),
  
  #tags$hr,
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("bins",
                   "Number of bins:",
                   min = 1,
                   max = 50,
                   value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))


