# KNN classification
knn_fun <- function(in_msg) {
  to_js <- grid_data
  train_data <- data.frame(x1 = in_msg$x1, x2 = in_msg$x2, y = in_msg$y)
  knn_pred <- class::knn(
    train = train_data[,1:2], test = grid_data[,1:2], cl = train_data[,3]
  )
  to_js[['y']] <- as.numeric(as.character(knn_pred))
  as.list(to_js)
}

# logistic regression
logit_fun <- function(in_msg) {
  to_js <- grid_data
  train_data <- data.frame(x1 = in_msg$x1, x2 = in_msg$x2, y = in_msg$y)
  glm_model <- glm(y ~ ., data = train_data, family = binomial())
  to_js[['y']] <- round(predict(glm_model, to_js[,c('x1','x2')], type = 'response'))
  as.list(to_js)
}

# SVM - linear
SVM_linear <- function(in_msg) {
  to_js <- grid_data
  train_data <- data.frame(x1 = in_msg$x1, x2 = in_msg$x2, y = in_msg$y)
  model0 <- tryCatch(
    {e1071::svm(x = train_data[, 1:2], y = train_data[, 3],
             type = "C-classification", kernel = "linear")},
    error = function(e) e
  )
  if ('simpleError' %in% class(model0)) {
    return(as.list(to_js))
  }
  to_js[['y']] <- predict(model0, to_js[,c('x1','x2')])
  as.list(to_js)
}

# SVM - radial (copy and paste...)
SVM_radial <- function(in_msg) {
  to_js <- grid_data
  train_data <- data.frame(x1 = in_msg$x1, x2 = in_msg$x2, y = in_msg$y)
  model0 <- tryCatch(
    {e1071::svm(x = train_data[, 1:2], y = train_data[, 3],
                type = "C-classification", kernel = "radial")},
    error = function(e) e
  )
  if ('simpleError' %in% class(model0)) {
    return(as.list(to_js))
  }
  to_js[['y']] <- predict(model0, to_js[,c('x1','x2')])
  as.list(to_js)
}
