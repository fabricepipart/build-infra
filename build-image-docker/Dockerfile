FROM maven:3.5-jdk-8-alpine
RUN mkdir -p /usr/share/maven/ref/repository && \
    chmod 777 -R /usr/share/maven/ref/repository
COPY settings.xml /usr/share/maven/conf/settings.xml
RUN apk add git