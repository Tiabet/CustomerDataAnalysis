library(shiny)
library(shinyWidgets)

ui = fluidPage(
  #default
  checkboxGroupInput("checkGroup", label = "Default Widget",
                     choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
                     selected = 1),
  #widgets
  awesomeCheckboxGroup(
    inputId = "checkGroupWidgets",
    label = "shinyWidgets",
    choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
    selected = 1
  )
)

server <- function(input, output, session) {
}

shinyApp(ui, server)