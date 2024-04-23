## 合并crt
[https://www.sslforfree.com](https://www.sslforfree.com)的服务器证书和ca是分开提供的，需要合并。

```shell
cat certificate.crt ca_bundle.crt > cert.crt
```