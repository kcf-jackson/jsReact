% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/app.R
\name{create_app}
\alias{create_app}
\title{Create an interactive app}
\usage{
create_app(html_file, user_function = identity, insert_socket = T)
}
\arguments{
\item{html_file}{Filepath to a HTML file; the web interface.}

\item{user_function}{R function; the function to process the data from the web interface.}

\item{insert_socket}{T or F; whether to enable interaction between JS and R.}
}
\description{
Create an interactive app
}
