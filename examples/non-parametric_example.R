# Generate a simple DGP
simple_DGP <- function(n) {
  sample_DGP <- function(x) {
    p <- runif(1)
    if (p < 1 / 3){
      return(rpois(1,3))
    } else if (p < 2 / 3) {
      return(-rgamma(1, 10, 1))
    } else {
      return(rnorm(1, 20, 10))
    }
  }
  purrr::map_dbl(1:n, sample_DGP)
}


# Non-parametric density estimation
gaussian_approx <- function(data0) {
  Vectorize(function(x) {
    mean(purrr::map_dbl(data0, ~dnorm(x, mean = .x, sd = 2)))
  })
}


# # Simluate from DGP
# data0 <- simple_DGP(10000)
# true_den <- density(data0)
# plot(true_den, lwd = 4, main = "An illustration of non-parametric density estimation")
# # Estimate density
# est_density <- gaussian_approx(data0)
# xrange <- true_den$x
# lines(xrange, est_density(xrange), col = 'red', lwd = 4)
