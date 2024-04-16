mkdir -p cert
openssl req -x509 -days 3650 -newkey ec -pkeyopt ec_paramgen_curve:prime256v1 -noenc -keyout cert/server.key -out cert/server.cer  -config ./openssl.cnf