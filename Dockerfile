FROM nginx:latest
COPY index.html /usr/share/nginx/html/

# Kopeeri sertifikaadid ja konfiguratsioon

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

