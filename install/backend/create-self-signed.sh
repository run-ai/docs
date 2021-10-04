#!/bin/bash

mkdir -p ssl

# cat << EOF > ssl/req.cnf
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
# DNS.1 = domain-name
# EOF


cat << EOF > ssl/req.cnf
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
CN                     = domain-name

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
DNS.1                  = domain-name
EOF

# openssl req -config openssl.cnf -new -sha256 -newkey rsa:2048 -nodes -keyout private.key  -x509 -days 825 -out certificate.crt
# openssl req -config ssl/req.cnf -new -key ssl/key.pem -out ssl/csr.pem
# openssl req -new -key ssl/key.pem -out ssl/csr.pem -subj "/CN=kube-ca" -config ssl/req.cnf

openssl genrsa -out ssl/ca-key.pem 2048
openssl req -x509 -new -nodes -key ssl/ca-key.pem -days 365 -out ssl/ca.pem -subj "/CN=domain-name"

openssl genrsa -out ssl/key.pem 2048
openssl req -new -key ssl/key.pem -out ssl/csr.pem -subj "/CN=domain-name" -config ssl/req.cnf
openssl x509 -req -in ssl/csr.pem -CA ssl/ca.pem -CAkey ssl/ca-key.pem -CAcreateserial -out ssl/cert.pem -days 365 -extensions req_ext -extfile ssl/req.cnf
