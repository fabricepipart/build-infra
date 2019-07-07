# http://people.redhat.com/jrivera/openshift-docs_preview/openshift-online/glusterfs-review/dev_guide/dev_tutorials/maven_tutorial.html
oc new-app sonatype/nexus
oc set probe dc/nexus \
	--liveness \
	--failure-threshold 3 \
	--initial-delay-seconds 30 \
	-- echo ok
oc set probe dc/nexus \
	--readiness \
	--failure-threshold 3 \
	--initial-delay-seconds 30 \
	--get-url=http://:8081/nexus/content/groups/public
