server <- function(input, output, session) {
  # this will work, the reactive element is wrapped in an observer
  # it prints the value to the to the results text box
  observe({
    updateTextInput(session, inputId = "myresults", value = input$mytext) 
    
  })
}

ui <-   basicPage(
  h3("The value in the text box gets printed to the results text box."),
  textInput("mytext", "Input goes here"),
  textInput("myresults", "Results will be printed here", "Initial value")
)

shinyApp(ui = ui, server = server)