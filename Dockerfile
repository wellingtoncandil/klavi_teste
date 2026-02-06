FROM rocker/r-base:4.3.2

ENV DEBIAN_FRONTEND=noninteractive

# Dependências do sistema
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Instalar pacotes R (CRAN definido AQUI)
RUN R -e "install.packages(c('plumber','jsonlite'), repos='https://cloud.r-project.org', dependencies=TRUE)"

WORKDIR /app
COPY api.R /app/api.R

EXPOSE 8000

CMD ["R", "-e", "source('/app/api.R')"]
