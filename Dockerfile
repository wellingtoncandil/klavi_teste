FROM ghcr.io/rocker-org/plumber:latest

WORKDIR /app
COPY api.R /app/api.R
COPY run.R /app/run.R

CMD ["Rscript", "/app/run.R"]
