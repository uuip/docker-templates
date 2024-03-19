## 配置跳转地址

通过nginx前置ssl后，当通过浏览器访问console时，需要访问正确的minio后端接口。<br>有两种方法，任选其一。

1. nginx配置`proxy_redirect http:// https://；`<br>当前使用，不用绑定外网IP。
2. compose中minio添加环境变量<br>`MINIO_BROWSER_REDIRECT_URL=https://192.168.110.10:9001`<br>官方文档推荐方式，有域名的话方便点。
3. cert 放置证书：server.cer，server.key