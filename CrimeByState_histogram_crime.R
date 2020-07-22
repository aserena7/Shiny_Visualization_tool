USArrests<- read.csv("/Users/Serena/Desktop/UPM/Big Data/visualization/USArrests.csv")
data<-USArrests[,-c(1)]
data<-data[,-c(3)]
library(shiny)
# Use a fluid Bootstrap layout
ui<- fluidPage(    
  
  # Give the page a title
  titlePanel("Crime Distribution"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("crime", "Select Crime:",
                  choices=colnames(data)),
     
      selectInput(inputId = "n_breaks",
                  label = "Number of bins in histogram (approximate):",
                  choices = c(10, 20, 35, 50),
                  selected = 20),
      
      checkboxInput(inputId = "individual_obs",
                    label = strong("Show individual observations"),
                    value = FALSE),
      
      
       hr(),
      helpText("Histrogram that shows the frequency distribution of each crime")
               
      
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("crimePlot")  
    )
    
  )
)


# Define a server for the Shiny app
server<-function(input, output,session) {
  
  #outputting the bar data
  output$crimePlot <- renderPlot({
    
    hist(data[,input$crime],
         main=input$crime,
         probability = TRUE,
         breaks = as.numeric(input$n_breaks),
         xlab="")
    
    if (input$individual_obs) {
      rug(data[,input$crime])
    }
    
    
  })
}

shinyApp(ui, server)
