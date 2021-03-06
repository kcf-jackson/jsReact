% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_to_body.R
\name{add_title}
\alias{add_title}
\title{Add title to body}
\usage{
add_title(my_html, title, size = 3, into = "<body>")
}
\arguments{
\item{my_html}{html in a vector of strings; output from 'create_html'.}

\item{title}{character string; the title}

\item{size}{integer; size of title}

\item{into}{character string; unique identifier of a line in the html. Element id is highly recommended.}
}
\description{
Add title to body
}
