has_tag <- Vectorize(function(l, tag) {
  length(grep(tag, l)) > 0
}, "l")


#' Insert x into vec0 at pos + 1
#' @keywords internal
insert <- function(x, vec0, pos) {
  len <- length(vec0)
  assertthat::assert_that(pos >= 0) && assertthat::assert_that(pos <= len)
  if (pos == 0) {
    return(c(x, vec0))
  } else if (pos == len) {
    return(c(vec0, x))
  } else {
    c(vec0[1:pos], x, vec0[(pos+1):len])
  }
}


vifelse <- function(bool, yes, no) {
  if (bool)
    return(yes)
  no
}
