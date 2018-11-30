---
title: "Michael Culshaw-Maurer: Tips And Tricks In R And Rstudio"
author: "Michael Culshaw-Maurer"
tags: [D-RUG, R, presentations, Tips, Tricks]
date: "18-11-28 10:00:00"
layout: post
---

**_Michael gave good overview of a variety of tips and tricks for customizing R/RStudio_**

## Overview:

>"This tutorial shows some of my favorite keyboard shortcuts, packages, and functions in R and RStudio. My basic criteria for inclusion was anything that made me think “wow I wish I’d learned this 6 months ago”. I keep a running list of these little tips and tricks in a simple R script, and I polished it up (barely) for the talk."

```r

library(tidyverse)
library(random)
library(googlesheets)
library(paletteer)
library(skimr)
library(summarytools)
library(reprex)
library(rvg)
library(officer)
library(ggrepel)
library(beepr)
library(BRRR) # needs to be installed from github, just google it

# I) Keyboard Shortcuts ------------------------------------------------------

# quick note- I have lots of keyboard shortcuts customized, so I will give the *name* of the shortcut. You can search for it in your keyboard shortcuts editor. The shortcuts I have listed are what I have set for my Mac, maybe you'll like em.

# assignment and pipe -----------------------------------------------------

# CMD+, for assignment
# CMD+. for pipe
x <- mtcars %>% ggplot()

# moving tabs + console/source --------------------------------------------

# names of these shortcuts are: "Open Previous Tab", "Open Next Tab", and "Switch Focus between Source/Console"
# CMD+1 for moving to the left tab
# CMD+3 for moving to the right tab
# CMD+2 for back and forth between source and console

# Insert Section ----------------------------------------------------------

# I use CMD+J to insert a section



# Rename in Scope ---------------------------------------------------------

# Cmd+D to select all the copies of the highlighted word, then change them, and it only selects within scope
do_stuff <- function(hammer, nail){
  results = hammer + nail
  results2 = hammer*nail
  results3 = hammer/nail
}

do_stuff
hammer <- 2
sqrt(hammer)
hammer
hammer

hammer_new <- 2
hammer_new


# Increment Number at Cursor ----------------------------------------------

# you can use Shift+Alt+Up or Down to increment numbers, even with multiple cursors

x <- 90
y <- 2.82
z <- 1e23


# Expand to Matching Bracket ----------------------------------------------

# Cmd+R to select everything within the current set of brackets
("some stuff")



# Go to Function Definition -----------------------------------------------

# with your cursor on any function, press fn+F2 to open a file with the definition of the function
dplyr::add_tally()

# Go to File/Function -----------------------------------------------------

# use CTRL+. to search *all* files in projects, including searching for function calls and *objects*


# Fuzzy Autocomplete ------------------------------------------------------

# fuzzy autocomplete: letters only need to be in correct order, doesn't matter if you skip some

hamme

# File Autocomplete -------------------------------------------------------

# file autocomplete: as soon as you're within quotes
""



# Reformat Code -----------------------------------------------------------

# CMD+I just re-indents, but reformatting does this and adds proper white space too, so I switched CMD+I to be a full reformat and SHIFT+CMD+A to be only indenting

mtcars %>%
  ggplot(aes(x = wt, y = mpg)) + geom_point()



# Add Cursor Above/Below --------------------------------------------------

# multiple cursors by holding ALT and dragging mouse or holding CTRL+ALT and moving up or down
x
y2 + y
z
y2 + y
y2 + y

# Call History ------------------------------------------------------------

# in console, use up arrow or CMD+up to look through call history

mtcars %>% 
  ggplot(aes(x=wt, y=mpg)) + geom_point()

# II) Snippets ------------------------------------------------------------



# Time Stamp --------------------------------------------------------------

# type "ts" then hit tab and enter to insert a timestamp
# Mon Nov 26 13:44:49 2018 ------------------------------

# Wed Nov 28 10:41:38 2018 ------------------------------



# Custom Snippet ----------------------------------------------------------

# custom snippet: type ! followed by an expression, then hit SHIFT+TAB
# it'll evaluate that expression and paste the output as a comment into your editor

#0.530195945429039 -0.000282426726310706 1.6947901094657 0.345281246371682 -1.01616632393322
rnorm(5)



!rnorm(100) # now hit SHIFT+TAB
#-1.06864686811451 -2.05023033636044 0.242224431911897 0.182048734007034 0.903831891392053



# III) Useful Packages/Functions ------------------------------------------

# very random order here...




# case_when() instead of lots of if/else ------------------------------------


# Use case_when to create a column with values conditional on other columns

mtcars %>% 
  mutate(
    outcome = case_when(
      cyl == 6| cyl == 8 ~ "big",
      cyl == 4 ~ "small"
    )
  )


# list.tree() -------------------------------------------------------------

# Use Hmisc::list.tree to look at nested lists in a tidy way

# first, split the original dataset according to "am" (automatic or manual)
mtcars2 <- split(mtcars, mtcars$am)
mtcars2

# now we'll split each of our two branches up again, this time by "gear"
mtcars2$`0` <- split(mtcars2$`0`, mtcars2$`0`$gear)
mtcars2$`1` <- split(mtcars2$`1`, mtcars2$`1`$gear)

Hmisc::list.tree(mtcars2, depth = 4)

Hmisc::list.tree(mtcars2, depth = 3)
Hmisc::list.tree(mtcars2, depth = 4)


# dput() ------------------------------------------------------------------

# use dput() to create an object "from scratch". It will be output to the console, you can just copy-paste it from there into code to make an easily reproducible object, which is great for minimal examples

# just be careful with really weird objects, stick to simpler ones

dput(head(mtcars))

mt_head <- structure(list(mpg = c(21, 21, 22.8, 21.4, 18.7, 18.1), cyl = c(6, 6, 4, 6, 8, 6), disp = c(160, 160, 108, 258, 360, 225), hp = c(110, 110, 93, 110, 175, 105), drat = c(3.9, 3.9, 3.85, 3.08, 3.15, 2.76), wt = c(2.62, 2.875, 2.32, 3.215, 3.44, 3.46), qsec = c(16.46, 17.02, 18.61, 19.44, 17.02, 20.22), vs = c(0, 0, 1, 1, 0, 1), am = c(1, 1, 1, 0, 0, 0), gear = c(4, 4, 4, 3, 3, 3), carb = c(4, 4, 1, 1, 2, 1)), row.names = c("Mazda RX4", "Mazda RX4 Wag", "Datsun 710", "Hornet 4 Drive", "Hornet Sportabout", "Valiant"), class = "data.frame")

mt_head

# dump() does something similar, but writes it to a file


# truly random numbers ----------------------------------------------------

# the "random" package accesses random.org, which gets true random numbers from atmospheric noise
library(random)
randomNumbers()
randomSequence()

# googlesheets ------------------------------------------------------------

# use googlesheets package to pull data directly from Google Sheets
library(googlesheets)

my_sheets <- gs_ls()


# paletteer ---------------------------------------------------------------

# use the paletteer package to get LOTS of palettes
library(paletteer)

paletteer::palettes_d_names

my_palette <- paletteer_d(package = "palettetown", palette = "cubone")
barplot(rep(1,14), axes=FALSE, col=my_palette)

# data summary packages ---------------------------------------------------

# use skimr and summarytools to look at your data
library(skimr)
library(summarytools)
skim(mtcars)
dfSummary(mtcars)
view(dfSummary(mtcars))
summary(mtcars[1:15,])

# reprex ------------------------------------------------------------------

library(reprex)

# use reprex() to make a reproducible example
# copy the following two lines of code
(y <- rnorm(10))
mean(y)

# now call reprex()
reprex()

# now paste, and you'll have the Markdown to generate your example

# copy the code again, and call the following to format for StackOverflow
reprex(venue = "so")


# %||% --------------------------------------------------------------------

# use tidyverse's %||% to only use LHS if it's not NULL
x <- NULL
y <- 2
z <- 5
y %||% z
x %||% z
# it returns the LHS if it's not NULL, and if the LHS is NULL, it returns the RHS




# make ppt graphics -------------------------------------------------------

# this one is incredible- you can use rvg to make *editable* graphics in a ppt slide
library(rvg)
library(officer)

p <- mtcars %>% ggplot(aes(x=mpg)) + geom_histogram()
p

doc <- read_pptx()
doc <- add_slide(doc, layout = "Title and Content", master = "Office Theme")
doc <- ph_with_vg(doc, code = print(p), type = "body")
print(doc, target = "my_plot.pptx")



# ggrepel labels ----------------------------------------------------------

library(ggrepel)
mtcars %>% 
  ggplot(aes(x=wt,y=mpg)) +
  geom_point() +
  geom_text_repel(aes(label = rownames(mtcars)), size = 2)


# warning sounds ----------------------------------------------------------

library(beepr)
beep()

library(BRRR)
BRRR::skrrrahh(sound = 36)


# expand.grid() -----------------------------------------------------------

# generate a dataframe with every combination of your listed variables
expand.grid(N = c(10, 100, 1000), delta = c(0, .2, .5), alpha = c(.05, .005))

# %in% --------------------------------------------------------------------

# use %in% to see if values are in another vector

x <- "a"
x %in% c("b", "b", "c", "d")

y <- c("b", "a")
y %in% c("b", "b", "c", "d")


# custom functions from Ryan Peek ----------------------------------------------

# custom functions to open a finder window to current directory
.envomac <- function(...) if(Sys.info()[1]=="Darwin") system("open .")
.envowin <- function(...) if(Sys.info()[1]=="Windows") shell(cmd="explorer .", intern=F, wait=F)
.envomac()

```



## Materials

Materials used in the presentation can be viewed at this [link](https://mcmaurer.github.io/tips-and-tricks-in-r-and-RStudio/)