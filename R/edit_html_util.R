#' Insert a script into a tag of a html string
#' @keywords internal
insert_into <- function(my_html, script, into) {
  index <- get_tag_index(my_html$xml, into)
  my_level <- my_html$levels[index]
  index_2 <- get_tag_index(tail(my_html$levels, -index), my_level)
  insert_df(
    data.frame(xml = script, levels = my_level + 1, stringsAsFactors = F),
    my_html, index + index_2 - 1
  )
}


#' Get the first index of a tag in a vector of a html string
#' @keywords internal
get_tag_index <- function(my_html, tag, after = 0) {
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
