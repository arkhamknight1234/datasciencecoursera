#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("shiny")
library("dplyr")
library("ggplot2")

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
print(str(bcl))

# Define UI for application that draws a histogram

ui <- fluidPage(
  titlePanel("BC Liquor Store prices"), strong("The example followed has been taken from https://deanattali.com/blog/building-shiny-apps-tutorial/"),

             
  sidebarLayout(
    sidebarPanel(sliderInput("priceInput", "Price", min = 0, max = 100,
                             value = c(25, 40), pre = "$"),
                 radioButtons("typeInput", "Product type",
                              choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                              selected = "WINE"),
                 selectInput("countryInput", "Country",
                             choices = c("CANADA", "FRANCE", "ITALY"))
                 
                 
                 
                 
                 ),
    mainPanel(
      plotOutput("coolplot"), br(), br(),
      tableOutput("results")
      
      
    )
  )
  
)

server <- function(input, output) {
  output$coolplot <- renderPlot({
    filtered <-
      bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
    ggplot(filtered, aes(Alcohol_Content)) +
      geom_histogram()
  })
  
  output$results <- renderTable({
    filtered <-
      bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
    filtered
  })
  
  
  
  
  
  
}
  
shinyApp(ui = ui, server = server)










