# ui.R

library(shiny)

# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally prices <- load("data/mymodel.rda")
# package (which generally comes preloaded).
prices2 <- load("data/mymodel.rda")
prices = mydata

prices$date = seq(as.Date("2014/6/1"), as.Date("2016/2/1"), "months") 
prices$X <- NULL

food = prices[which (prices["Type"] == "Food"),]
alc = prices[which (prices["Type"] == "Alcohol"),]

food$Type <- NULL
alc$Type <- NULL

# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    br(),
    titlePanel(
      h1("Data visualisation of Experimental Prices indices", style = "color:darkblue; font-family: 'serif'; font-weight: bold; font-size: 38px;"),
      ),
    br(),
    br(),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        helpText("Select which Price index which is of interest to you:"), 
      
        radioButtons("region", 
                         label = h3(""), 
                         choices=list( "CPI Published." = "CPI..Published.","CPI Web.scraped." = "CPI...Web.scraped.","Daily chained" = "Daily.chained", "Unit price" = "Unit.price", "GEKSJ" = "GEKSJ"),
                         selected = "CPI..Published.")),     

      
      
      # Create a spot for the barplot
      mainPanel(
          h1(""),
          p("Experimental price indices based on web-scraped data from the Office for National Statistics. Ref: Office for National Statistics, 2016. Research indices using web scraped price data: May 2016 update. Downloaded from:"),
          a("https://www.ons.gov.uk/releases/researchindicesusingwebscrapedpricedatamay2016update."),
          br(),
          br(),
          p("This information is licensed under the terms of the Open Government Licence [http://www.nationalarchives.gov.uk/doc/open-government-licence/version/2]."),
          br(),
          tabsetPanel(type = "tabs", 
          tabPanel("Food and non-alcoholic beverages", plotOutput("phonePlot")), 
          tabPanel("Alcohol", plotOutput("alcplot")) 
          )
      )
      
    )
  )
)