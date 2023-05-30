library(shiny)

ui = fluidPage(
  
  # 1
  sliderInput(inputId = 'num',
              label = "Number of Data",
              min = 300,
              max = 100000,
              value = 300),
  
  # 4
  textOutput('simNumber'),
  plotOutput('distPlot')
  
)

server = function(input, output, session) {
  
  # 2
  output$simNumber = renderText({
    paste0('Number of Generation: ', input$num)
  })
  
  # 3
  output$distPlot = renderPlot({
    x = rnorm(input$num, mean = 0, sd = 1)
    hist(x,
         breaks = input$num / 100,
         main = 'Histogram of Random Generation Number')
  })
  
}

shinyApp(ui, server)