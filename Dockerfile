FROM trestletech/plumber:latest

WORKDIR /app
COPY api.R /app/api.R

EXPOSE 8000

CMD ["R", "-e", "pr <- plumber::plumb('/app/api.R'); pr$run(host='0.0.0.0', port=as.integer(Sys.getenv('PORT', 8000)))"]
