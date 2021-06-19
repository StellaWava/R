shp= shapefile("D:/WORK/Documents/stella/LANDnet/OTHER ACTIVITES 2020/MOOC_GIS_RS/R_Class/UG.shp")
shp
class(shp)
plot(shp)
##SHP AS DATA FRAME
shp1 = as.data.frame(shp)
shp1

##CONVERTING DATA FRAME INTO JSOM


#READING GEOJSON AS WELL

install.packages("geojsonio")
install.packages("rmapshaper")
install.packages("spdplyr")
##writing geojson
install.packages('geojsonR')
library(geojsonR)
install.packages("rgeos")
library(rgeos)
install.packages("rgdal")
library(rgdal)
library(geojsonio)

#geojson reading
library(rjson)
setwd("D:/WORK/Documents/stella/LANDnet/OTHER ACTIVITES 2020/MOOC_GIS_RS/R_Class")
json<- fromJSON(file="ugandaPadmin2.geojson")
json


