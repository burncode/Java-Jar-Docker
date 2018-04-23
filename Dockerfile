FROM centos:7

RUN yum -y install wget
RUN yum -y install unzip

RUN wget http://docker.war.deployments.s3.amazonaws.com/third-party/jdk/jdk-8u171-linux-x64.rpm
RUN yum -y localinstall jdk-8u171-linux-x64.rpm
RUN export JAVA_HOME=/usr/java/jdk1.8.0_171-amd64/jre
RUN sh -c "echo export JAVA_HOME=/usr/java/jdk1.8.0_171-amd64/jre >> /etc/environment"
RUN rm jdk-8u171-linux-x64.rpm

RUN yum -y install initscripts && yum clean all

COPY emailerV2 /etc/init.d/emailerV2

RUN chmod +x /etc/init.d/emailerV2

RUN chkconfig emailerV2 on

COPY emailer-v2.sh /usr/local/bin/emailer-v2.sh

ARG FILE_NAME_CONFIGURATION
ARG PATH_NAME_CONFIGURATION

RUN mkdir $PATH_NAME_CONFIGURATION

COPY $FILE_NAME_CONFIGURATION $PATH_NAME_CONFIGURATION

ARG URL_JAR
ADD $URL_JAR $PATH_NAME_CONFIGURATION

#RUN ln -sf /dev/stdout /root/tomcat/logs/catalina.out

CMD ["sh", "/usr/local/bin/emailer-v2.sh"]

EXPOSE 8000
