---
title: "Myfanwy Johnston on Unit Testing"
author: "Myfanwy Johnston"
tags: [D-RUG, R, presentations, unit testing, code, workflow]
date: "17-01-19 13:00:00"
layout: post
---

Back in November of 2016, D-RUG Co-Coordinator [Myfanwy Johnston](www.voovarb.com) gave a presentation on unit testing in R.  From Myfanwy:

   *"This is a short presentation about unit testing (and really code testing in general).  Testing is an incredibly important aspect of coding that often gets skipped over by us non-software development types.  My goal is for you to walk away with a good understanding of the thinking process behind good testing.  I also hope to convince you that testing is not only in your best interest, but is also waaaay easier to integrate with your existing workflow than you might think."*

![from xkcd.com](http://imgs.xkcd.com/comics/exploits_of_a_mom.png)

Here's the video!  The GitHub repo for this talk can be found [here](https://github.com/Myfanwy/UnitTesting_drug).  


<iframe width="560" height="315" src="https://www.youtube.com/embed/8G6bBum3O9A" frameborder="0" allowfullscreen></iframe>

# Introduction

Not all types of people who code are going to use the same approach for debugging and testing.  The best practices for software development are not going to be the same as the best practices for someone doing scientific analyses.

Unit testing by itself is a simple concept.  Unit tests are short, (usually automated) programmatic tests that are applied to a small unit of your code.  Depending on the context, the "unit" in question could be a check on the class of an input variable for an argument of a function, or it might test the entire function.  Testing goes hand-in-hand with the large topic of debugging, which we will not cover here.  That said, some tools and functions from debugging in R (like assert statements) overlap with good testing practices, and we'll be making use of them.

First, we'll introduce the concept of Test-Driven Development (TDD) and its adjacent approaches.  Then we'll talk about how you might integrate these approaches into your own scientific workflow.  I'll close with a short example of a testing workflow from my own research.

```{r setup, message=FALSE, echo=FALSE}
library(tidyverse)
library(testthat)
library(assertthat)
```

# Types of Tests

#### 1. Smoke tests

Does the program run?

#### 2. Unit tests

Programmatic tests that evaluate a unit of your code at a low level.  These tests are small bits of code that can often be automated.  Most of the tests you create will probably NOT be unit tests by the strictest definition.

#### 3. Functional tests

User-facing tests that see if the code actually does what you want it to do.  Functional tests are what you'll be writing most of the time.

#### 4. Regression Tests

Tests to verify that code previously developed and tested still works after you've changed it (either to make it better or to handle a bug you encountered).

# What is Test-Driven Development (TDD)?

Test-Driven Development is a comprehensive suite of automated tests to specify the desired behaviour of a program and to verify that it is working correctly. The goal is to have enough, sufficiently detailed tests to ensure that when they all pass we feel genuine confidence that the system is functioning correctly.

The workflow for TDD is to write the test BEFORE you write the code.

"Red-Green-Refactor"

    * Red: create a test and conceive of code (or data) that would fail that test
    * Green: make the code pass that test by any means necessary
    * Refactor: look at the code you've written, and ask yourself if you can improve it.  Run the tests again after each code change to make sure they still pass - if not, start again with "Red".
    
TDD is the most well-developed in the field software development.  As scientists we're a bit removed from this development process, and not all practices will apply to our analyses or our workflow.

# What is Test-Driven Data Analysis (TDDA)?

TDDA gets closer to what we as scientists might do in a perfect world.  The short answer is that TDDA is a set of useful practices, tools and processes involved in testing code that is used in scientific analyses. TDDA helps you test all aspects of your analysis through the testing of your code, including but not limited to inputs, outputs, algorithms, references, and results.

TDDA strives to get you to write tests that validate whether the result you have produced means what you think it means.  Has your data led you to make errors of interpretation when you get your results?

 - Given the results, do you believe your inputs are correct?
 - How will your code handle null values?  Missing values?
 - Will outliers (like extremeley large or exremely small values) or invalid inputs invalidate the calculation?
 - If the values have dimensionality, do they all need be of the same dimensions?  Or in the same units?
 
     In plain terms, every time you view an analytical result, you should be asking:
     "_Why is this lying bastard lying to me?_"
     or
     "_How is this misleading data misleading me?_"
     ...and then writing tests that will boost your confidence that you haven't been hoodwinked the same way twice by your data.

[TDDA is a complex topic under active development](www.tdda.info/), and you should take the time to explore it both for your own cognitive benefit and for that of your work.



# What is Stupidity-Driven Development?

If TDDA is the ideal, SDD is more like the reality on the ground for people who write scientific code.

####"For research purposes, we're much more worried about inaccurate research results than we are about crashing bugs. The latter are annoying and obtrusive, but don't result in erroneous results; inaccurate code causes much less visible problems that can be more serious scientifically. So we test the bejeezus out of our scientific code while practicing a kind of long game with the rest of the code: we wait until there are actual behavioral problems that we can trace back to some bit of source code, and then we fix it." - C. Titus Brown

Testing in a Stupidity-Driven Development framework is more about writing lots of tests for the scientific core of the code, and writing far fewer tests for other project components (if you're working in R, it's possible you might not even HAVE any of these project components).  

A sample SDD workflow is:

1. Write tests for the obvious potential issues you can think of (more on the specifics of this later)
2. Write the code and run your data through it
3. When bugs are encountered, write tests to fix the observed bug
4. Get on with more important things

SDD avoids wasting time writing tests for bugs that never appear, or appear rarely and  don't affect correctness of results.  Our order of priorities in SDD is: 1) Correctness 2) Performance 3) User experience 4) Beautiful code



# Where Do Tests Live?

Where your tests live in your code will depend on when you need the tests to run.  

If a test needs to be run every time a certain function is called (we'll call these "run-time" tests), the test should live in-line with the code of the actual function.

If a test needs to be run to make sure the code hasn't broken after you've changed something, the test should live in its own test file (and associated test data files) in a separate directory.  We'll call these "test-time" tests.

This might sound confusing, so let's dive in to some examples.


# "Run-Time Tests"

Run-time tests are user-facing.  They're often unit tests in the strictest sense - they check small bits of code in the function, like input structures and formats.  They make small assessments and either throw an error or a warning message.  

Typically, run-time tests make use of assert statements, which are functions that check whether some condition is true.  If code is run that makes the condition untrue, the assert statement function will throw an error.

An example of a function in R that makes assert statements is `stopifnot()`.


### Examples basic types of run-time unit tests:

```{r}

# Tests in-line in an R script:
x <- 5
y <- x^2
stopifnot(y >=0) # evaluates just fine, because the condition that y is non-negative is met

x <- 2*1i
y <- x^2
stopifnot(y >=0) # throws an error, because the condition that y is non-negative is NOT met

# in a function:

# A function to convert dimensions in pixels to mm:

tomm <- function(width, height, dpi = 300) {
 stopifnot(is.numeric(width))
  stopifnot(is.numeric(height))
widthout = (width * 25.4) / dpi
heightout = (height * 25.4) / dpi
return(c(widthout, heightout))
}

tomm(width = 1300, height = 3000) # runs fine
tomm(width = 1300, height = "3000")

```


### The `assertthat` and `assertr` packages

The package `assertthat` replaces `stopifnot()` and provides a number of user-friendly assert functions.

The package `assertr` is great for error-checking your data; these functions are good for either run-time tests or test-time tests.

### `assertthat::assert_that()`
```{r}
tomm <- function(width, height, dpi = 300) {
  assert_that(is.numeric(width))
  assert_that(is.numeric(height))
widthout = (width * 25.4) / dpi
heightout = (height * 25.4) / dpi
return(c(widthout, heightout))
}

tomm(width = 1300, height = "3000")# you can see that assertthat's error message is little a bit more informative

```

###`assertr::verify()`

Use case: you're reading in a data file that you know has more than 100 observations but you want to make sure it imported all of them.

```{r}
library(assertr)
dat <- read.csv("a-data-file.csv")
dat %>%
  assertr::verify(nrow(.) > 100)
```


# "Test-Time" Tests

These are the tests you want to write before you write your actual code.  They're the ones that ask "what do I want my function to do?"  "What should the output of my function actually be like?"  

Test-time tests live in their own test files, the names of which should begin with "test".  The package `testthat` (along with the `devtools` package development tools) provides the best directory structure and convenience functions for writing test files.

These tests will be run only occasionally.  Typically, they'll be run once when you first write the code, and then again when you change any part of the code to make sure your code is still passing all its tests.


# The Testing Workflow for Scientists (continued from SDD above)

Thinking of how to write a test that answers the questions above is daunting, but you're about to make it really easy on yourself.  Here's how:

   * Take a tiny sample of your data.  Five rows (or observations) is a good start.

   * Write your function with those five observations in mind.  Try to make the observations as representative as possible of the full dataset that you would put through this function.  
   
   * See if the function worked the way you want it to for those observations (the output for 5 observations will probably be small enough to allow you to inspect the output of the function "by hand", or visually).

  * If the output is what you expected it to be, congratulations!  You've just written your first test, which, at least initially, is identical to your function.
  
  * Think of ways you can trip up your function.  What happens if you feed it 5 null observations?  Does it throw an error, or is it silent?  Is the error intelligible?  You've just written your second test.  If it failed (doesn't throw an error with null data, for example), it's time to change your code (maybe adding a runtime test for null values like `assertthat::assert_that(not_empty(x))` or `assertr::verify(x > 0)`).  Then run your first test again and make sure it still passes.
  
  * Now do your work.  Inevitably, you're going to observe some weird behavior from your function that you didn't anticipate.  When that happens, you've encountered a bug in your code, and it's time to go through the debugging process (not covered here, sorry), figure out what's causing the weird behavior, and...
  
  * write another test with small dummy data that simulates the data that caused the bug (re-create the bug with a test).
  
  * Change your code to address the bug so that your new dummy data test passes.
  
  * Run all your other tests to make sure you haven't re-created old bugs in the fixing of your new bug.
  
  * Go back to the "do your work" step.  Rinse, repeat.
  


# Sample workflow with fishtrackr functions

We wrote the code with the data structure I already had (raw .csv of data).
 
Later, I put in data that had the same essential information, but was missing some columns I had written in to the original function.  It threw a missmatching length error that I then had to painfully debug.
 
So we threw in some assert statements that should have been there to begin with, and they stopped the function whenever a missing input was detected.
 
Later, I realized I could just write the function so that it carries along ALL the columns of the input data, regardless of nit-picky names or dimensions.


I re-wrote the function with this (better) code, and ran it again with three different dummy test data types:

 One that included just the original columns
 One that had extra columns
 One that had fewer columns than the original data
 
These can be written as three different tests within the same testfile.

Since I still got the output I wanted (fishpaths with TagID, Station, arrival, and departure), the tests passed.




