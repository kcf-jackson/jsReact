#' An example to serve local image.
#' @description The key is to create a temporary directory to put both the image and the html.
#' Note that viewer and browser require different handling of the image_path.
#' @param html_path Html path
#' @param img_path Local image path
#' @param browser "browser" or "viewer.
serve <- function(img_path, browser = "viewer") {
  require(magrittr)
  require(jsReact)

  get_img_name <- . %>% strsplit("/") %>% unlist() %>% tail(1)
  img_name <- get_img_name(img_path)

  # create temp directory
  temp_dir <- tempfile()
  dir.create(temp_dir)
  file.copy(img_path, temp_dir) # copy image to temp

  # build simple html
  html_path <- file.path(temp_dir, "index.html")

  create_html() %>%
    html5_elements(tag = "img", text = "", src = img_name, close_tag = F) %>%
    write_html_to_file(file = html_path)

  # open viewer
  query <- normalizePath(html_path)
  if (browser != "viewer") {
    query = paste0("file://", query)
  }
  browseURL(query, browser = getOption(browser))
}

serve("pollen.jpg", "browser")
