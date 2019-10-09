### Davis R Users Group: Teaching R Live Code
### R. Peek
### https://tinyurl.com/teachingR


### FYI: This is a frequently updated R script used for "live-coding" while teaching. Contents may be removed/altered/changed and saved to the Davis R Users Group website: https://d-rug.github.io/ 


# Intro to Vectors & Data Types -------------------------------------------
# see this site for details on lesson: https://datacarpentry.org/R-ecology-lesson/01-intro-to-r.html


# can use R as a calculator, follows order of operations
3 + 4 -3 * 9 / 2


# Intro to Assignment -----------------------------------------------------

weight_kg <- 55

# to print to console or return a result/output

(weight_kg <- 55)

weight_kg

2.2 * weight_kg

# convert to pounds
weight_lb <- 2.2 * weight_kg


# use objects in your calculations
weight_kg * weight_lb

# Challenge
mass <- 47.5            # mass?
age  <- 122             # age?
mass <- mass * 2.0      # mass?
age  <- age - 20        # age?
mass_index <- mass/age  # mass_index?


# Intro to Functions ------------------------------------------------------

# functions have arguements
sqrt(age) 
sqrt(x = age) # can be explicit when mult arguments
sqrt(age, mass, weight_kg) # won't work because too many things given to function (only one value required)

# using round with multiple arguements
round(3.14)
round(x = 3.14, digits = 1)
round(digits = 1, x = 3.14)


# Vectors -----------------------------------------------------------------

# make a vector of numbers
weight_g <- c(50, 60, 65, 82)

# remove something from environment
rm(weight_g)

# vector of characters
animals <- c("elephant", "frog", "dog", "raccoon", "lizard", "turtle")

# indents and spaces are personal style
animals <- c ("elephant",
              "frog",
              "dog",
              "raccoon",
              "lizard", 
              "turtle")

animals <- c(cat, rat, dog) # won't work because not quoted, and these objects aren't environment

# data classes or "types"
class(animals)
class(weight_g)

# basic types are Logical, Integer, Numeric, Character, and Factors

# logical
truefalse <- c(TRUE, FALSE, TRUE, FALSE, TRUE)

# as.integer
as.integer(truefalse) # returns numbers

as.integer(animals) # returns NA

# mixed vectors
mixed_vector <- c("dog", TRUE, 3, 4, "FALSE")
mixed_vector # turns all to character (most common denominator)

# this mixes logical and numeric
vector_2 <- c(TRUE, 3, 5, 6, 7, FALSE)
class(vector_2)

# mixes character and integer
tricky <- c(1, 3, 4, "5")
class(tricky)

# Factors -----------------------------------------------------------------

# make a vector
himedlo <- c("HIGH", "MED", "LO")
class(himedlo) # data class

# turn character vector into factor
himedlo <- factor(himedlo)
levels(himedlo) # levels are mixed up!

# to fix, we can explicitly assign levels for our variables
# make sure same number of levels provided as in vector
himedlo <- factor(x = himedlo, levels = c("HIGH", "MED", "LO"))
levels(himedlo)

# character vector turns to NA
as.integer(animals)

# factor vector turns to numbers
as.integer(himedlo)


# SUBSETTING --------------------------------------------------------------

# only want first two animals in vector
animals
animals[2]
animals[1:2]
animals[1,2] # doesn't work because we don't have multiple rows/columns in a dataframe
animals[c(1,2)] # looking for list inside my list

animals[c(6, 1)]
subset_animals <- animals[c(6, 1)]

