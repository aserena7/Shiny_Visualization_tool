library(shiny)
library(tidyverse)
library(plotly)

usa_arrest <- read.csv("USArrests.csv")
usa <- select(usa_arrest, -X)
# cache computation of the correlation matrix
correlation <- round(cor(usa))

ui <- fluidPage(
  
  # Give the page a title
  titlePanel("Interactive Scatter Plots"),
  
  plotlyOutput("heat"),
  plotlyOutput("scatterplot")
)

server <- function(input, output, session) {
  
  output$heat <- renderPlotly({
    plot_ly(source = "heat_plot") %>%
      add_heatmap(
        x = names(usa), 
        y = names(usa), 
        z = correlation
      )
  })
  
  output$scatterplot <- renderPlotly({
    clickData <- event_data("plotly_click", source = "heat_plot")
    if (is.null(clickData)) return(NULL)
    
    vars <- c(clickData[["x"]], clickData[["y"]])
    d <- setNames(usa[vars], c("x", "y"))
    yhat <- fitted(lm(y ~ x, data = d))
    
    plot_ly(d, x = ~x) %>%
      add_markers(y = ~y) %>%
      add_lines(y = ~yhat) %>%
      layout(
        xaxis = list(title = clickData[["x"]]), 
        yaxis = list(title = clickData[["y"]]), 
        showlegend = FALSE
      )
  })
  
}

shinyApp(ui, server)