#' Insert x into vec0 at pos + 1
#' @keywords internal
insert_df <- function(r, df0, pos) {
  len <- nrow(df0)
  assertthat::assert_that(pos >= 0) && assertthat::assert_that(pos <= len)
  if (pos == 0) {
    return(rbind(r, df0))
  } else if (pos == len) {
    return(rbind(df0, r))
  } else {
    return(rbind(df0[1:pos, ], r, df0[(pos+1):len, ]))
  }
}


#' Contains the JS libraries source links
#' @keywords internal
js_src <- function() {
  list(
    p5 = '<script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.5.16/p5.js"></script>',
    plotly = '<script src="https://cdn.plot.ly/plotly-latest.min.js"></script>',
    vega = '<script src="https://vega.github.io/vega/vega.min.js"></script>',
    d3 = '<script src="https://d3js.org/d3.v4.min.js"></script>'
  )
}


#' Collapse lines into a string
#' @keywords internal
JS_ <- function(...){
  x <- c(...)
  paste(x, collapse = "\n")
}


vifelse <- function(bool, yes, no) {
  if (bool)
    return(yes)
  no
}


has_tag <- Vectorize(function(l, tag) {
  length(grep(tag, l)) > 0
}, "l")
