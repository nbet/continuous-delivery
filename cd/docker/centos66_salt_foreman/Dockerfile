FROM centos:6.6

RUN yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-2015.8-3.el6.noarch.rpm
RUN yum clean expire-cache && yum install -y salt-master && yum install -y salt-api

RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN yum -y install epel-release https://yum.theforeman.org/releases/1.11/el6/x86_64/foreman-release.rpm
RUN yum -y install foreman-installer

COPY network /etc/sysconfig/
ENV HOSTNAME saltmaster.devops.company.com
ENV FACTER_fqdn saltmaster.devops.company.com

COPY modify_hosts.sh /tmp
WORKDIR /tmp
RUN bash modify_hosts.sh  && foreman-installer --enable-foreman-plugin-salt --enable-foreman-proxy-plugin-salt > /tmp/foreman_log 
RUN cat foreman_log | grep admin | awk '{print $6}' > password


RUN touch /etc/salt/autosign.conf && chgrp foreman-proxy /etc/salt/autosign.conf && chmod g+w /etc/salt/autosign.conf && echo "*" > /etc/salt/autosign.conf
COPY passwd.exp /tmp
RUN yum install -y expect && useradd saltuser && expect passwd.exp

COPY sudoers /etc/sudoers
COPY master /etc/salt/
COPY foreman.yaml /etc/salt/
COPY salt.yml /etc/foreman-proxy/settings.d/
COPY master.py /usr/lib/python2.6/site-packages/salt/
COPY foreman-node /usr/lib/ruby/gems/1.8/gems/smart_proxy_salt-2.1.6/bin/

COPY *.sh /tmp/
RUN chmod +x /tmp/*.sh
CMD /tmp/run.sh && tail -f /dev/null


