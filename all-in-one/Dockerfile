FROM quay.io/openshift/origin-jenkins-agent-base:v4.0

# Labels consumed by Red Hat build service
LABEL name="openshift3/jenkins-agent-maven-36-rhel7" \
      version="3.11" \
      architecture="x86_64" \
      io.k8s.display-name="Jenkins Agent Maven" \
      io.k8s.description="The jenkins agent maven image has the maven tools on top of the jenkins slave base image." \
      io.openshift.tags="openshift,jenkins,agent,maven,python3,git"

RUN chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME 

ADD configure-agent /usr/local/bin/configure-agent

# Maven
RUN wget https://www-eu.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz && \
    tar xvf apache-maven-3.6.0-bin.tar.gz -C /usr/lib/ && \
    mkdir -p /usr/lib/apache-maven-3.6.0/ref/repository && \
    chmod 777 -R /usr/lib/apache-maven-3.6.0/ref/repository
COPY settings.xml /usr/lib/apache-maven-3.6.0/conf/settings.xml
ENV MAVEN_VERSION="3.6" \
    GRADLE_VERSION="4.2.1" \
    M2_HOME="/usr/lib/apache-maven-3.6.0" \
    M2="/usr/lib/apache-maven-3.6.0/bin" \
    MAVEN_OPTS="-Xms256m -Xmx512m" \
    PATH="/usr/lib/apache-maven-3.6.0/bin:${PATH}"

# Install 
RUN INSTALL_PKGS="java-1.8.0-openjdk-devel gcc openssl-devel bzip2-devel make" && \
    curl https://raw.githubusercontent.com/cloudrouter/centos-repo/master/CentOS-Base.repo -o /etc/yum.repos.d/CentOS-Base.repo && \
    curl http://mirror.centos.org/centos-7/7/os/x86_64/RPM-GPG-KEY-CentOS-7 -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    DISABLES="--disablerepo=rhel-server-extras --disablerepo=rhel-server --disablerepo=rhel-fast-datapath --disablerepo=rhel-server-optional --disablerepo=rhel-server-ose --disablerepo=rhel-server-rhscl" && \
    yum $DISABLES install -y $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y

# Gradle
RUN curl -LOk https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip -d /opt && \
    rm -f gradle-${GRADLE_VERSION}-bin.zip && \
    ln -s /opt/gradle-${GRADLE_VERSION} /opt/gradle
ADD init.gradle $HOME/.gradle/

# Python 3.6
RUN cd /usr/src && \
    wget https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tgz && \
    tar xzf Python-3.6.8.tgz && \
    cd Python-3.6.8 && \
    ./configure --enable-optimizations --with-ensurepip=install && \
    make -j 8 && \
    make altinstall && \
    ln -s /usr/local/bin/python3.6 /usr/local/bin/python3 && \
    rm /usr/src/Python-3.6.8.tgz
USER 1001