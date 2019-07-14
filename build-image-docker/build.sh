oc project ci
oc new-build --strategy docker --name hy-maven-build-image-35 --to='hy-maven-build-image:3.5-jdk-8-centos' .
oc start-build hy-maven-build-image-35 --from-dir . --follow