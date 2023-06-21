library(shiny)
library(ggplot2)

num_vars =  c("carat", "depth", "table", "price", "x", "y", "z")

ui = fluidPage(
  selectInput("var", "Variable", choices = num_vars),
  numericInput("min", "Minimum", value = 1),
  tableOutput("output")
)

server = function(input, output, session) {
  data <- reactive(diamonds %>% filter(.data[[input$var]] > .env$input$min))
  output$output = renderTable(head(data()))
}

shinyApp(ui, server)

ui = fluidPage(
  selectInput("x", "X variable", choices = names(iris)),
  selectInput("y", "Y variable", choices = names(iris)),
  sliderInput("slider1",'size',  min = 1, max = 10, value = 5),
  plotOutput("plot")
)

server = function(input, output, session) {
  output$plot = renderPlot({
    ggplot(iris, aes(.data[[input$x]], .data[[input$y]])) +
      geom_point(aes(size=input$slider1))
  })
}

shinyApp(ui, server)

rsconnect::setAccountInfo(name='tiabet0929', token='4485BEC3F68F0BABD372F9E43B02E668', secret='z1+sqf4btCSg9VwEkGKMfVQK4Gkq3whcsKQXqExj')
