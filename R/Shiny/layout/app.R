library(shiny)

ui = navbarPage(
  "Page title",
  tabPanel("panel 1",
           sidebarLayout(
             sidebarPanel(
               print('side')
             ),
             mainPanel(
               tabsetPanel(
                 id = "tabset",
                 tabPanel("panel 1", "one"),
                 tabPanel("panel 2", "two"),
                 tabPanel("panel 3", "three")
               )
             )
           )
  ),
  tabPanel("panel 2", "two"),
  tabPanel("panel 3", "three"),
  navbarMenu("subpanels",
             tabPanel("panel 4a", "four-a"),
             tabPanel("panel 4b", "four-b"),
             tabPanel("panel 4c", "four-c")
  )
)


server = function(input, output, session) {
  
}

shinyApp(ui, server)