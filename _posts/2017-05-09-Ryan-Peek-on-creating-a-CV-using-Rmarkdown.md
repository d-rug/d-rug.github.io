---
title: "Ryan Peek on Using RMarkdown to create & maintain a CV"
author: "Ryan Peek"
tags: [D-RUG, R, presentations, Rmarkdown, CV]
date: "17-05-09 10:00:00"
layout: post
---

For our first presentation of the 2017 Spring Quarter, D-RUG coordinator and UCD Ecology graduate student [Ryan Peek](http://ryanpeek.github.io/) gave a short demo on how to create, maintain, and adapt your very own CV or resume using an RMarkdown document in RStudio.  From Ryan:

> *"Understand how to use RStudio/RMarkdown to maintain and update your CV:* Furthermore, many [additional templates](https://github.com/svmiller/svm-r-markdown-templates) and options are becoming available for formatting these `.Rmd` documents, making it possible to write reports, manuscripts, and even [dissertations](https://github.com/davharris/Davis-dissertation-template).  To make this all work, we'll need to make sure folks have a version of **LaTeX** installed. It takes awhile, so if you don't already have it downloaded, please do so ahead of time (http://www.latex-project.org/get/).

### Materials
 - Source Material is on Github:
   - https://github.com/ryanpeek/markdown_cv
 - Code and additional material based on Steven Miller's excellent [post](http://svmiller.com/blog/2016/03/svm-r-markdown-cv/), utilized with a few minor formatting changes.

### Important tips
 - Use a new RStudio project for this (and everything, it makes things easier)
 - Make sure you have a LaTex distribution installed (see [here](http://www.latex-project.org/get/), note: it is a big file and will take a little time to install the first time)
 - Make sure in your RStudio global settings you have pdfLaTex selected in the Sweave options (see [here](https://support.rstudio.com/hc/en-us/articles/200532257-Customizing-LaTeX-Options) for more info on checking this)
 - The RMarkdown (`.Rmd`) file (in my repo, I have a few versions for different purposes) needs to be in the same place as the `.tex` file, which is the template that is used to render the document into a nice PDF.
