FROM rocker/r-ver:4.3.2

# Dependências do sistema
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

# Pacotes R
RUN R -e "install.packages(c('plumber','jsonlite'), repos='https://cloud.r-project.org')"

WORKDIR /app
COPY api.R /app/api.R

EXPOSE 8000

CMD ["R", "-e", "source('api.R')"]
