library(ggplot2)
library(shiny)

usa_arrest <- read.csv("USArrests.csv")

#Rename column
colnames(usa_arrest)[colnames(usa_arrest) == 'X'] <- 'state'


ui <- fluidPage(
  titlePanel("Ranking of Arrests by State"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Arrests in the US."),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Murder", "Assault", "Rape"),
                  selected = "Murder"),
      
      
    ),
    
    mainPanel(plotOutput("bar"))
  )
)

server <- shinyServer(function(input, output){
  
  output$bar <- renderPlot({
    
    if (input$var == "Murder") {ggplot(data=usa_arrest,aes(x=reorder(state,Murder),y=Murder)) + 
        geom_bar(stat ='identity',aes(fill=Murder))+
        coord_flip() + 
        theme_grey() + 
        scale_fill_gradient(name="Murder Rate")+
        labs(title = 'Murder Rate',
             y='Murder Rate',x='States')+ 
        geom_hline(yintercept = mean(usa_arrest$Murder), size = 1, color = 'blue')
      
    } else {
      
      
      
      if (input$var == "Assault") {ggplot(data=usa_arrest,aes(x=reorder(state,Assault),y=Assault)) + 
          geom_bar(stat ='identity',aes(fill=Assault))+
          coord_flip() + 
          theme_grey() + 
          scale_fill_gradient(name="Assault Rate")+
          labs(title = 'Assault Rate',
               y='Assault Rate',x='States')+ 
          geom_hline(yintercept = mean(usa_arrest$Assault), size = 1, color = 'blue')
        
      } else {
        
        
        
        if (input$var == "Rape") {ggplot(data=usa_arrest,aes(x=reorder(state,Rape),y=Rape)) + 
            geom_bar(stat ='identity',aes(fill=Rape))+
            coord_flip() + 
            theme_grey() + 
            scale_fill_gradient(name="Rape Rate")+
            labs(title = 'Rape Rate',
                 y='Rape Rate',x='States')+ 
            geom_hline(yintercept = mean(usa_arrest$Rape), size = 1, color = 'blue')
          
        } }}
    
  })
})


shinyApp(ui, server)

