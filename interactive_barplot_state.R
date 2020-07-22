USArrests<-read.csv("USArrests.csv")
names<-USArrests$X
USArrests<-USArrests[,-c(1)]
USArrests<-USArrests[,-c(3)]
labels=character(3)
m<-mean(USArrests$Murder)
m<-as.character(m)
a<-mean(USArrests$Assault)
a<-as.character(a)
r<-mean(USArrests$Rape)
r<-as.character(r)
labels[1]=m
labels[2]=a
labels[3]=r
data<-t(USArrests)
colnames(data)<-names


library(shiny)
# Use a fluid Bootstrap layout
ui<- fluidPage(    
  
  # Give the page a title
  titlePanel("Crimes by State"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("state", "Select State:",
                  choices=colnames(data)),
      hr(),
      helpText("Barplot that shows the amount of different crimes for each state of USA 
               (It's possible to do a quick comparison with the average values shown in the legend)")
      
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
    
  color <- c("blue", "red", "yellow","green")
    
   barplot(data[,input$state],
            main=input$state,
            ylab="Total",
            xlab="Crime",
            names.arg = c("Murder","Assault","Rape"),
            col=color,
            legend.text=(labels )
           )
    
  })
}

shinyApp(ui, server)

