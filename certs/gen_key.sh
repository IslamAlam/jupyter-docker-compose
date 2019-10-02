#!/usr/bin/env bash
# openssl req \
#     -subj "/C=DE/ST=Bayern/L=Munich/O=TUM Security/OU=ESPACE" \
#     -newkey rsa:2048 -nodes -keyout server.key \
#     -out server.crt

openssl req \
    -x509 -nodes -days 365 \
    -subj "/C=DE/ST=Bayern/L=Munich/O=TUM Security/OU=ESPACE" \
    -newkey rsa:2048 -keyout server.key -out server.crt
