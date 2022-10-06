#!/bin/bash

for i in config_dir work_dir logs_dir; do
  if [ ! -d letsencrypt/$i ] ; then
    mkdir -p letsencrypt/$i
  fi
done

certbot certonly --csr xctest.online.csr --manual --preferred-challenges dns --config-dir letsencrypt/config_dir --work-dir letsencrypt/work_dir --logs-dir letsencrypt/logs_dir

#verify the key matches
PRIV_HASH="`openssl rsa -noout -modulus -in xctest.online.key | openssl md5`"
CERT_HASH="`openssl x509 -noout -modulus -in 0000_cert.pem | openssl md5`"

if [ "$PRIV_HASH" != "$CERT_HASH" ] ; then
  echo "Keys do not match" >&2
  exit 3
fi

rm -f xctest.online.crt
mv 0000_cert.pem xctest.online.crt

rm -f chain.pem
mv 0000_chain.pem chain.pem
if [ -f 0001_chain.pem ] ; then
  mv 0001_chain.pem chain1.pem
fi

./make_p12.sh