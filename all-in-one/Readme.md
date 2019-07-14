# To test locally

oc delete pod testit --ignore-not-found=true
oc run testit -it --image=docker-registry.default.svc:5000/ci/all-in-one:mvn36-jdk8-git-oc-py --image-pull-policy='Always' --restart=Never --command -- sh

# Inspiration

https://github.com/openshift/jenkins/blob/master/agent-maven-3.5/Dockerfile.rhel7