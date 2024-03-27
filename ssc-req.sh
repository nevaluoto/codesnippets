#!/bin/bash
#Quick script to automate self-signed certificate creation with OpenSSL, requires existing CA key
read -p "Enter the local domain (e.g., website.lan): " localdomain

openssl genrsa -out $localdomain.key 2048

# As the subject information is practically irrelevant in home use feel free to not alter anything, or change to your liking 
openssl req -new -subj "/C=FI/ST=Uusimaa/L=Helsinki/O=HomeLab/OU=IT/CN=HomeLab" -key $localdomain.key -out $localdomain.csr

echo "authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $localdomain
" > $localdomain.ext

# Make sure the existing CA key is either in the same directory or point to it
openssl x509 -req -in $localdomain.csr -CA homelabCA.pem -CAkey homelabCA.key \
-CAcreateserial -out $localdomain.crt -days 3650 -sha256 -extfile $localdomain.ext
