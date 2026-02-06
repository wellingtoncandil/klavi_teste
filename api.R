library(plumber)
library(jsonlite)

pr <- plumb(function(pr) {

  #' Health check
  #' @get /
  function() {
    list(status = "ok")
  }

  #' Webhook Klavi
  #' @post /webhook/klavi
  function(req, res) {

    body <- req$postBody

    if (is.null(body) || body == "") {
      res$status <- 400
      return(list(error = "Empty body"))
    }

    json <- fromJSON(body, simplifyVector = FALSE)

    # 🔹 Aqui você trata as variáveis da Klavi
    resultado <- list(
      request_id = json$request_id %||% NA,
      renda = json$income %||% NA,
      score = json$score %||% NA
    )

    # 🔹 Salvar resultado (arquivo)
    write(
      toJSON(resultado, auto_unbox = TRUE, pretty = TRUE),
      file = paste0("/tmp/klavi_", Sys.time(), ".json")
    )

    res$status <- 200
    list(status = "received")
  }
})

pr$run(host = "0.0.0.0", port = as.integer(Sys.getenv("PORT", 8000)))
