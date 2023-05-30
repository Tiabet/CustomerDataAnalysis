library(shiny)
library(DT)
library(ggplot2)
library(dplyr)
library(magrittr)

ui = fluidPage(
  
  titlePanel("mtcars"),
  sidebarLayout(
    
    sidebarPanel(
      checkboxGroupInput("cyl", label = '실린더를 선택하세요',
                         choices = list(4, 6, 8),
                         selected = 4) #default selected = 4
    ),
    
    mainPanel(
      dataTableOutput('mtcars_table'),
      plotOutput('mtcars_plot')
    )
  )
)

server = function(input, output, session) {
  
  sel_mtcars = reactive({
    mtcars %>%
      select(mpg, cyl, wt) %>%
      filter(cyl %in% input$cyl)
  })
  
  output$mtcars_table = renderDataTable({
    
    sel_mtcars() %>%
      datatable()
  })
  
  output$mtcars_plot = renderPlot({
    
    sel_mtcars() %>%
      ggplot(aes(x = mpg, y = wt, color = factor(cyl))) +
      geom_point(size = 5)
    
  })
  
}
shinyApp(ui, server)