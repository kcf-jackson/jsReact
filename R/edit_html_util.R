insert_script <- function(script, after, before, my_html) {
  has_before <- !missing(before)
  has_after <- !missing(after)
  if (has_before & has_after) {
    res <- insert_after_and_before(script, after, before, my_html)
  } else if (has_before) {
    res <- insert_before(script, before, my_html)
  } else if (has_after) {
    res <- insert_after(script, after, my_html)
  } else {
    res <- insert_before(script, "</body>", my_html)
  }
  res
}

#' Insert a script before the tag of a vector of html string
#' @keywords internal
insert_after_and_before <- function(script, after, before, my_html) {
  ind <- get_tag_index(after, my_html)
  ind2 <- get_tag_index(before, my_html, ind)
  insert(script, my_html, ind2 - 1)
}


#' Insert a script before the tag of a vector of html string
#' @keywords internal
insert_before <- function(script, tag, my_html) {
  ind <- get_tag_index(tag, my_html)
  insert(script, my_html, ind - 1)
}


#' Insert a script after the tag of a vector of a html string
#' @keywords internal
insert_after <- function(script, tag, my_html) {
  ind <- get_tag_index(tag, my_html)
  insert(script, my_html, ind)
}


#' Get the first index of a tag in a vector of a html string
#' @keywords internal
get_tag_index <- function(tag, my_html, after = 0) {
  tag_exist <- has_tag(my_html, tag)
  if (!any(tag_exist)) {
    stop(paste0("Cannot find tag '", tag, "' in the file."))
  }
  ind <- which(tag_exist)
  min(ind[ind > after])
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


#' Collapse lines into a file
#' @keywords internal
JS_ <- function(...){
  x <- c(...)
  paste(x, collapse = "\n")
}


#' #' Append JS file to curret JS file
#' #' @keywords internal
#' js_append <- function(js, to_append){
#'   tokens <- unlist(strsplit(js, "\n"))
#'   end <- tokens[length(tokens)]
#'   tokens[length(tokens)] <- to_append
#'   JS_(c(tokens, end))
#' }
