library(leaflet)


dataset <- read.csv("data/bicing.csv",sep=";",header=TRUE)

palF <- colorFactor( "RdYlGn",domain = NULL )

# Exemples de BaseMAPS http://leaflet-extras.github.io/leaflet-providers/preview/
# 'http://openmapsurfer.uni-hd.de/tiles/roads/x={x}&y={y}&z={z}'
# 'http://{s}.tile.thunderforest.com/outdoors/{z}/{x}/{y}.png'

m = leaflet(dataset[dataset$timestamp=="2015-03-10 21:49:00",]) %>% 
    addTiles('http://openmapsurfer.uni-hd.de/tiles/roads/x={x}&y={y}&z={z}')  %>% 
    setView( mean(dataset$lng), mean(dataset$lat) , zoom = 13) %>%
    addCircles( ~lng, ~lat,
                 radius = ~( bikes+free*3 )+10,
                 popup = ~ paste( name,"<dd> bikes: ",bikes,"<dd> free: ",free ),
                 weight = 1,
                 
                 fillColor = ~palF( bikesBin ), fillOpacity = 0.6,
                 
                 color     = ~palF( freeBin  ), opacity = 1 )
m




