library(shiny)

ui = fluidPage(
  
  sliderInput(inputId = 'num',
              label = "Number of Data",
              min = 300,
              max = 100000,
              value = 300),
  
  textOutput('simNumber'),
  plotOutput('distPlot')
  
)

server = function(input, output, session) {
  
  num = reactive({
    input$num
  })
  
  output$simNumber = renderText({
    paste0('Number of Generation: ', num())
  })
  
  output$distPlot = renderPlot({
    x = rnorm(num(), mean = 0, sd = 1)
    hist(x,
         breaks = num() / 100,
         main = 'Histogram of Random Generation Number')
  })
  
}

shinyApp(ui, server)