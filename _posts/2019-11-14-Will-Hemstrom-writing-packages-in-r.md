---
title: "Will Hemstrom: Writing Packages in R""
author: "D-RUG"
tags: [D-RUG, R, presentations, linear models]
date: "19-11-14 12:00:00"
layout: post
---

**_Will spoke about the process of writing packages in R. He describes the basic overview of the talk here:_**

R package writing and organization
I used to have an R script. It was a big script, and it represented months of code. Function, followed by function, followed by function. Then, I made a mistake. I came back two months later and tried to figure out what one of those functions did. Big mistake. Clearly, the coder who wrote that function was a moron who didn't bother to document anything. I sighed, sourced, and spent an hour trying to figure out how to use my own code. Then, I looked for a solution.

A big part of what makes R a useful data analysis environment is the availability of a huge range of packages that allow for the use of an immense variety of different methods and data types. Writing your own R package allows you to integrate function documentation into R's help utilities (tab completion! help() functions!), organize your code, and share easy-to-use sets of tools with others or with your grateful future self. In this presentation, we'll go over package creation, structure, and organization. Basic knowledge of function writing is useful but not required!

Please come with the devtools, usethis, and roxygen 2 packages installed! On windows, this will require Rtools; on mac, this will require Xcode; on Linux, this will require black magic (you'll have to google your particular distribution for help).

[Link to Youtube livestream video](https://youtu.be/bie1vrzXvf4)