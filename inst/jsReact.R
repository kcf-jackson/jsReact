# KNN
fit_knn <- function(list0) {
  # Get data
  train_data <- data.frame(
    x1 = list0[['x1']], x2 = list0[['x2']], y = list0[['y']])
  grid_data <- make_uniform_grid(0, 400, 20)
  # Fit models
  knn_pred <- knn(train_data[,1:2], grid_data[,1:2], train_data[,3])
  grid_data[['y']] <- as.numeric(as.character(knn_pred))
  # Return
  list(x1 = grid_data[['x1']], x2 = grid_data[['x2']], y = grid_data[['y']])
}

# Logistic regression
fit_logistic <- function(list0) {
  train_data <- data.frame(
    x1 = list0[['x1']], x2 = list0[['x2']], y = list0[['y']])
  grid_data <- make_uniform_grid(0, 400, 20)
  # Refit models
  glm_model <- glm(y ~ ., data = train_data, family = binomial())
  grid_data[['y']] <- predict(glm_model, grid_data[,c('x1', 'x2')], type = 'response')
  grid_data[['y']] <- round(grid_data[['y']])
  # Pass grid and data over
  list(x1 = grid_data[['x1']], x2 = grid_data[['x2']], y = grid_data[['y']])
}

# Helpers
make_uniform_grid <- function(min0, max0, resolution = 100) {
  one_side_grid <- seq(min0, max0, length.out = resolution)
  grid_data <- expand.grid(one_side_grid, one_side_grid)
  grid_data <- data.frame(grid_data, 0)
  names(grid_data) <- c('x1', 'x2', 'y')
  grid_data
}

app <- create_app("knn_app.html", fit_knn)
start_app(app)

app <- create_app("logit_app.html", fit_logistic)
start_app(app)
