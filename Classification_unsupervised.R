library(rjson)
library(maps)
##library(leaflet)
##library(geojsonio)
library(sen2r)
library(sf)
library(sp)
library(raster)
library(rgdal)
##library(devtools)
library(RStoolbox)
library(hsdar)
library(rasterVis)
library(rgeos)
library(gdalUtils)
library(RColorBrewer)
library(ggplot2)
library(viridis)

getwd()
setwd("D:/R_Class/sen2two_1/S2A_MSIL2A_20190128T081211_N0211_R078_T35MRU_20190128T105515.SAFE/granules1")
getwd()

##Loading rasters #Reading JP2 Raster

b2 <- readGDAL('T35MRU_20190128T081211_B02_10m.jp2')
summary(b2)
b3 <- readGDAL('T35MRU_20190128T081211_B03_10m.jp2')
b4 <- readGDAL('T35MRU_20190128T081211_B04_10m.jp2')
b8 <-readGDAL('T35MRU_20190128T081211_B08_10m.jp2')

#Convert to .tiff
gdal_translate("T35MRU_20190128T081211_B03_10m.jp2", "b02.tif")
 
gdal_translate("T35MRU_20190128T081211_B03_10m.jp2", "b03.tiff")  
gdal_translate("T35MRU_20190128T081211_B04_10m.jp2", "b04.tiff") 
gdal_translate("T35MRU_20190128T081211_B08_10m.jp2", "b08.tiff")
b2 <- readGDAL("b02.tif")
b3 <- readGDAL("b03.tiff")
b4 <-readGDAL("b04.tiff")
b8 <- readGDAL("b08.tiff")


#reintroducing them as rasters
b2_1 = raster(b2)
b2_1
summary(b2_1)

b3_1 = raster(b3)
b3_1

b4_1 <- raster(b4)
b4_1

b8_1 <- raster(b8)
b8_1

##coordinate reference system (CRS)
crs(b2_1)
class(b2_1)
dim(b2_1)
nlayers(b2_1)
compareRaster(b2_1,b3_1)

#Stacking
s <- stack(b8_1, b4_1, b3_1)
s
plot(s)
plotRGB(s, axes = TRUE, stretch = "lin", main = "Sentinel False Color Composite")

tru<- stack (b4_1, b3_1, b2_1)
tru
plotRGB(tru, axes = TRUE, stretch = "lin", main = "Sentinel Tru Color Composite")

##plotting stacks 
par(mfrow = c(1,2))
plotRGB(s, axes = TRUE, stretch = "lin", main = "Sentinel False Color Composite")
plotRGB(tru, axes = TRUE, stretch = "lin", main = "Sentinel Tru Color Composite")

# select first 3 bands only
subset1 <- s[[1:3]]

nlayers(s)
nlayers(subset1)

##extent(s)
writeRaster(s, filename="southone.tiff", overwrite=TRUE)

# For Sentinel NIR = 8, red = 4.
#vi2 <- function(x, y) {
#  (x - y) / (x + y)
#}
#ndvi <- overlay(s[[b8_1]], s[[b4_1]], fun=vi2)

# calculate NDVI using the red (band 1) and nir (band 4) bands
ndvi <- (s[8] - s[4]) / (s[8] + s[4])
ndvi
##plot(ndvi, col=rev(terrain.colors(10)), main="sentinel-NDVI")



# convert the raster to vecor/matrix
sv <- getValues(s)
str(sv)

##unsupervised classfication
set.seed(99)
kmncluster <- kmeans(na.omit(s), centers = 10, iter.max = 500, nstart = 5, algorithm=
                       "Lloyd")

