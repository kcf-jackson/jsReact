# rm(list = ls())
# devtools::install_github("kcf-jackson/jsReact")
library(magrittr)
library(jsReact)

my_html <- create_html() %>%
  add_js_library('p5') %>%
  add_script(
    "
    function preload() {
      var src = 'https://cdn.rawgit.com/rmfisher/react-measurements/863d8563/src/demo/images/pollen.jpg?raw=true';
      img = loadImage(src);
    }
    function setup() {
      createCanvas(600, 600);
      image(img, 0, 0);
    }
    function mouseDragged() {
      stroke(255);  //border color
      fill(255);    //circle color
      ellipse(mouseX, mouseY, 10, 10);
      ws.send(JSON.stringify({x: mouseX, y: mouseY}))
    }
    "
  )

# empty_df <- c()  # quick hack
my_r_fun <- function(msg) {
  cat(msg$x, msg$y, "\n")
  # empty_df <<- rbind(empty_df, c(msg$x, msg$y))  # quick hack
}

preview_app(my_html, my_r_fun, T)
