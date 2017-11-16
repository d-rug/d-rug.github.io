library(raster)
library(rgdal)
library(sp)
library(stringr)
# We are going to extract annual average rainfall in Tanzania 
# for all years (that we have data for) of Tanzania 
# We are using a raster data that covers Tanzania and more and has monthly data 
setwd("C:/Users/Kate/Dropbox/R_data")
#Read in Raster data

path <- "DRUG/data/prec"

# get a vector of all the relevant files
ff <- list.files(path, pattern='.tif$', full.names=TRUE)

#read in the first in list of rasters
s <- raster(ff[1])

#check out the attributes
s
#things you might be interested in:
#dimensions: "size" of the file in pixels * nrow, ncol: the number of rows and columns in the data (imagine a spreadsheet or a matrix). * ncells: the total number of pixels or cells that make up the raster.
#resolution: the size of each pixel (in meters in this case). 1 meter pixels means that each pixel represents a 1m x 1m area on the earth's surface.
#extent:the spatial extent of the raster. This value will be in the same coordinate units as the coordinate reference system of the raster.
#coord ref: the coordinate reference system string for the raster
#values: min max 

#plot your new friend
plot(s)

#get extent 
extent(s)

#maybe you'd like to know about the values
freq(s)
#maybe plot them
hist(s)


#Reproject your data to match
reprojectedData1 <- projectRaster(s, 
                                  crs="+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs ")

#you'd like to clip it maybe?
tza <- getData('GADM', country='tza', level=1)
plot(tza)
#check to make sure it matches raster crs
crs(tza)

#use mask to "clip" to polygon
ss <- mask(s, tza)
plot(ss)

#reading in a raster stack
sg <- stack(sort(ff))

#should see 132 layers
sg
# let's plot
plot(sg)
# (by default, only the first 16 are plotted)

# plot the first three:
plot(sg[[1:3]])

#maybe you're interested in the mean for each month
rainmonth <- stackApply(sg, 1:12, mean)

# set the names for each month
names(rainmonth) <- month.name

rainmonth
plot(rainmonth)

# compute the annual average total rainfall
rain <- sum(rainmonth)
plot(rain)


#sum of rainfall for each year - how has it changed over time?
rainyear <- stackApply(sg, rep(1:11,each = 12), sum)

#independent variable == time
time <- 1:nlayers(rainyear) 

#function to perform a regression of raster cell ~ time, return the betas for each cell
fun1 <- function(x) { 
  if (is.na(x[1])) { 
    NA 
  } else { 
    m = lm(x ~ time) 
    m$coefficients[2] 
  } 
} 
#Calc to apply any function - this takes forever, fyi
e2 <- calc(rainyear, fun1)
#view
e2
#plot your raster of betas
plot(e2)

# and the monthly mean precipitation averaged over all cells - cellStats is helpful!
mrain <- cellStats(rainmonth, mean) 
barplot(mrain) 

#Rasterize your point data
data("meuse")
#make it spatial w coordinates
coordinates(meuse) <- ~x+y
#make a blank raster w 100 cells
rast <- raster(ncol = 10, nrow = 10)
#make it the same extent as your spatial point data
extent(rast) <- extent(meuse)
#add random values to your raster - this is really just for plotting
rast[] <- runif(10) 

#rasterize your points - take the average copper for each cell
gg <- rasterize(meuse, rast, meuse$copper, fun = mean)

#get simple prensence/absensce (NA) (is there a point or not?)
r1 <- rasterize(meuse, rast, field=1)
#plot
plot(r1)

# how many points in each cell?
r2 <- rasterize(meuse, rast, fun='count', field=1)
#take a gander
plot(r2)

##Rasterize your awesome polygons 
data(meuse.riv)
#make the river points into polygons
meuse.sr = SpatialPolygons(list(Polygons(list(Polygon(meuse.riv)),"meuse.riv")))
rr <- rasterize(meuse.sr, rast, getCover=TRUE) #will give you a percent cover for each cell - 1-100

plot(rr)
#Other stuff you might want to do
#focal functions

#reclassify/replace your raster cell values: 
#reclassify(rr, c(0,2,1,  2,5,2, 4,10,3))

#calculate some functions - NAs where x is greater than 4, otherwise x
#s <- calc(rr, fun=function(x){ x[x < 4] <- NA; return(x)} )