#!/bin/bash -e

echo "-----------------------"
echo "Login kcadm to Keycloak"
echo "-----------------------"

cd ~/kc/bin

./kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin --password admin

echo "----------------------------"
echo "Create demo kubernetes realm"
echo "----------------------------"

./kcadm.sh create realms -s realm=spiffe -s enabled=true

echo "------------------------------------------"
echo "Create Kubernetes Identity Provider config"
echo "------------------------------------------"

./kcadm.sh create identity-provider/instances -r spiffe -s alias=spiffe -s providerId=spiffe -s config='{"trustDomain": "spiffe://apps.sno.irgendeine.cloud", "bundleEndpoint": "https://federation.apps.sno.irgendeine.cloud"}'

echo "------------------------------------------------------------"
echo "Create client authenticating with SPIFFE"
echo "------------------------------------------------------------"

./kcadm.sh create clients -r spiffe -s clientId=myclient -s serviceAccountsEnabled=true -s clientAuthenticatorType=federated-jwt -s attributes='{ "jwt.credential.issuer": "spiffe", "jwt.credential.sub": "spiffe://apps.sno.irgendeine.cloud/ns/workload-identity-tutorial/sa/py" }'
