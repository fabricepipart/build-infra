# https://keycloak.discourse.group/t/getting-invalid-parameter-redirect-uri-when-installed-with-keycloak-operator/830
# https://github.com/keycloak/keycloak-operator


cd keycloak-operator
# Adapt namespace name in Makefile and next lines
make cluster/prepare
kubectl apply -f deploy/operator.yaml -n keycloak
kubectl apply -f deploy/examples/keycloak/keycloak.yaml -n keycloak

