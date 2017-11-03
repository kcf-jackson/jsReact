#' Function to create example data shown in the tweenr package.
#' @export
tweenr_example <- function() {
  # Create data
  d <- data.frame(x = rnorm(20), y = rnorm(20), time = sample(100, 20), alpha = 0,
                  size = 1, ease = 'elastic-out', id = 1:20,
                  stringsAsFactors = FALSE)
  d2 <- d
  d2$time <- d$time + 10
  d2$alpha <- 1
  d2$size <- 3
  d2$ease <- 'linear'
  d3 <- d2
  d3$time <- d2$time + sample(50:100, 20)
  d3$size = 10
  d3$ease <- 'bounce-out'
  d4 <- d3
  d4$y <- min(d$y) - 0.5
  d4$size <- 2
  d4$time <- d3$time + 10
  d5 <- d4
  d5$time <- max(d5$time)
  df <- rbind(d, d2, d3, d4, d5)
  df$size <- df$size * 5  # cater for plotly
  df
}
