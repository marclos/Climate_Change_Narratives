#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate range of years based on input$years from ui.R
    head(filter(tmp1, YEAR >= 2014))
    tmp2 = filter(tmp1, YEAR >= input$years[1] & YEAR <= input$years[2])
    print(tmp2)
    
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    plot(Temperature ~ Date, data=tmp2, las=1, pch=20, col="gray")
    
    bestfit = lm(Temperature ~ Date, data=tmp2)
    abline(coef(bestfit), col="red", lwd=2)
    xcoord = min(tmp2$Date, na.rm=T); ycoord=min(tmp2$Temperature, na.rm=T)+10
    
    delta = coef(bestfit)[2]/(yrmax-yrmin)*100
    text(xcoord, ycoord, delta)
    
  })
  
})
