# Força o caminho das bibliotecas
.libPaths("/usr/local/lib/R/site-library")

cat("LIBPATH:\n")
print(.libPaths())

# Teste explícito
library(plumber)

cat("Plumber carregado com sucesso!\n")

pr <- plumber::plumb("plumber.R")
pr$run(host = "0.0.0.0", port = 8000)
