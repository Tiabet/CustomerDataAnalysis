library(shiny)
library(DT)
library(ggplot2)
library(dplyr)
library(magrittr)
library(palmerpenguins)

ui <- fluidPage(
  titlePanel("Palmer Penguins Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("species", "펭귄 종류", 
                         choices = unique(penguins$species), 
                         selected = unique(penguins$species)),
      
      selectInput("x_axis", "그림의 x축", 
                  choices = c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g"),
                  selected = "bill_length_mm"),
      
      selectInput("y_axis", "그림의 y축", 
                  choices = c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g"),
                  selected = "bill_depth_mm"),
      
      sliderInput("point_size", "그림의 점 크기", 
                  min = 1, max = 10, value = 5)
    ),
    
    mainPanel(
        DTOutput("datatable"),
        plotOutput("scatterplot")
      )
    )
  )


server <- function(input, output) {
  
  filtered_data <- reactive({
    penguins %>%
      filter(species %in% input$species)
  })
  
  output$datatable <- renderDT({
    filtered_data() %>%
    datatable()
  })
  
  output$scatterplot <- renderPlot({
    filtered_data()%>%
    ggplot(aes_string(x = input$x_axis, y = input$y_axis, color = "species", shape = "sex")) +
      geom_point(size = input$point_size) +
      labs(x = input$x_axis, y = input$y_axis, color = "펭귄 종류", shape = "성별")
  })
}

shinyApp(ui, server)

