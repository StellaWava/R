##set your working directory where your spatial data (shapefiles) are located in your drive
setwd("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles")

##Load the necessary libraries
library(raster)
library(rgeos)
library(rgdal)
library(leaflet)
library(dplyr)
library(ggplot2)
library(sf)
library(sp)
library(devtools)
library(ggmap)
install.packages(ggmap)
##load your spatial data (shapefiles) into R
Kenya_Counties <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles/Counties.shp")
Kenya_Conservancies <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Conservancies")
Kenya_Crop_Land <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Crop_Land")
Kenya_Energy_Structure <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Energy_Structure")
Kenya_Grain_Basket_Areas <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Grain_Basket_Areas")
Kenya_Industrial_Crops_Areas <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Industrial_Crops_Areas")
Kenya_Irrigation_Areas <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Irrigation_Areas")
Kenya_Lake_Victoria <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Lake_Victoria")
Kenya_Nairobi_Metropolitan_Area <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Nairobi_Metropolitan_Area")
Kenya_National_Game_Parks <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "National_Game_Parks")
Kenya_Wetlands <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Wetlands")
Kenya_Water_Towers <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Water_Towers")
Kenya_Urban_Development_Structure <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Urban_Development_Structure")
Kenya_Transport_Network <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Transport_Network")
Kenya_Rangeland <- readOGR("C:/Users/HP-PC/Desktop/NSP_shp/NSP_Shapefiles", "Rangeland")

##project your spatial data (shapefiles) projection into Geographic coordinate system (WGS84)
Kenya_Energy_Structure_prj <- spTransform(Kenya_Energy_Structure, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
Kenya_Grain_Basket_Areas_prj <- spTransform(Kenya_Grain_Basket_Areas, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
Kenya_Conservancies_prj <- spTransform(Kenya_Conservancies, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
Kenya_Crop_Land_prj <- spTransform(Kenya_Crop_Land, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
Kenya_National_Game_Parks_prj <- spTransform(Kenya_National_Game_Parks, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
Kenya_Wetlands_prj <- spTransform(Kenya_Wetlands, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
Kenya_Water_Towers_prj <- spTransform(Kenya_Water_Towers, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
Kenya_Transport_Network_prj <- spTransform(Kenya_Transport_Network, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
Kenya_Urban_Development_Structure_prj <- spTransform(Kenya_Urban_Development_Structure, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))


# start basemap
map <- leaflet() %>% 
  
  # add open source basemaps
  
  addProviderTiles(providers$OpenStreetMap.Mapnik, group = "Open Street Map") %>%
  addProviderTiles(providers$Esri.WorldImagery, group = "Esri World Imagery") %>%
  addProviderTiles(providers$OpenTopoMap, group = "Topo Map") %>%
  # add another layer with place names
  addProviderTiles(providers$Hydda.RoadsAndLabels, group = 'Place Names') %>%
  
  # add graticules from a NOAA webserver
  addWMSTiles(
    "https://gis.ngdc.noaa.gov/arcgis/services/graticule/MapServer/WMSServer/",
    layers = c("1-degree grid", "5-degree grid"),
    options = WMSTileOptions(format = "image/png8", transparent = TRUE),
    attribution = NULL,group = 'Graticules') %>%
  
  # focus map in a certain area / zoom level
  setView(lng = 37, lat = 0.3, zoom = 6) %>%
  
  # add layers control
    addLayersControl(baseGroups = c('Open Street Map', 'Esri World Imagery', 'Topo Map'),
                   overlayGroups = c('Counties',
                                     'Transport Network',
                                     'Energy Installations',
                                     'Grain Basket Areas',
                                     'National Parks',
                                     'Wetlands',
                                     'Water Towers',
                                     'Urban Development Structure',
                                     'Place names',
                                     'Graticules'),
                   options = layersControlOptions(collapsed = FALSE),
                   position = 'topright') %>%
  
  # list groups to hide on startup
  hideGroup(c('Place names', 'Transport Network', 'Energy Installations', 'Grain Basket Areas', 'National Parks', 'Wetlands', 'Water Towers', 'Urban Development Structure', 'Graticules'))

# add spatial data (shapefiles)/points, lines and polygons
map <- map %>%
  addCircleMarkers(data=Kenya_Energy_Structure_prj,
                   label=~Type,
                   weight = 3, 
                   radius=3.5, 
                   color="#b509e0",
                   options = WMSTileOptions(format = "image/png8", transparent = TRUE),
                   group= "Energy Installations")


map <- map %>%
  addPolygons(data=Kenya_Grain_Basket_Areas_prj,
              weight = 2,
              color = "#0cbd00",
              label =~USERLABEL,
              group = "Grain Basket Areas",
              options = WMSTileOptions(format = "image/png8", transparent = FALSE),
              highlight = highlightOptions(weight = 10,
                                           color = "green",
                                           bringToFront = TRUE))


map <- map %>%
  addPolygons(data=Kenya_Counties,
              weight = 2,
              color = "black",
              label =~DIST_NAME,
              group = "Counties",
              options = WMSTileOptions(format = "image/png8", transparent = TRUE),
              highlight = highlightOptions(weight = 10,
                                           color = "black",
                                           bringToFront = TRUE))



map <- map %>%
  addPolygons(data=Kenya_National_Game_Parks_prj,
              weight = 2,
              color = "#59220b",
              label =~AREANAME,
              group = "National Parks",
              options = WMSTileOptions(format = "image/png8", transparent = TRUE),
              highlight = highlightOptions(weight = 10,
                                           color = "brown",
                                           bringToFront = TRUE))

map <- map %>%
  addPolygons(data=Kenya_Wetlands_prj,
              weight = 2,
              color = "#0052c4",
              label =~USERLABEL,
              group = "Wetlands",
              options = WMSTileOptions(format = "image/png8", transparent = TRUE),
              highlight = highlightOptions(weight = 10,
                                           color = "blue",
                                           bringToFront = TRUE))

map <- map %>%
  addPolygons(data=Kenya_Water_Towers_prj,
              weight = 2,
              color = "#0a0d61",
              label =~AREANAME,
              group = "Water Towers",
              options = WMSTileOptions(format = "image/png8", transparent = TRUE),
              highlight = highlightOptions(weight = 10,
                                           color = "blue",
                                           bringToFront = TRUE))

map <- map %>%
  addPolygons(data=Kenya_Urban_Development_Structure_prj,
              weight = 2,
              color = "#f2150a",
              label =~Category,
              group = "Urban Development Structure",
              options = WMSTileOptions(format = "image/png8", transparent = TRUE),
              highlight = highlightOptions(weight = 10,
                                           color = "red",
                                           bringToFront = TRUE))


map <- map %>%
  addPolylines(data=Kenya_Transport_Network_prj,
               weight = 2,
               color = "red",
               label =~Category,
               group = "Transport Network",
               options = WMSTileOptions(format = "image/png8", transparent = FALSE),
               highlight = highlightOptions(weight = 7,
                                            color = "grey",
                                            bringToFront = TRUE))



# add more features
map <- map %>% 
  # add a map scalebar
  addScaleBar(position = 'topright') %>%
  
  # add measurement tool
  addMeasure(
    primaryLengthUnit = "kilometers",
    secondaryLengthUnit = 'miles', 
    primaryAreaUnit = "hectares",
    secondaryAreaUnit="acres", 
    position = 'topleft')
# show map
map

# # # save a stand-alone, interactive map as an html file
library(htmlwidgets)
saveWidget(widget = map, file = 'map.html', selfcontained = T)

# # # save a snapshot as a png file
library(mapview) 
mapshot(map, file = 'map.png')