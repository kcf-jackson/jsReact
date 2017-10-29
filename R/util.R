has_tag <- Vectorize(function(l, tag) {
  length(grep(tag, l)) > 0
}, "l")


#' Insert x into vec0 at pos + 1
#' @keywords internal
insert_df <- function(r, df0, pos) {
  len <- nrow(df0)
  assertthat::assert_that(pos >= 0) && assertthat::assert_that(pos <= len)
  if (pos == 0) {
    return(rbind(r, df0))
  } else if (pos == len) {
    return(rbind(df0, r))
  } else {
    return(rbind(df0[1:pos, ], r, df0[(pos+1):len, ]))
  }
}


vifelse <- function(bool, yes, no) {
  if (bool)
    return(yes)
  no
}
