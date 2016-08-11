library(shiny)

# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
prices2 <- load("data/mymodel.rda")
prices = mydata

prices$date = seq(as.Date("2014/6/1"), as.Date("2016/2/1"), "months")
 
prices$X <- NULL

food = prices[which (prices["Type"] == "Food"),]
alc = prices[which (prices["Type"] == "Alcohol"),]

food$Type <- NULL
alc$Type <- NULL

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Fill in the spot we created for a plot
  output$phonePlot <- renderPlot({
    
    plot(food$date,food[,input$region],type="b", xaxt = "n",
            main=input$region,
            ylab="Price index",
            xlab="Month",
            col ="blue")
    axis(1, food$date, format(food$date, "%b %d"), cex.axis = 1.2)
  })
    
    # Fill in the spot we created for a plot
    output$alcplot <- renderPlot({
      
      plot(alc$date,alc[,input$region],type="b", xaxt = "n",
           main=input$region,
           ylab="Price index",
           xlab="Month",
           col ="blue")
      axis(1, alc$date, format(alc$date, "%b %d"), cex.axis = 1.2)
      
  })
})
