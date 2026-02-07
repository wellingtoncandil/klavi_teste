FROM rocker/r-ver:4.3.2

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# TOOLCHAIN DE COMPILAÇÃO (ESSENCIAL)
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

# Library global
RUN mkdir -p /usr/local/lib/R/site-library
RUN chmod -R 777 /usr/local/lib/R/site-library

# Instala pacotes (agora vai compilar de verdade)
RUN Rscript -e "install.packages('plumber', repos='https://cloud.r-project.org', Ncpus=2, lib='/usr/local/lib/R/site-library')"
RUN Rscript -e "install.packages('jsonlite', repos='https://cloud.r-project.org', Ncpus=2, lib='/usr/local/lib/R/site-library')"

WORKDIR /app
COPY . /app

EXPOSE 8000

CMD ["Rscript", "start.R"]
