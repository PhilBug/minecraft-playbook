FROM nginx:latest

ENV DOMAIN_NAME kwadratowe-karpicko.tk
ENV SHORT_DOMAIN_NAME kwkp.tk

RUN mkdir -p /www/data

COPY ./app /www/data/app
COPY ./assets /www/data/assets
COPY ./dist /www/data/dist
COPY ./index.html /www/data/index.html

COPY ./nginx.conf /etc/nginx/nginx.conf

RUN rm -rf /etc/nginx/conf.d/* && \
    sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /etc/nginx/nginx.conf && \
    sed -i "s/SHORT_DOMAIN_NAME/${SHORT_DOMAIN_NAME}/g" /etc/nginx/nginx.conf && \
    chmod +r -R /www/data
