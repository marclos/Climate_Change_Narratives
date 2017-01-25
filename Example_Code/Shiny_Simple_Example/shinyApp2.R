server <- function(input, output, session) {
  
  # when the slider changes update the text box
  observe({
    updateTextInput(session, "mytext", value=input$myslider)
  })
  
  # when the slider changes update the dataset
  dat <- reactive({
    input$myslider
    cars[1:input$myslider,]
  })
  
  # Since dat() is generated from a reactive that 
  # is triggered by input$myslider this table will update
  # any time that input$myslider updates
  output$mytable <- renderTable({
    dat()
  })

}

ui <- fluidPage(
  
  titlePanel("An app using an observe, reactive and render"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("myslider", "Number of rows to display", min=1, max=50, value=5),
      textInput(inputId = "mytext", label = "Slider value")
    ), # end sidebar panel
    
    mainPanel(
      tabsetPanel(
        tabPanel("Table", tableOutput("mytable"))
      )
    ) # end main panel
  )
)

shinyApp(ui = ui, server = server)