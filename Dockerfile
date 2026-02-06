FROM rocker/r-ver:4.3.2

# Dependências do sistema (ESSENCIAL)
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Definir CRAN
RUN echo "options(repos = c(CRAN = 'https://cloud.r-project.org'))" >> /usr/lib/R/etc/Rprofile.site

# Instalar pacotes R
RUN R -e "install.packages(c('plumber','jsonlite'))"

WORKDIR /app
COPY api.R /app/api.R

EXPOSE 8000

CMD ["R", "-e", "source('/app/api.R')"]

