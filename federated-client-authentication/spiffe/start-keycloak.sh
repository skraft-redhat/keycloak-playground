#!/bin/bash -e

rm -rf tmp
mkdir -p tmp && cd tmp

curl -s -O https://raw.githubusercontent.com/keycloak/keycloak/refs/heads/main/misc/scripts/kcw && chmod +x kcw

SPIFFE_BUNDLE_CERT=/home/skraft/spire-1.12.5/conf/server/spiffe_trust_bundle.pem

./kcw nightly start-dev --features=client-auth-federated,spiffe --truststore-paths=$SPIFFE_BUNDLE_CERT
