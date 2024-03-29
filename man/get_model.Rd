% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/kiwi_model.R
\name{get_model}
\alias{get_model}
\title{Get kiwi language model file.}
\source{
\url{https://github.com/bab2min/Kiwi/releases}
}
\usage{
get_model(size = "base", path = model_home(), clean = FALSE)
}
\arguments{
\item{size}{"small", "base", "large" model. default is "base". Also "all" available.}

\item{path}{path for model files. default is \code{\link[=model_home]{model_home()}}.}

\item{clean}{remove previous model files before get new.}
}
\description{
Get kiwi language model file.
}
\examples{
\dontrun{
  get_model("small")
}
}
