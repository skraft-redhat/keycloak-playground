#!/bin/bash

SPIFFE_JWT_SVID=$(kubectl -n workload-identity-tutorial exec -it $(kubectl -n workload-identity-tutorial get pod -l=app=spire-debug -o jsonpath='{ .items[*].metadata.name}') -- /bin/sh -c '/opt/spire/bin/spire-agent api fetch jwt -audience http://localhost:8080/realms/spiffe -socketPath $SOCKETFILE' | sed -n '2p' | xargs)

echo "SPIFFE_JWT_SVID: \n $SPIFFE_JWT_SVID"

curl -s -X POST \
  -d grant_type=client_credentials \
  -d client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-spiffe \
  -d client_assertion="$SPIFFE_JWT_SVID" \
http://localhost:8080/realms/spiffe/protocol/openid-connect/token
