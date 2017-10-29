#test case 1 - Serve raw html without listener
rm(list = ls())
library(jsReact)
my_html <- create_html()
write_html_to_file(my_html, file = "inst/sample.html")
my_app <- create_app("inst/sample.html", insert_socket = F)
start_app(my_app)


#test case 2 - Serve html with listener
rm(list = ls())
library(jsReact)
my_html <- create_html()
write_html_to_file(my_html, file = "inst/sample.html")
my_app <- create_app("inst/sample.html", insert_socket = T)
start_app(my_app)


#test case 3 - Add JS libraries
rm(list = ls())
library(jsReact)
my_html <- create_html() %>% add_js_library("plotly")
write_html_to_file(my_html, file = "inst/sample.html")
my_app <- create_app("inst/sample.html", insert_socket = T)
start_app(my_app)
