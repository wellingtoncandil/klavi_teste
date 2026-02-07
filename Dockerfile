FROM rocker/r-ver:4.3.2

# Dependências do sistema
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Criar library global acessível
RUN mkdir -p /usr/local/lib/R/site-library
RUN chmod -R 777 /usr/local/lib/R/site-library

# Instalar pacotes
RUN R -e "install.packages(c('plumber','jsonlite'), repos='https://cloud.r-project.org', lib='/usr/local/lib/R/site-library')"

WORKDIR /app
COPY . /app

EXPOSE 8000

CMD ["Rscript", "-e", "library(plumber); pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=8000)"]
