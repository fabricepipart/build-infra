# To test locally

oc run testit -it --image=docker-registry.default.svc:5000/ci/maven-centos-build-image-35:mvn35-jdk8-git --restart=Never --command -- bash 

# Inspiration

https://github.com/openshift/jenkins/blob/master/agent-maven-3.5/Dockerfile.rhel7