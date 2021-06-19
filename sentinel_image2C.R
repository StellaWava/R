devtools::find_rtools()
install.packages("devtools")

## Filter the records
records_filtered <- records[which(records$processinglevel == "Level-1C"),] #filter by Level

## Preview a single record
getSentinel_preview(record = records_filtered[5,])

## Download some datasets
datasets <- getSentinel_data(records = records_filtered[c(4,5,6),])

## Make them ready to use
datasets_prep <- prepSentinel(datasets, format = "tiff")

## Load them to R
r <- stack(datasets_prep[[1]][[1]][1]) #first dataset, first tile, 10m resoultion

