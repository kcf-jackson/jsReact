# devtools::install_github("kcf-jackson/jsReact")
library(magrittr)
library(jsReact)

spreadsheet_app <- function(csv_file, header = T, ...) {
  get_filename <- . %>% strsplit("/") %>% unlist() %>% tail(1)
  filename <- get_filename(csv_file)
  my_html <- create_html() %>%
    add_script_from_link("https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js") %>%
    add_script_from_link("https://cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js") %>%
    add_script_from_link("http://cdn.bossanova.uk/js/jquery.jexcel.js") %>%
    add_script_from_link("https://cdnjs.cloudflare.com/ajax/libs/jquery-csv/0.8.3/jquery.csv.min.js") %>%
    add_script_from_link("http://cdn.bossanova.uk/js/excel-formula.min.js") %>%
    add_style_from_link("http://cdn.bossanova.uk/css/jquery.jexcel.css") %>%
    add_div(id = "my") %>%
    add_script(sprintf(
      "$('#my').jexcel({ csv:'%s', csvHeaders: %s });",
      filename, ifelse(header, "true", "false")
    )) %>%
    preview_app(assets_folder = csv_file)
}

write.csv(iris, file = "others/test.csv", row.names = F)
spreadsheet_app("others/test.csv")
