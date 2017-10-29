#' Insert a websocket connection and convert html to string.
#' @keywords internal
insert_websockets <- function(filepath, wsUrl) {
  my_html <- readLines(filepath)
  wsUrl_line <- sprintf("var ws = new WebSocket(%s);", wsUrl)
  has_script <- any(has_tag(my_html, "<script>"))
  if (has_script) {
    return(JS_(insert_after(wsUrl_line, "<script>", my_html)))
  }
  has_body <- any(has_tag(my_html, "</body>"))
  if (has_body) {
    wsUrl_line %<>% shiny::tags$script() %>% as.character()
    return(JS_(insert_before(wsUrl_line, "</body>", my_html)))
  }
  stop("Your file doesn't contain a (standalone) <script> tag or a <body> tag.")
}


#' Insert a script before the tag of a vector of html string
#' @keywords internal
insert_before <- function(script, tag, my_html) {
  ind <- get_tag_index(my_html, tag)
  insert(script, my_html, ind - 1)
}


#' Insert a script after the tag of a vector of a html string
#' @keywords internal
insert_after <- function(script, tag, my_html) {
  ind <- get_tag_index(my_html, tag)
  insert(script, my_html, ind)
}


#' Insert x into vec0 at pos + 1
#' @keywords internal
insert <- function(x, vec0, pos) {
  len <- length(vec0)
  assertthat::assert_that(pos >= 0) && assertthat::assert_that(pos <= len)
  if (pos == 0) {
    res <- c(x, vec0)
  } else if (pos == len) {
    res <- c(vec0, x)
  } else {
    res <- c(vec0[1:pos], x, vec0[(pos+1):len])
  }
  res
}
