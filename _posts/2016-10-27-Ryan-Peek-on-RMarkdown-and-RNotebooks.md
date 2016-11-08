---
title: "Ryan Peek on RMarkdown and RNotebooks"
author: "Ryan Peek"
tags: [D-RUG, R, presentations, Rmarkdown, rnotebooks]
date: "16-10-13 13:00:00"
layout: post
---

[Ryan Peek](https://ryanpeek.github.io/) talked to us about RMarkdown and new R notebooks, which comes with the [latest release](https://blog.rstudio.org/2016/11/01/announcing-rstudio-v1-0/) of the RStudio IDE.

The video of the talk is [here]((https://www.youtube.com/watch?v=_Fgx229pWi8&feature=youtu.be)), and full materials accompanying the talk can be found at the [github repo](https://github.com/ryanpeek/rmarkdown_notebook_demo/blob/master/Rmd/notebook_demo.Rmd).

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)

## This line is amazing and I will tell you why...it helps when knitting externally so you can still interactively run code with root paths!

knitr::opts_knit$set(root.dir = normalizePath("../")) 

## NOTE: This only works for paths INSIDE of code chunks

```

# RMarkdown

Rather than go through every detail of RMarkdown and it's wonderfully simple but extensive functionality, I'd rather **bewilder** you with a bunch of examples, give you some examples you can play with, and include a lot of links you can check out on your own time. 

![Bewildered yet?](../imgs/woodybewildered.gif) 

<!--Notice this path still requires the *../* because it is outside of a code chunk-->
<!--Also notice this is a trick to add notes in the RMarkdown that will not show up in the "*knitted*" version of-->

# What is an RNotebook?

The main difference between an RMarkdown file (*`.Rmd`*) and a RNotebook file is the output. Notice in the `yaml` header there is a new output option? You can string these options together to output as multiple types. The main thing you'll see is a new file next to the `.Rmd` file, with a **`.nb.html`** extension. There are a few important things to know about **`.nb.html`** files.

![figure](../imgs/yaml_example.png)

## Using **`.nb.html`** Files

When saving, RStudio will produce or "knit" a *self-contained HTML file* which contains both a rendered copy of the notebook with all current chunk outputs (suitable for display on a website) and a copy of the notebook .Rmd itself.

### Pros  

 - Can view **`.nb.html`** file with any web browser!
 - Can be saved and shared easily!
 - Can be opened in RStudio **AND**....
    - When opened RStudio takes the **`.nb.html`** and extracts the original `.Rmd` file and places it alongside the `.nb.html` file.
    
### Caveats

 - Remember this only works if you created or saved an *RNotebook*. 
 - The new dev version of RStudio will still do inline chunk output, but doesn't produce the `.nb.html` unless you specify `html_notebook` in the yaml output.

## Code Chunks

When inserting and running code chunks in `.Rmd` files, you can can add controls for many things. In RNotebooks, this extends to some nice options to show/hide code in the html file.

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

**Play with the Code chunk options**

```{r cars plot again again again, echo=TRUE}

plot(cars, pch=21, col="black", bg="maroon")

```

```{r, eval=TRUE, echo=FALSE}

plot(cars, pch=21, col="black", bg="maroon")

```

```{r, echo=TRUE, fig.align='center', fig.subcap="A lot of Speed vs. Distance", fig.cap="Yet Another Cars Plot", fig.width=7}

plot(cars, pch=21, col="black", bg="salmon", cex=1.5)

```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file).



## HexMaps and The Electoral College

Since it's relevant and I like working with maps, let's play with some electoral maps. The electoral system is weird, but it's what we've got. The current [electoral college](https://www.archives.gov/federal-register/electoral-college/allocation.html) votes are doled out based on census data (except Washington D.C. which gets 3... just because). So, when mapping, if you were to plot the states by geographic size, or spatial components, it tends to completely skew the actual distribution of votes. So, using hexagonal tiles is a nice way to get around this. Many examples of using tiles exist, but I'll show a quick example. 

If you are interested in a few other options, check out ([statebins](https://www.r-bloggers.com/geojson-hexagonal-statebins-in-r/), [tilegramR](https://github.com/PitchInteractiveInc/tilegrams/blob/master/MANUAL.md) and this great [post](http://rpubs.com/bhaskarvk/electoral-Map-2016).

Let's take a look!


```{r hexstatebins, eval=F, echo=T, message=FALSE, error=FALSE}
# Load packages
library(rgdal)
library(dplyr)
library(ggplot2)
library(maptools)
library(rgeos)
library(sp)
library(viridis)

load(file = "data/state_DF.RData")

ogrInfo("data/us_states_hexgrid.geojson", "OGRGeoJSON")
us <- readOGR("data/us_states_hexgrid.geojson", "OGRGeoJSON")

# add XY for centroid to use for labels
centers <- cbind.data.frame(data.frame(gCentroid(us, byid=TRUE), id=us@data$iso3166_2))

# join w state data:
us<-merge(us, stateDF, by.x="iso3166_2", by.y="state.abb")
us_map <- ggplot2::fortify(model = us, region="iso3166_2")

# Plot Hex US Map
gg <- ggplot() + geom_map(data=us_map, map=us_map,
                    aes(x=long, y=lat, map_id=id),
                    color="white",fill="#ffffff", size=0.5) +
  # this is the white outline
  geom_map(data=us@data, map=us_map,
           aes(map_id=iso3166_2),
           fill="#ffffff", alpha=0, color="white",
           show.legend = FALSE)+
  # this is the fill (mean number of days with min temperature below freezing (1931–1960) in capital or large city)
  geom_map(data=us@data, map=us_map,
                    aes(fill=Frost, map_id=iso3166_2))+
  coord_map() + scale_fill_viridis() + 
  # the state label for each
  geom_text(data=centers, aes(label=id, x=x, y=y), color="white",
            size=4, show.legend = F) + 
  theme_bw() + labs(title="Mean # Days with Frost in State Capital  (1931-1960)", x=NULL, y=NULL) +
  theme(panel.border=element_blank(),
        panel.grid=element_blank(), 
        axis.ticks=element_blank(),
        axis.text=element_blank())
gg


# save it!
#ggsave(filename = "./imgs/hexUS_Map.png", dpi = 200)

```
I'm including the raw path to an image here but it's not evaluating:

`![hexMap_brokenpath](imgs/hexUS_Map.png)`

## Add a Leaflet Map

You can also embed leaflet maps within your notebook, and they can be shared via html. This is a nice way to provide dynamic spatial data.

Let's look at where there are California snow course stations (check out the [CDEC website](http://cdec.water.ca.gov/snow/current/snow/index.html)). There's a nice package called "**`sharpshooter`**" we can use to pull the locations and metadata for all these stations and plot them with a `leaflet` map.

```{r leafletmap, fig.width=7}

library(sharpshootR)  # CDEC.snow.courses, CDECquery, CDECsnowQuery
library(leaflet)

# GET DATA AND PREP 

data(CDEC.snow.courses)
snw<-CDEC.snow.courses

# make a few changes for plotting purposes
snw$id<-as.factor(snw$id)
snw$latitude<-as.numeric(snw$latitude)
snw$longitude<-as.numeric(snw$longitude)*-1
snw$apr1avg_in<-snw$april.1.Avg.inches
snw<-dplyr::select(snw, course_number, id, elev_feet:longitude,apr1avg_in)
str(snw) # check out data

# add color palette
pal <- colorNumeric(
  palette = "GnBu",# can change to whatever: "RdBu", "GnBu"
  domain = snw$apr1avg_in
)


# Make a leaflet map!
m <- leaflet() %>% addTiles() %>% 
  #setView(lng = -120.8, lat = 39, zoom = 8) %>%  # set to Auburn/Colfax, zoom 5 for CA 
  addTiles(group = "OSM") %>%
  addProviderTiles("Esri.WorldImagery", group = "ESRI Aerial") %>%
  addProviderTiles("Thunderforest.Landscape", group = "Topo") %>%

# proposed sites
addCircleMarkers(data=snw, group="CDEC Snow",
                 lng= ~longitude, lat= ~latitude,
                 popup=paste0("<strong>","Course ID: ","</strong>", 
                              snw$course_number, "<br><strong>", "Name: ",
                              "</strong>", snw$id, "<br><strong>", "Elev (ft): ",
                              "</strong>", snw$elev_feet, "<br><strong>", 
                              "Apr-1 Avg: ", "</strong>", snw$apr1avg_in),
                 stroke=TRUE, weight=0.6,radius=8,
                 fillOpacity = 0.5, color="black",
                 #fillColor= ~ifelse(snw$elev_feet>=7500, "skyblue", "yellow")) %>%
                 fillColor= ~pal(apr1avg_in)) %>%

  # add controls for basemaps and data
  addLayersControl(
    baseGroups = c("OSM", "ESRI Aerial", "Topo"),
    overlayGroups = c("CDEC Snow"),
    options = layersControlOptions(collapsed = T))

print(m)

```



## Writing Manuscripts

This gets a little more interesting. You can fairly easily add citations by including a bibliography (.bib) file into the `yaml` header. Track changes similar to what is used in Word type documents is not as easy, though the advent of github has made it very easy to see what *diffs* exist, and I know some folks have had pretty successful piplelines using Rmd and github.

A nice post about this process over at Steven Miller's [blog](http://svmiller.com/blog/2016/02/svm-r-markdown-manuscript/). Same place that I've pulled my [markdown CV](https://github.com/ryanpeek/markdown_cv) template from.

#### UPDATE: 

Also someone just pointed out a great resource for this sort of thing, check it out, it has templates, and a really nice pipeline for writing.

 > http://plain-text.co


## Using a Bibliography

This is one of the key tricks, which for folks coming from EndNote, it does involve a bit of an extra step or two. I'll talk a bit about that briefly. To include citations, you can simply add a *".bib"* file, and then in the text you use this format to call the citations based on a shortID or code `[@Session2016, @Ababneh2010]`.

For example, if you wanted to say, you read this stuff [@Acreman2004 or @Ababneh2010], and also these papers [@Ackerman2013; @Acs1993], it would then pop up at the end of your document. (below this section)

A couple notes on software, [**Zotero**](https://www.zotero.org/) is free and works well. It will sync/update a bib file that you can pull from consistently. In addition, a software called [**JabRef**](http://www.jabref.org/) is a nice bibfile manager, and provides a nice option to convert EndNote libraries to .bib libraries by adding that Keyword (AuthorYEAR) to each citation. 

## Required Readings


