#!/bin/bash -e

rm -rf tmp
mkdir -p tmp && cd tmp

curl -s -O https://raw.githubusercontent.com/keycloak/keycloak/refs/heads/main/misc/scripts/kcw && chmod +x kcw

# SPIFFE_BUNDLE_CERT=$(readlink -f spire/conf/localhost-unsigned.pem)

./kcw nightly start-dev --features=client-auth-federated,spiffe
