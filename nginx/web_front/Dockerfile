FROM node:16.13 AS packager

WORKDIR /data
ADD  . /data
RUN npm install --registry=https://npmreg.proxy.ustclug.org &&npm run build:prod

FROM nginx:1.27 AS nginx

ADD ./nginx_templates/default.conf.template /etc/nginx/templates/default.conf.template
COPY --from=packager /data/dist /usr/share/nginx/html