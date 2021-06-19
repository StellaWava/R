library(rjson)
library(maps)
library(leaflet)
library(geojsonio)
library(sen2r)
library(sf)
library(sp)
library(raster)
library(rgdal)
library(devtools)
library(getSpatialData)

install.packages("devtools")
install.packages("getSpatialData")
##setting wd
setwd("D:/WORK/Documents/stella/LANDnet/OTHER ACTIVITES 2020/MOOC_GIS_RS/R_Class")
getwd()

##Readingjson 
json<- fromJSON(file="ugandaPadmin2.geojson")
json

##reading shapefile same as json
ug<- st_read(
  "D:/WORK/Documents/stella/LANDnet/OTHER ACTIVITES 2020/MOOC_GIS_RS/R_Class/uganda_adm2.shp")
# view just the crs for the shapefile
st_crs(ug)
# view just the geometry type for the shapefile
st_geometry_type(ug)
##dataframe
data.frame(ug)
##summary
summary(ug)

##reading my own shapefile
##ug_mine = st_read("D:/WORK/Documents/stella/LANDnet/OTHER ACTIVITES 2020/MOOC_GIS_RS/R_Class/UG.shp")
# view just the crs for the shapefile
##st_crs(ug_mine)
##viewing class
##class(ug_mine)
##extent
##extent(ug_mine)
##summary
##summary(ug_mine)
##plotting data
##plot(ug_mine)

##READING SPATIAL POLY 
UG <- readOGR("D:/WORK/Documents/stella/LANDnet/OTHER ACTIVITES 2020/MOOC_GIS_RS/R_Class/UG.shp")
class(UG) ##Onetobe used
##plotting data
plot(UG)

##reading json from own polygon
##ug_json= fromJSON(file="UG_1.geojson")
##ug_json
# view just the crs for the shapefile
##st_crs(ug_json)
##viewing class
##class(ug_json)
##extent
##extent(ug_json)
##summary
##summary(ug_json)


##choice to work with Kampala alone
##kampala<- st_read(
## "D:/WORK/Documents/stella/LANDnet/OTHER ACTIVITES 2020/MOOC_GIS_RS/R_Class/KAMPALA.shp")
# view just the crs for the shapefile
##st_crs(kampala)
##summary(kampala)
##converting crs
##kampala_1 <- spTransform(kampala, CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"))
##kampala_1

##setting aoi
set_aoi(UG)

## Define time range and platform
time_range <-  c("2019-01-01", "2019-12-31")
platform <- "Sentinel-2"

##Login to hub
login_CopHub(username = "wavamunno") #asks for password or define 'password'
set_archive("D:/WORK/Documents/stella/LANDnet/OTHER ACTIVITES 2020/MOOC_GIS_RS/R_Class")

## Using getSentinel_query to search for data (using the session AOI)
sen <- getSentinel_query(time_range = time_range, platform = platform)

## Getting an overview of the records
View(sen) #get an overview about the search records
colnames(sen) #see all available filter attributes
unique(sen$processinglevel) #use one of the, e.g. to see available processing levels

## Filter the records
sen_filtered <- sen[which(sen$processinglevel == "Level-1C"),] #filter by Level

## Preview a single record
getSentinel_preview(sen_1 = sen_filtered[5,])

## Download some datasets
datasets <- getSentinel_data(sen = sen_filtered[c(4,5,6),])

## Make them ready to use
datasets_prep <- prepSentinel(datasets, format = "tiff")

## Load them to R
r <- stack(datasets_prep[[1]][[1]][1]) #first dataset, first tile, 10m resoultion
