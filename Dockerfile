FROM jboss/base:latest
MAINTAINER Jeff Sun

ENV JBOSS_HOME /opt/jboss-as-7.1.0.Final

# User root user to install software
USER root

# Install necessary packages
RUN yum -y install java-1.6.0-openjdk-devel java-1.6.0-openjdk && yum clean all

# Switch back to jboss user


RUN cd $HOME \
    && curl -O http://download.jboss.org/jbossas/7.1/jboss-as-7.1.0.Final/jboss-as-7.1.0.Final.zip \
    && unzip jboss-as-7.1.0.Final.zip \
    && mv jboss-as-7.1.0.Final /opt \
    && rm -f jboss-as-7.1.0.Final.zip \
    && chown -R jboss:0 /opt/jboss-as-7.1.0.Final \
    && chmod -R g+rw /opt/jboss-as-7.1.0.Final

USER jboss

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/lib/jvm/java

EXPOSE 8080

CMD ["/opt/jboss-as-7.1.0.Final/bin/standalone.sh", "-b", "0.0.0.0"]