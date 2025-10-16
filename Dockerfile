FROM nginx:latest

# Kustuta vana sisu ja kopeeri kogu projekt
RUN rm -rf /usr/share/nginx/html/*
COPY . /usr/share/nginx/html/

# Lisa nginx konfiguratsioon ja sertifikaadid
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx.crt /etc/ssl/certs/nginx.crt
COPY nginx.key /etc/ssl/private/nginx.key

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]

