#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
station1 <- read.csv("../Data/XYZ_dly.csv")
yrmin = min(station1$YEAR, na.rm=T)
yrmax = max(station1$YEAR, na.rm=T)
# Define UI for application that draws a histogram

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Are Weather Changes are Ambiguous?"),
  
  tags$h2("Maximum Daily Temperatures"),
  
  "Can I right text without tags?",
  
  tags$body("The weather in XX has only been collected since XX. This weather station is... ", tags$a(href = "http://shiny.rstudio.com/tutorial/", "tutorial")),
  
  #tags$hr,
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("years", "Range of Years:",
                   min = yrmin,
                   max = yrmax,
                   value = c(yrmin, maxyr),
                   step = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  ), "more text? with R outputs"
))


