---
title: "Discussion: software engineering practices in R"
author: "D-RUG"
tags: [D-RUG, R, presentations, roxygen, roxygen2]
date: "2022-10-12"
layout: post
---

**We discussed the value of and our experience with software engineering methods in R**

The discussion was guided by our reading of a paper in The R Journal:

[Software Engineering and R Programming: A Call for Research](https://journal.r-project.org/articles/RJ-2021-108/)

As a group, we agreed that we are R users more than R developers. A few of us have written packages before, but we all recognize that we do the bad practices listed in the paper, like copying functions, naming files like `xxx-analysis-final2.R`, and commenting out blocks of code but never going back to clean them up, and making comments like `#TODO: fix me`.

Several folks are new to writing package documentation, and almost none of us have used unit tests. Nobody in the group has adopted a software development paradigm (Kanban, Extreme Programming, etc.) for their development process.

There was some debate over whether it is worth adopting best practices for code that is meant for our own personal use. We are going to make a series of this, reading the followup commentaries ([there](https://journal.r-project.org/articles/RJ-2021-109/) [are](https://journal.r-project.org/articles/RJ-2021-110/) [four](https://journal.r-project.org/articles/RJ-2021-111/) [comments](https://journal.r-project.org/articles/RJ-2021-112/)), and covering topics from the paper in our upcoming mini-workshops.