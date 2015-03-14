
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(leaflet)
library(DT)

shinyUI(fluidPage(

  # Application title
  titlePanel("Bicing BCN"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("Steps",
                  "Number of Steps:",
                  min = min(dataset$timeID),
                  max =  max(dataset$timeID),
                  value = 1, 
                  step=1,
                  animate = animationOptions(interval = 1000, loop = TRUE,
                                                        playButton = "let's Play", 
                                                        pauseButton = "That's enough" )
                  )
      
    ),

    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("myMap"),
      dataTableOutput("myDT")
    )
  )
))
