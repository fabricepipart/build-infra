oc project ci
oc delete bc/all-in-one
oc new-build --strategy docker --name all-in-one --to='all-in-one:mvn36-jdk8-git-oc-py' .
oc start-build all-in-one --from-dir . --follow
