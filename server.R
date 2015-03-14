
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(leaflet)
library(DT)
shinyServer(function(input, output) {

  palF <- colorFactor( "RdYlGn",domain = NULL )
  
 

  output$myMap <- renderLeaflet({ 
    leaflet(dataset[dataset$timeID==input$Steps,]) %>% 
      addTiles('http://openmapsurfer.uni-hd.de/tiles/roads/x={x}&y={y}&z={z}')  %>% 
      setView( mean(dataset$lng), mean(dataset$lat) , zoom = 13) %>%
      addCircles( ~lng, ~lat,
                  radius = ~( bikes+free*3 )+10,
                  popup = ~ paste( name,"<dd> bikes: ",bikes,"<dd> free: ",free ),
                  weight = 1,
                  fillColor = ~palF( bikesBin ), fillOpacity = 0.6,
                  color     = ~palF( freeBin  ), opacity = 1 )
   
                       
                                  })
  
  output$myDT <- renderDataTable({
    datatable(dataset, options = list(iDisplayLength = 5))
                   })
  
  
  
  

})


# Exemples de BaseMAPS http://leaflet-extras.github.io/leaflet-providers/preview/
# 'http://openmapsurfer.uni-hd.de/tiles/roads/x={x}&y={y}&z={z}'
# 'http://{s}.tile.thunderforest.com/outdoors/{z}/{x}/{y}.png'