FROM nginx:alpine

RUN apk add --update curl && rm -rf /var/cache/apk/*

COPY index.html /usr/share/nginx/html/index.html
