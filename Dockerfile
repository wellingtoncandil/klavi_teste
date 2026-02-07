FROM rocker/r-ver:4.3.2

# ---- dependências de sistema necessárias pro plumber ----
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    pkg-config \
    libsodium-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# library global
RUN mkdir -p /usr/local/lib/R/site-library
RUN chmod -R 777 /usr/local/lib/R/site-library

# instalar pacotes R
RUN Rscript -e "install.packages(c('Rcpp','later','promises'), repos='https://cloud.r-project.org', Ncpus=2, lib='/usr/local/lib/R/site-library')"
RUN Rscript -e "install.packages('httpuv', repos='https://cloud.r-project.org', Ncpus=2, lib='/usr/local/lib/R/site-library')"
RUN Rscript -e "install.packages('sodium', repos='https://cloud.r-project.org', Ncpus=2, lib='/usr/local/lib/R/site-library')"
RUN Rscript -e "install.packages('plumber', repos='https://cloud.r-project.org', Ncpus=2, lib='/usr/local/lib/R/site-library')"
RUN Rscript -e "install.packages('jsonlite', repos='https://cloud.r-project.org', Ncpus=2, lib='/usr/local/lib/R/site-library')"

WORKDIR /app
COPY . /app

EXPOSE 8000

CMD ["Rscript", "start.R"]

