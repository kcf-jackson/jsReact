library(jsReact)

# send_r_data <- function(msg) {
#   my_data <- mtcars
#   list(r_dist_matrix = as.matrix(dist(my_data)))
# }
#
# my_app <- create_app("examples/9_tsne/tsne.html", send_r_data, T)
# start_app(my_app)

start_tsne_app <- function(my_data, app_html = "tsne.html") {
  send_r_data <- function(msg) {
    list(r_dist_matrix = as.matrix(dist(my_data)))
  }

  my_app <- create_app(app_html, send_r_data, T)
  start_app(my_app)
}

start_tsne_app(unique(iris)[,1:4])
