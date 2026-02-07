library(plumber)
library(jsonlite)

# Health check (IMPORTANTÍSSIMO pro Railway e Klavi)
#* @get /
function() {
  list(status = "online")
}

# Webhook da Klavi
#* @post /klavi
#* @serializer json
function(req, res){

  body <- req$postBody
  data <- fromJSON(body)

  print("Webhook recebido:")
  print(data)

  # salva o json
  write(body, file="klavi_log.json", append=TRUE)

  return(list(received = TRUE))
}
