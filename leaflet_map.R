library(leaflet)
library(jsonlite)
library(htmlwidgets)


# Using fromJSON instead of graphics libs because they are all unnecessarily hard to use
directions = read.csv('route_coordinates.csv', header = FALSE)
names(directions) = c('lat', 'lon')
lattitude = directions[,1]
longitude = directions[,2]

lat = c(44.9554089, 44.9558987, 44.9491110, 44.9486850, 44.9478321, 44.9486722, 
        44.9481936, 44.9493996, 44.9493908, 44.9495177, 44.9615287, 44.9620660)

lon = c(-93.2755728, -93.2877550, -93.2876710, -93.2883259, -93.2883593, 
        -93.2973159, -93.2972610, -93.2976402, -93.2977870, -93.2981007, 
        -93.2926604, -93.2916538)

bars = c('TILT', 'The Bulldog', 'The Lyndale', 
         'Moto-i', 'Up-Down', 
         'Stella\'s Fish Café', 
         'Libertine', 
         'Uptown Tavern', 'Cowboy Slim\'s', 
         'Williams Uptown Pub', 
         'The Lowry', 
         'Liquor Lyle\'s')

pointsOfInterest = data.frame(longitude = lon,
                              lattitude = lat,
                              popup = bars)


icon_list <- lapply(1:12, function(x){
    makeIcon(
        iconUrl = paste0("icons/", x, ".png"),
        iconWidth = 30, 
        iconHeight = 30)
})

icon_list[[1]] =     makeIcon(
        iconUrl = "icons/phil_2.png",
        iconWidth = 80, 
        iconHeight = 80)
icon_list[[12]] =     makeIcon(
        iconUrl = "icons/phil_2.png",
        iconWidth = 80, 
        iconHeight = 80)

map = leaflet() %>% 
           addProviderTiles(providers$Hydda.Base) %>% 
           addPolylines(lat = lattitude, lng = longitude, color = "white", weight = 10) %>%
           addPolylines(lat = lattitude, lng = longitude, color = "#FFFF00", weight = 6) 

for(i in 1:12){
    map = map %>% addMarkers(lat = pointsOfInterest$lattitude[i], 
                             lng = pointsOfInterest$longitude[i], 
                             popup = pointsOfInterest$popup[i], 
                             icon = icon_list[[i]])
}
           


saveWidget(map, file = "index.html")

