library(plumber)
library(jsonlite)

# ---------------------------
# Health check GET
# ---------------------------
#' @get /
function(){
  list(status = "online")
}

# ---------------------------
# HANDSHAKE DA KLAVI (ESSENCIAL)
# ---------------------------
#' @post /
function(req, res){

  cat("Handshake recebido da Klavi\n")

  # alguns provedores exigem 200 sem processamento
  res$status <- 200
  list(status="ok")
}

# ---------------------------
# WEBHOOK REAL
# ---------------------------
#' @post /webhook/klavi
function(req, res){

  raw <- req$postBody

  cat("Webhook real recebido\n")
  cat(raw, "\n")

  data <- jsonlite::fromJSON(raw, simplifyVector = FALSE)

  file_name <- paste0("/tmp/klavi_", Sys.time(), ".json")
  write(raw, file = file_name)

  res$status <- 200
  list(status="received")
}
