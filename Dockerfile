FROM rocker/r-base:4.3.2

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

RUN R -e "install.packages(c('plumber','jsonlite'), repos='https://cloud.r-project.org')"

WORKDIR /app
COPY api.R /app/api.R
COPY run.R /app/run.R

CMD ["Rscript", "/app/run.R"]
