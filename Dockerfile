FROM rocker/r-ver:4.3.2

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# criar pasta da library
RUN mkdir -p /usr/local/lib/R/site-library
RUN chmod -R 777 /usr/local/lib/R/site-library

# instalar pacotes
RUN Rscript -e "install.packages('plumber', repos='https://cloud.r-project.org', lib='/usr/local/lib/R/site-library')"
RUN Rscript -e "install.packages('jsonlite', repos='https://cloud.r-project.org', lib='/usr/local/lib/R/site-library')"

WORKDIR /app
COPY . /app

EXPOSE 8000

CMD ["Rscript", "start.R"]
