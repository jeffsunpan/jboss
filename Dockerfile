FROM jboss/base:latest
MAINTAINER Jeff SunPan

ENV JBOSS_HOME /opt/jboss-as-7.1.0.Final
ENV JBOSS_VERSION 7.1.0.Final

# User root user to install software
USER root

# Install necessary packages
RUN yum -y install wget java-1.6.0-openjdk-devel java-1.6.0-openjdk && yum clean all

RUN cd $HOME \
    && wget http://download.jboss.org/jbossas/7.1/jboss-as-7.1.0.Final/jboss-as-${JBOSS_VERSION}.zip \
    && unzip jboss-as-${JBOSS_VERSION}.zip \
    && mv jboss-as-${JBOSS_VERSION} /opt \
    && rm -f jboss-as-${JBOSS_VERSION}.zip \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

# Switch back to jboss user
USER jboss

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/lib/jvm/java

EXPOSE 8080

CMD ["/opt/jboss-as-7.1.0.Final/bin/standalone.sh", "-b", "0.0.0.0"]
