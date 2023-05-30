library(shiny)
library(ggplot2)
library(magrittr)
library(plotly)

ui = fluidPage(
  plotOutput('normal'),
  plotOutput('ggplot'),
  plotlyOutput('plotly')
)

server = function(input, output, session) {
  output$normal = renderPlot({
    plot(1:5)
  })
  
  output$ggplot = renderPlot({
    data.frame(x = 1:5, y = 1:5) %>%
      ggplot(aes(x = x, y = y)) +
      geom_point()
  })
  
  output$plotly = renderPlotly({
    (data.frame(x = 1:5, y = 1:5) %>%
       ggplot(aes(x = x, y = y)) +
       geom_point()) %>% ggplotly()
  })
}

shinyApp(ui, server)
