# devtools::install_github("kcf-jackson/jsReact")
library(magrittr)
library(jsReact)


#' Build app interface for jExcel
#' @param ... Other parameters to pass to the jExcel call.
#' @keywords internal
build_spreadsheet_app <- function(...) {
  dots_to_attr <- . %>%
    purrr::map2_chr(names(.), ., ~sprintf("%s: %s", .x, .y)) %>%
    paste0(collapse = ", ")

  create_html() %>%
    add_script_from_link("https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js") %>%
    add_script_from_link("https://cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js") %>%
    add_script_from_link("http://cdn.bossanova.uk/js/jquery.jexcel.js") %>%
    add_script_from_link("https://cdnjs.cloudflare.com/ajax/libs/jquery-csv/0.8.3/jquery.csv.min.js") %>%
    add_script_from_link("http://cdn.bossanova.uk/js/excel-formula.min.js") %>%
    add_style_from_link("http://cdn.bossanova.uk/css/jquery.jexcel.css") %>%
    add_div(id = "my") %>%
    add_script(sprintf("$('#my').jexcel({ %s });", dots_to_attr(list(...))))
}


#' A simple spreadsheet app built using jsReact (and jExcel).
#' @description See https://bossanova.uk/jexcel for details about jExcel.
#' @param csv_file character_string; path to the csv file.
#' @param header T or F, should header be included as colnames?
#' @param ... Other parameters to pass to the jExcel call.
#' See https://bossanova.uk/jexcel for details.
#' @examples
#' write.csv(iris, file = "test.csv", row.names = F)
#' open_spreadsheet("test.csv")
open_spreadsheet <- function(csv_file, header = T, ...) {
  get_filename <- . %>% strsplit("/") %>% unlist() %>% tail(1)
  filename <- get_filename(csv_file)

  my_html <- build_spreadsheet_app(
    csv = sprintf('\"%s\"', filename),
    csvHeaders = ifelse(header, "true", "false"), ...
  )

  preview_app(my_html, assets_folder = csv_file)
}


#' A simple spreadsheet app built using jsReact (and jExcel).
#' @description See https://bossanova.uk/jexcel for details about jExcel.
#' @param csv_file character_string; path to the csv file.
#' @param header T or F, should header be included as colnames?
#' @param ... Other parameters to pass to the jExcel call.
#' See https://bossanova.uk/jexcel for details.
#' @examples
#' new_spreadsheet()
new_spreadsheet <- function(num_col = 5, num_row = 10, ...) {
  my_html <- build_spreadsheet_app(
    minDimensions = sprintf('[%s, %s]', num_col, num_row), ...
  )
  preview_app(my_html, assets_folder = csv_file)
}
