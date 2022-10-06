---
title: "Liza Wood: Package creation using roxygen2"
author: "D-RUG"
tags: [D-RUG, R, presentations, roxygen, roxygen2]
date: "2022-10-05"
layout: post
---

**_Liza shows us how to create an R package and write its documentation using Roxygen2_**

[Live Code from presentation as separate script](https://d-rug.github.io/packages_with_roxygen2/)

Liza's script shows how to make an R package for your favorite function(s) and distribute it via Github. The process, in brief:

1. Use the [`devtools` package](https://devtools.r-lib.org) to create a blank project directory from a template.
2. Put each function into a script in the `R` folder of the project directory.
3. Decorate each function script with [`roxygen2`-style documentation](https://roxygen2.r-lib.org).
4. Run the `devtools::document()` function to generate the package documentation.
5. Fill in the template `DESCRIPTION` file
6. Create a Github repository and push the package to it.

Now anyone can load your package directly from Github and use the R functions you've created!