#!/bin/sh
OUTDIR="${1:-/etc/nginx/ssl}"
mkdir -p "$OUTDIR"

# openssl is installed in the Dockerfile before calling this script
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$OUTDIR/server.key" \
  -out "$OUTDIR/server.crt" \
  -subj "/CN=ibougajd.42.fr"

chmod 600 "$OUTDIR/server.key"