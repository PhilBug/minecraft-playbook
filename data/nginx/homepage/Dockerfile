FROM nginx

ENV DOMAIN_NAME kwadratowe-karpicko.tk

RUN mkdir -p /www/data

COPY ./app /www/data/app
COPY ./assets /www/data/assets
COPY ./dist /www/data/dist
COPY ./index.html /www/data/index.html

COPY ./nginx.conf /etc/nginx/nginx.conf

RUN rm -rf /etc/nginx/conf.d/* && \
    sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /etc/nginx/nginx.conf
