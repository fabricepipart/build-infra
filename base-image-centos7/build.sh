oc project ci
oc delete bc/maven-centos-build-image-35
oc new-build --strategy docker --name maven-centos-build-image-35 --to='maven-centos-build-image-35:mvn35-jdk8-git' .
oc start-build maven-centos-build-image-35 --from-dir . --follow
