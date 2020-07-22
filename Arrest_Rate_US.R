library(shiny)
library(usmap)
library(ggplot2)

usa_arrest <- read.csv("USArrests.csv")

#Rename column
colnames(usa_arrest)[colnames(usa_arrest) == 'X'] <- 'state'

ui <- fluidPage(
  titlePanel("Arrest Rates by State"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("US Map representation."),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Murder", "Assault", "Rape"),
                  selected = "Murder"),
      
      
    ),
    
    mainPanel(plotOutput("map"))
  )
)

server <- shinyServer(function(input, output){
  
  output$map <- renderPlot({
    
    if (input$var == "Murder") {
      plot_usmap(data = usa_arrest, values = "Murder", color = "blue") + 
        scale_fill_continuous(name = "Murder", label = scales::comma) + 
        theme(legend.position = "right")
    } else {
      
    
    
    if (input$var == "Assault") {
      plot_usmap(data = usa_arrest, values = "Assault", color = "blue") + 
        scale_fill_continuous(name = "Assault", label = scales::comma) + 
        theme(legend.position = "right")
    } else {
      
    
    
    if (input$var == "Rape") {
      plot_usmap(data = usa_arrest, values = "Rape", color = "blue") + 
        scale_fill_continuous(name = "Rape", label = scales::comma) + 
        theme(legend.position = "right")
    } }}
    
  })
})


shinyApp(ui, server)

