      nodeSelector:
        node-role.kubernetes.io/infra: true

oc label node  node2.gra1.h-y.fr hostpath-data=true


        oc delete pvc jenkins






        oc delete template jenkins-persistent-hostpath -n openshift
oc create -f jenkins-persistent-hostpath.yaml 

oc process -f jenkins-persistent-hostpath.yaml  | oc create -f -
oc delete all,sa,rolebindings -l template=jenkins-persistent-hostpath-template

        volumes:
        - name: ${JENKINS_SERVICE_NAME}-data
          hostPath:
            path: /mnt/data/jenkins





            oc adm policy add-scc-to-user hostaccess -z jenkins



oc adm policy add-role-to-user admin system:serviceaccount:ci:jenkins -n teknichrono-staging

oc policy add-role-to-user system:image-puller system:serviceaccount:teknichrono-staging:default -n ci