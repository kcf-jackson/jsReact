#' Preview app
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param user_function R function; the function to process the data from the web interface.
#' @param server T or F; whether to enable interaction between JS and R.
#' @param assets_folder path of the assets.
#' @param ... Additional parameters passed to 'start_app'.
#' @export
preview_app <- function(my_html, user_function = identity, server = F,
                        assets_folder, ...) {
  temp_dir <- tempfile()
  dir.create(temp_dir)
  file_path <- file.path(temp_dir, "index.html")
  if (!missing(assets_folder)) copy_assets(assets_folder, temp_dir)
  if (server == F) {
    write_html_to_file(my_html, file_path)
    getOption("viewer")(file_path)
  } else {
    write_html_to_file(my_html, file_path)
    my_app <- create_app(file_path, user_function)
    start_app(my_app, ...)
  }
}


#' Copy assets to target directory
#' @description This is needed when one needs to serve local file to RStudio viewer.
#' @param path character_string; path to the source file / folder.
#' @param target_dir character_string; path to the target folder.
#' @keywords internal
copy_assets <- function(path, target_dir) {
  if (!file.exists(path)) stop("File / folder doesn't exist.")

  if (missing(target_dir)) {
    target_dir <- tempfile()
    dir.create(target_dir)
  }
  if (file.info(path)$isdir) {
    success <- file.copy(path, target_dir, recursive = T)
  } else {
    success <- file.copy(path, target_dir)
  }

  if (success) print("Folder copied successfully")
  target_dir
}


#' Run an interactive app
#' @param app An app; output from the 'create_app' function
#' @param host character string; Address to host the app.
#' @param port integer; Port to host the app.
#' @param browser "browser" (web) or "viewer" (R).
#' @export
start_app <- function(app, host = "localhost", port = 9454, browser = "viewer") {
  address <- paste0("http://", host, ":", port)
  browseURL(address, browser = getOption(browser))
  host <- ifelse(host == "localhost", "0.0.0.0", host)
  httpuv::runServer(host, port, app, 250)
}


#' Create an interactive app
#' @param html_file Filepath to a HTML file; the web interface.
#' @param user_function R function; the function to process the data from the web interface.
#' @param insert_socket T or F; whether to enable interaction between JS and R.
#' @export
create_app <- function(html_file, user_function = identity, insert_socket = T) {
  pipe_fun <- add_pipe(user_function)
  parse_fun <- vifelse(insert_socket, insert_websockets, html_to_string)
  # has_html <- !missing(html_file)
  list(
    call = function(req) {
      address <- ifelse(is.null(req$HTTP_HOST), req$SERVER_NAME, req$HTTP_HOST)
      ws_url <- create_ws_url(address)
      body <- parse_fun(html_file, ws_url)
      list(
        status = 200L, headers = list("Content-Type" = "text/html"), body = body
      )
    },
    onWSOpen = function(ws) {
      ws$onMessage(function(binary, input) {
        output <- pipe_fun(input)
        ws$send(output)
      })
    }
  )
}


#' Add 'pipes' to convert from and to JSON
#' @keywords internal
add_pipe <- function(user_fun) {
  return (function(msg) {
    in_msg <- jsonlite::fromJSON(msg)
    out_msg <- user_fun(in_msg)
    jsonlite::toJSON(out_msg)
  })
}


#' A wrapper to make an address a full link
#' @keywords internal
create_ws_url <- function(address) {
  paste('"', "ws://", address, '"', sep = "")
}


#' Convert html to string
#' @keywords internal
html_to_string <- function(filepath, ...) {
  JS_(readLines(filepath))
}
