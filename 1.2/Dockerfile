FROM debian:wheezy
MAINTAINER Robert Kubiś robert.h3x@gmail.com

# dependency setup
RUN echo "nagios3-cgi nagios3/adminpassword string admin" | debconf-set-selections
RUN echo "nagios3-cgi nagios3/adminpassword-repeat string admin" | debconf-set-selections
RUN apt-get update
RUN apt-get install -y \
		check-mk-livestatus \
		build-essential \
		libapache2-mod-python \
		nagios3 \
		python \
		vim \
		telnet \
		mlocate \
		sudo && \
		apt-get clean

# Does not work with version above 1.2
#ENV CMK_VERSION 1.4.0p19

# In this version are problems with:
# "Invalid output from agent or invalid configuration: list index out of range"
#ENV CMK_VERSION 1.2.4p5

########### TODD ###########
# GOOD NEW - no problems with "Invalid output from agent" but :)
# need to fix passive checks always in pending state
# Some info here:
# http://forum.shinken-monitoring.org/threads/641-passive-check-with-check_mk-are-always-in-a-pending-state
#
# probably problems with nagios.cmd path in:
#/usr/share/check_mk/web/htdocs/defaults.py
#nagios_command_pipe_path    = '/var/log/nagios/rw/nagios.cmd'
#which could be change during install in
#/root/.check_mk_setup.conf
#ENV CMK_VERSION 1.2.8p26
ENV CMK_VERSION 1.2.6p2
########### TODD ###########

ENV CMK_FILE check_mk-$CMK_VERSION.tar.gz


# fix check_mk looking in wrong places
RUN cd /etc/ && ln -s nagios3 nagios
RUN cd /usr/sbin/ && ln -s nagios3 nagios
RUN cd /var/lib/ && rmdir nagios && ln -s nagios3 nagios
RUN cd /var/log/ && ln -s /var/lib/nagios3 nagios
RUN cd /etc/init.d/ && ln -s nagios3 nagios

# add default admin account
RUN cd /etc/nagios/ && htpasswd -bc htpasswd.users admin admin

# add sudo rules required for check_mk
RUN echo "Defaults:www-data !requiretty" >> /etc/sudoers
RUN echo "nagios ALL = (root) NOPASSWD: /usr/bin/check_mk --automation *" >> /etc/sudoers

# register livestatus
RUN echo "broker_module=/usr/lib/check_mk/livestatus.o /var/lib/nagios/rw/live" >> /etc/nagios3/nagios.cfg
RUN echo "event_broker_options=-1" >> /etc/nagios3/nagios.cfg

########### TODD ###########
# checkmk installation
# Your answers will be saved to /root/.check_mk_setup.conf and will be
# reused when you run the setup of this or a later version again. Please
# delete that file if you want to delete your previous answers.
ADD http://mathias-kettner.de/download/$CMK_FILE /setup/
#COPY check_mk_setup.conf_sjc /root/.check_mk_setup.conf
COPY check_mk_setup.conf /root/.check_mk_setup.conf
RUN cd /setup/ && tar -xf check_mk-$CMK_VERSION.tar.gz
RUN cd /setup/check_mk-$CMK_VERSION/ && bash setup.sh --yes

# fix check_mk config (again)
RUN sed -e 's/\/var\/log\/nagios\/rw\/live/\/var\/lib\/nagios3\/rw\/live/g' -i /usr/share/check_mk/web/htdocs/defaults.py
RUN sed -e 's/nagiosadmin/admin/g' -i /etc/check_mk/multisite.mk

RUN chown nagios /etc/nagios/htpasswd.users
RUN chown nagios /etc/nagios/auth.serials

RUN cd /var/lib/check_mk/wato && mkdir auth && chgrp nagios auth && chmod 770 auth/
#RUN usermod -a -G nagios www-data

# link check mk configuration to nagios
RUN sudo ln -s /etc/nagios3/objects/ /etc/nagios3/conf.d/

RUN sudo mkdir -p /usr/local/nagios/var/spool/checkresults
RUN sudo chown nagios:nagios /usr/local/nagios/var/spool/checkresults
RUN chown -R root:nagios /usr/lib/nagios/plugins/
RUN chmod u+s /usr/lib/nagios/plugins/*

# Keep for debugging
# RUN rm -rf /setup/*

RUN sudo echo "alias ll='ls -l'" >> /root/.bashrc

COPY check_mk/main.mk /etc/check_mk/

RUN updatedb

ADD run.sh /
CMD ["bash", "/run.sh"]
