#' #' Factory function
#' #' @param fun_name character str; the function name
#' #' @param tag_name character str; the tag name
#' #' @param attr character vector; the attributes of the tag
#' #' @param has_end_tag True or False; whether the tag has a closing tag.
#' #' @keywords internal
#' factory_add <- function(fun_name, tag_name, attr, has_end_tag = T) {
#'   fun_str <- sprintf(
#'     "add_%s <- function(my_html, %s, identifier) {",
#'     fun_name, paste(attr, collapse = ", ")
#'   )
#'   fun_str %<>% c(sprintf("   str0 <- \"<%s\"", tag_name))
#'   for (i in attr) {
#'     fun_str %<>%
#'       c(sprintf("   if (!missing(%s)) {", i)) %>%
#'       c(sprintf("     str0 %%<>%% paste0(sprintf(\" %s=\'%%s\'\", %s))", i, i)) %>%
#'       c('   }')
#'   }
#'   fun_str %<>% c(sprintf("   str0 %%<>%% paste0(\">\")"))
#'   if (has_end_tag)
#'     fun_str %<>% c(sprintf("   str0 %%<>%% paste0(\"</%s>)\"", tag_name))
#'   fun_str %<>% c("   id <- ifelse(missing(identifier), \"</body>\", identifier)")
#'   fun_str %<>% c("   insert_before(str0, id, my_html)")
#'   fun_str %<>% c("}")
#'   fun_str %>% paste(collapse = "\n")
#' }
#'
#'
#' # add_slider to body
#' eval(parse(text =
#'   factory_add(
#'     fun_name = "slider", tag_name = "input",
#'     attr = c("type", "id", "min", "max", "value", "oninput"),
#'     has_end_tag = FALSE
#'   )
#' ))
