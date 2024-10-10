FROM node:16.13 as packager

WORKDIR /data
ADD  . /data
RUN npm install --registry=https://registry.npmmirror.com &&npm run build:prod

FROM nginx:1.26 as nginx

ADD ./nginx_templates/default.conf.template /etc/nginx/templates/default.conf.template
COPY --from=packager /data/dist /usr/share/nginx/html

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "nginx","-g","daemon off;" ]