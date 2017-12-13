#' Add VR scene
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param ... Extra parameter that goes into a tag, e.g. In <div type = "xxx">, 'type = "xxx"' goes to ... .
#' @export
add_vr_scene <- function(my_html, into = "<body>", ...) {
  html5_elements(my_html = my_html, into = into, tag = "a-scene", text = "",
                 collapse = F, ...)
}


#' Add VR sphere
#' @keywords internal
add_vr_sphere <- function(x, y, z, r, color, ...) {
  if (missing(r) || is.null(r)) r <- 0.2
  if (missing(color) || is.null(color)) color <- "#4CC3D9"

  position_text <- sprintf("%s %s %s", x, y, z)
  html5_elements(
    tag = "a-sphere", text = "", position = position_text,
    radius = as.character(r), color = color, insert = F, ...
  )
}


#' Add VR multiple spheres from dataframe
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param df0 A dataframe containing x, y, z coordinates, radius r (optional) and
#' color (optional). Note that the names of the columns are strict, i.e. must be
#' 'x', 'y', 'z', 'r'(optional), 'color'(optional).
#' @param ... Extra parameter that goes into a tag, e.g. In <div type = "xxx">, 'type = "xxx"' goes to ... .
#' @export
add_vr_3d_points <- function(my_html, into, df0, ...) {
  script <- purrr::map_chr(
    1:nrow(df0),
    ~add_vr_sphere(
      df0[.x, ]$x, df0[.x, ]$y, df0[.x, ]$z,
      df0[.x, ]$r, df0[.x, ]$color, ...
    )
  ) %>%
    paste(collapse = "\n")
  insert_into(my_html, script, into)
}


#' Add VR assets
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param ... Extra parameter that goes into a tag, e.g. In <div type = "xxx">, 'type = "xxx"' goes to ... .
#' @export
add_vr_assets <- function(my_html, into = "<body>", ...) {
  html5_elements(my_html = my_html, into = into, tag = "a-assets", text = "",
                 collapse = F, ...)
}


#' Add VR asset item
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param id character string; asset id for future referral.
#' @param src character string; path to asset.
#' @param ... Extra parameter that goes into a tag, e.g. In <div type = "xxx">, 'type = "xxx"' goes to ... .
#' @export
add_vr_asset_item <- function(my_html, into, id, src, ...) {
  html5_elements(my_html = my_html, into = into, tag = "a-asset-item",
                 text = "", id = id, src = src, ...)
}


#' Add VR entity
#' @param my_html html in a vector of strings; output from 'create_html'.
#' @param into character string; unique identifier of a line in the html. Element id is highly recommended.
#' @param ... Extra parameter that goes into a tag, e.g. In <div type = "xxx">, 'type = "xxx"' goes to ... .
#' @export
add_vr_entity <- function(my_html, into, ...) {
  html5_elements(my_html = my_html, into = into, tag = "a-entity",
                 text = "", ...)
}
