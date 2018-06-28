FROM centos:latest

EXPOSE 80

RUN curl https://repo.saltstack.com/yum/redhat/7.4/x86_64/2018.3/SALTSTACK-GPG-KEY.pub > /tmp/SALTSTACK-GPG-KEY.pub; rpm --import /tmp/SALTSTACK-GPG-KEY.pub; rm -f /tmp/SALTSTACK-GPG-KEY.pub
RUN yum -y install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm
RUN yum -y clean expire-cache; yum -y install salt-master salt-api
RUN groupadd salt
RUN useradd -ms /bin/bash -G salt salttest
RUN echo 'salttest:test' | chpasswd
COPY master /etc/salt/master
CMD ["/bin/bash","-c","/usr/bin/salt-master -d && /usr/bin/salt-api -l profile"]
