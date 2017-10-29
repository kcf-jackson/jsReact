rm(list = ls())
library(jsReact)
my_html <- create_html() %>%
  add_js_library("p5") %>%
  add_style(
    "<style type='text/css'>
    </style>") %>%
  add_column(id = "column_1", align = 'center') %>%
  add_column(id = "column_2", align = 'center', into = "column_1") %>%
  add_text("<b>KNN classification</b><br>", into = "column_2") %>%
  add_text("Click to create red dots. <br> Click with key pressed create green dots.",
           into = "column_2")
my_html %<>% add_script(
"<script>
  var data0 = {'x1': [], 'x2': [], 'y': []};
  var grid_data = {'x1': [], 'x2': [], 'y': []};
  ws.onmessage = function(msg) {
    grid_data = JSON.parse(msg.data);
  }
  var canvas_width = 400;
  var canvas_height = 400;
  function setup() {
    var my_canvas = createCanvas(canvas_width, canvas_height);
    my_canvas.parent('column_1');
    rect(0, 0, canvas_width-1, canvas_height-1);
  }
  function draw() {
    plot_data(grid_data, 'bg');
    plot_data(data0, 'data');
  }
  function plot_data(data0, type) {
    console.log(data0['x1']);
    var n = data0['x1'].length;
    for (var i = 0; i < n; i++) {
      if (data0['y'][i] == 1) {
        fill(0, 255, 0);
      } else {
        fill(255, 0, 0);
      }
      if (type == 'bg') {
        rect(data0['x1'][i], data0['x2'][i], 20, 20);
      } else {
        ellipse(data0['x1'][i], data0['x2'][i], 10, 10);
      }
    }
  }
  function mouseClicked() {
    data0['x1'].push(mouseX);
    data0['x2'].push(mouseY);
    if (keyIsPressed === true) {
      data0['y'].push(1);
    } else {
      data0['y'].push(0);
    }
    ws.send(JSON.stringify(data0));
  }
</script>")
write_html_to_file(my_html, "inst/sample.html")


my_r_fun <- function(in_msg) {
  grid_data <- make_uniform_grid(0, 400, 20)  # this is a 'constant' df
  train_data <- data.frame(x1 = in_msg$x1, x2 = in_msg$x2, y = in_msg$y)
  # Refit models
  knn_pred <- class::knn(
    train = train_data[,1:2], test = grid_data[,1:2], cl = train_data[,3]
  )
  grid_data[['y']] <- as.numeric(as.character(knn_pred))
  as.list(grid_data)
}
# Helpers
make_uniform_grid <- function(min0, max0, resolution = 100) {
  one_side_grid <- seq(min0, max0, length.out = resolution)
  grid_data <- expand.grid(one_side_grid, one_side_grid)
  grid_data <- data.frame(grid_data, 0)
  names(grid_data) <- c('x1', 'x2', 'y')
  grid_data
}


my_app <- create_app("inst/sample.html", my_r_fun)
start_app(my_app)
