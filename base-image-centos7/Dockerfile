FROM openshift/jenkins-agent-maven-35-centos7

USER root

RUN yum install -y java-1.8.0-openjdk-devel rh-python36 && \
    yum clean all -y

RUN mkdir -p /opt/rh/rh-maven35/root/usr/share/maven/ref/repository && \
    chmod 777 -R /opt/rh/rh-maven35/root/usr/share/maven/ref/repository
COPY settings.xml /opt/rh/rh-maven35/root/usr/share/maven/conf/settings.xml

RUN source scl_source enable rh-python36 && \
    echo "source scl_source enable rh-python36" >> /usr/local/bin/scl_enable && \
    chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME 

#USER 1001