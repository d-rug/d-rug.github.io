# running this crazy jekyll website 

This is just some running notes for managing this website. They may not work on different platforms.
Currently they have been written to function on a MacOSX using Mojave 10.14.x.

## Getting Ruby Manager

Highly recommend installing a ruby environment manager, so you can switch between versions of ruby if need be (or update install new ones). There are two options: `rbenv` and `rvm`. I'm using `rbenv` in this set of notes. Both are good, `rvm` is a bit tricker to install.

## see these instructions for dealing with rvm: https://duseev.com/articles/rbenv-vs-rvm/
 - `rbenv`: install following these instructions: https://github.com/rbenv/rbenv
 - `rvm`: install following these instructions: https://rvm.io/
 
### once rbenv is installed:
 - check versions available:
    `rbenv install -l`

 - install new version of ruby:
    `rbenv install 2.7.2`

### check ruby version and use rehash to set paths:

check the version: `ruby -v`
rehash: `rbenv rehash`

### set the global version to use

`rbenv global 2.7.2`
`ruby -v`
`rbenv versions`

## Update Jekyll & Bundler

First we need to install bundler and jekyll to build up our site:

 - `gem install bundler jekyll`
 
Now we can actually run stuff in the directory where the `Gemfile` lives:

 - `bundle update`
 - `bundle install`

# Update and View website!

To preview the website, we can use this:

 - `bundle exec jekyll serve`
 
If we have a drafts folder and want to see what the posts in drafts would look like, use this:

 - `bundle exec jekyll serve --drafts`