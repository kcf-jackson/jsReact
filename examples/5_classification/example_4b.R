# Example 4b. Improved design from example 4.
# - More efficient initialisation
# - Seperate R and JS code
# Get familiar with the common visual tasks in JS (p5.js) and
# leverage R's modelling ability (KNN classification). This app is inspired by
# http://cs.stanford.edu/people/karpathy/convnetjs/demo/classify2d.html

# Make sure to set the right working directory before running!
rm(list = ls())
library(jsReact)
library(magrittr)
source("classification_algor.R")

# Html
my_html <- create_html() %>%
  add_js_library("p5") %>%
  add_column(id = "column_1", align = 'center') %>%
  add_column(id = "column_2", align = 'center', into = "column_1") %>%
  add_text("<b>Classification visualisation</b><br>", into = "column_2") %>%
  add_text("Click to create red dots. <br> Click with key pressed to create green dots.",
           into = "column_2") %>%
  add_script_from_file("example_4b.js")

# Helper
make_uniform_grid <- function(min0, max0, resolution = 100) {
  one_side_grid <- seq(min0, max0, length.out = resolution)
  grid_data <- expand.grid(one_side_grid, one_side_grid)
  grid_data <- data.frame(grid_data, 0)
  names(grid_data) <- c('x1', 'x2', 'y')
  grid_data
}

# R
grid_data <- make_uniform_grid(0, 400, 20)

# Use one of 'knn_fun', 'logit_fun', 'SVM_linear', 'SVM_radial' as implemented in
# 'classification_algor.R'.
preview_app(my_html, SVM_radial, T)
