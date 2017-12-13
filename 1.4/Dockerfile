FROM centos:centos7
MAINTAINER Robert Kubiś <robert.h3x@gmail.com>

# ARG can be overwritten on build time using "docker build --build-arg name=value"
ARG CMK_VERSION_ARG="1.4.0p19"
ARG CMK_DOWNLOADNR_ARG="66"
ARG CMK_SITE_ARG="rkubis"
ARG MAILHUB="undefined"

# After Build the ENV vars are initialized with the value of there build argument.
ENV CMK_VERSION=${CMK_VERSION_ARG}
ENV CMK_DOWNLOADNR=${CMK_DOWNLOADNR_ARG}
ENV CMK_SITE=${CMK_SITE_ARG}
ENV MAILHUB=${MAILHUB}

# Update OS
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all

# Download and install rpm package
#RUN rpm -ivh https://mathias-kettner.de/support/${CMK_VERSION}/check-mk-raw-${CMK_VERSION}-el7-${CMK_DOWNLOADNR}.x86_64.rpm

COPY ./check-mk-raw-1.4.0p21-el7-68.x86_64.rpm /tmp/
RUN yum install -y /tmp/check-mk-raw-1.4.0p21-el7-68.x86_64.rpm


# Additional packages for own usages
RUN yum -y install \
           htop \
           wget \
           vim \
           net-tools \
           mlocate \
           the_silver_searcher \
           && yum clean all


# Creation of the site fails on creating tempfs, ignore it.
# Now turn tempfs off after creating the site
RUN omd create ${CMK_SITE} || \
    omd init ${CMK_SITE} && \
    omd config ${CMK_SITE} set DEFAULT_GUI check_mk && \
    omd config ${CMK_SITE} set TMPFS off && \
    omd config ${CMK_SITE} set CRONTAB on && \
    omd config ${CMK_SITE} set APACHE_TCP_ADDR 0.0.0.0 && \
    omd config ${CMK_SITE} set APACHE_TCP_PORT 5000 && \
    htpasswd -b -m /omd/sites/${CMK_SITE}/etc/htpasswd cmkadmin omd && \
    ln -s "/omd/sites/${CMK_SITE}/var/log/nagios.log" /var/log/nagios.log

RUN updatedb


COPY bootstrap.sh /opt/

#Exposing ports from docker container
EXPOSE 5000/tcp

WORKDIR /omd
ENTRYPOINT ["/opt/bootstrap.sh"]

## Set default command
CMD ["/usr/bin/bash"]
