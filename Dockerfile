FROM rocker/r-ver:4.3.2

RUN R -e "install.packages(c('plumber','jsonlite'), repos='https://cloud.r-project.org')"

WORKDIR /app
COPY api.R /app/api.R

EXPOSE 8000
CMD ["R", "-e", "source('/app/api.R')"]
