FROM nginx:latest
#COPY index.html /usr/share/nginx/html/index.html
#EXPOSE 80
# Kopeeri veebifailid
COPY index.html /usr/share/nginx/html/

# Kopeeri sertifikaadid ja konfiguratsioon
COPY nginx.crt /etc/ssl/certs/nginx.crt
COPY nginx.key /etc/ssl/private/nginx.key
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

