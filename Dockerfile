FROM httpd:latest
LABEL Apache Web
COPY index.html /usr/local/apache2/htdocs/