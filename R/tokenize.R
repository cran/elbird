#' Simple version of tokenizer function.
#'
#' @param text target text.
#' @param match_option [`Match`]: use Match. Default is Match$ALL
#' @param stopwords stopwords option. Default is TRUE which is
#'                  to use embaded stopwords dictionany.
#'                  If FALSE, use not embaded stopwords dictionany.
#'                  If char: path of dictionary txt file, use file.
#'                  If [`Stopwords`] class, use it.
#'                  If not valid value, work same as FALSE.
#'                  Check [analyze()] how to use stopwords param.
#' @importFrom purrr map
#' @returns list type of result.
#' @export
#' @examples
#' \dontrun{
#'   tokenize("Test text.")
#'   tokenize("Please use Korean.", Match$ALL_WITH_NORMALIZING)
#' }
#' @name tokenize
NULL

#' @export
#' @rdname tokenize
tokenize <-
  function(text,
           match_option = Match$ALL,
           stopwords = TRUE) {
    return(purrr::map(
      text,
      ~ analyze(
        text = .x,
        top_n = 1,
        match_option = match_option,
        stopwords = stopwords
      )[[1]][1]
    ))
  }


#' @rdname tokenize
#' @export
#' @importFrom dplyr bind_rows
tokenize_tibble <- function(text,
                            match_option = Match$ALL,
                            stopwords = FALSE) {
  dplyr::bind_rows(tokenize_raw(text, match_option, stopwords), .id = "unique")
}

#' @rdname tokenize
#' @export
#' @importFrom purrr map
tokenize_tidytext <- function(text,
                              match_option = Match$ALL,
                              stopwords = FALSE) {
  purrr::map(tokenize_raw(text, match_option, stopwords),
             ~ paste0(.x$form, "/", .x$tag))
}


#' @rdname tokenize
#' @export
tokenize_tbl <- tokenize_tibble

#' @rdname tokenize
#' @export
tokenize_tt <- tokenize_tidytext

#' @rdname tokenize
#' @export
tokenize_tidy <- tokenize_tidytext

#' @importFrom purrr map_chr map_int
tokenize_raw <- function(text, match_option, stopwords) {
  res <- tokenize(text, match_option, stopwords)
  purrr::map(
    res,
    ~ tibble::tibble(
      form = purrr::map_chr(.x$Token, ~ .x$form),
      tag = purrr::map_chr(.x$Token, ~ .x$tag),
      start = purrr::map_int(.x$Token, ~ .x$start),
      len = purrr::map_int(.x$Token, ~ .x$len),
    )
  )
}