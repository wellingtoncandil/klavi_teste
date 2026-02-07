library(plumber)
library(jsonlite)

# health
#' @get /
function(){
  list(status="online")
}

# handshake klavi
#' @post /
function(req, res){
  cat("KLAVI HANDSHAKE\n")
  res$status <- 200
  list(ok=TRUE)
}

# webhook real
#' @post /webhook/klavi
function(req, res){

  cat("WEBHOOK RECEBIDO\n")
  raw <- req$postBody
  cat(raw, "\n")

  write(raw, paste0("/tmp/klavi_", Sys.time(), ".json"))

  res$status <- 200
  list(received=TRUE)
}
