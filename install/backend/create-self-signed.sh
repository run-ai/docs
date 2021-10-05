#!/bin/bash

echo "Generating TLS files for $1"

mkdir -p ssl
ssl_folder_name="ssl/$1"
mkdir -p $ssl_folder_name
rm -rf $ssl_folder_name
mkdir $ssl_folder_name

echo "Generating TLS files in $ssl_folder_name"

# cat << EOF > $ssl_folder_name/req.cnf
# [req]
# req_extensions = v3_req
# distinguished_name = req_distinguished_name
# [req_distinguished_name]
# 
# [ v3_req ]
# basicConstraints = CA:TRUE
# keyUsage = nonRepudiation, digitalSignature, keyEncipherment
# subjectAltName = @alt_names
# 
# [alt_names]
# DNS.1 = $1
# EOF


cat << EOF > $ssl_folder_name/req.cnf
[req]
default_bits           = 2048
default_md             = sha256
encrypt_key            = no
prompt                 = no
distinguished_name     = subject
req_extensions         = req_ext
x509_extensions        = x509_ext

[ subject ]
C                      = US
ST                     = New York
L                      = New York City
O                      = Liberty Island
OU                     = UNATCO Headquarters
emailAddress           = user@example.com
CN                     = $1

[ req_ext ]
subjectKeyIdentifier   = hash
basicConstraints       = CA:TRUE
keyUsage               = digitalSignature, keyEncipherment
extendedKeyUsage       = serverAuth, clientAuth
subjectAltName         = @alternate_names
nsComment              = "Self-Signed SSL Certificate"

[ x509_ext ]
subjectKeyIdentifier   = hash
authorityKeyIdentifier = keyid,issuer
basicConstraints       = CA:TRUE
keyUsage               = digitalSignature, keyEncipherment
extendedKeyUsage       = serverAuth, clientAuth
subjectAltName         = @alternate_names
nsComment              = "Self-Signed SSL Certificate"

[ alternate_names ]
DNS.1                  = $1
EOF

# openssl req -config openssl.cnf -new -sha256 -newkey rsa:2048 -nodes -keyout private.key  -x509 -days 825 -out certificate.crt
# openssl req -config $ssl_folder_name/req.cnf -new -key $ssl_folder_name/key.pem -out $ssl_folder_name/csr.pem 
# openssl req -new -key $ssl_folder_name/key.pem -out $ssl_folder_name/csr.pem -subj "/CN=kube-ca" -config $ssl_folder_name/req.cnf

openssl genrsa -out $ssl_folder_name/ca-key.pem 2048
openssl req -x509 -new -nodes -key $ssl_folder_name/ca-key.pem -days 365 -out $ssl_folder_name/ca.pem -subj "/CN=$1"

openssl genrsa -out $ssl_folder_name/key.pem 2048
openssl req -new -key $ssl_folder_name/key.pem -out $ssl_folder_name/csr.pem -subj "/CN=$1" -config $ssl_folder_name/req.cnf
openssl x509 -req -in $ssl_folder_name/csr.pem -CA $ssl_folder_name/ca.pem -CAkey $ssl_folder_name/ca-key.pem -CAcreateserial -out $ssl_folder_name/cert.pem -days 365 -extensions req_ext -extfile $ssl_folder_name/req.cnf
