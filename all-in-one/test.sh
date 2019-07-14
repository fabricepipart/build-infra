#!/bin/bash
set -v
set -e

oc delete pod testit --ignore-not-found=true
oc run testit --image=docker-registry.default.svc:5000/ci/all-in-one:mvn36-jdk8-git-oc-py --image-pull-policy='Always' --restart=Never --command -- sleep 60
while ! oc exec -it testit -- true > /dev/null; do echo 'Not started yet ...'; sleep 2; done
echo '-------------- Test Java' 
oc exec -it testit -- java -version 
echo '-------------- Test Maven' 
oc exec -it testit -- mvn -version 
echo '-------------- Test Git' 
oc exec -it testit -- git version 
echo '-------------- Test Python' 
oc exec -it testit -- python3 -V 
echo '-------------- Test OC' 
oc exec -it testit -- oc version