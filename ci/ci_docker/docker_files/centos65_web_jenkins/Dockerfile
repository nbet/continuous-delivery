FROM centos:6.5
MAINTAINER nbet <nbet@163.com>

RUN yum install -y unzip
COPY v2.9.0.zip /mydir/
RUN cd /mydir && unzip v2.9.0.zip
RUN cd /mydir/git-2.9.0 && yum install -y curl curl-devel zlib-devel openssl-devel perl cpio expat-devel gettext-devel perl-CPAN perl-devel gcc autoconf automake libtool
RUN cd /mydir/git-2.9.0 && make configure && ./configure --prefix=/usr && make && make install

RUN yum install -y wget
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
RUN yum install -y jenkins-1.651

RUN yum install -y expect openssh-clients npm
RUN npm install -y bower gulp -g

COPY jdk-8u92-linux-x64.rpm /mydir/
RUN cd /mydir && rpm -ivh jdk-8u92-linux-x64.rpm
ENV JAVA_HOME=/usr/java/jdk1.8.0_92
ENV PATH=$JAVA_HOME/bin:$PATH

CMD service jenkins start && tail -f /dev/null

