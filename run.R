library(plumber)

port <- as.numeric(Sys.getenv("PORT", "8000"))

cat("Iniciando servidor na porta:", port, "\n")

pr <- plumb("/app/api.R")
pr$run(host = "0.0.0.0", port = port)
