library(plumber)
library(jsonlite)

#' Health
#' @get /
function() {
  list(status = "ok")
}

#' Webhook Klavi
#' @post /webhook/klavi
function(req, res) {

  json <- jsonlite::fromJSON(req$postBody, simplifyVector = FALSE)

  # trate aqui
  res$status <- 200
  list(status = "received")
}
