FROM centos:6.5
MAINTAINER nbet <nbet@163.com>
WORKDIR /mydir

COPY jdk-8u92-linux-x64.rpm /mydir/
RUN cd /mydir && rpm -ivh jdk-8u92-linux-x64.rpm
ENV JAVA_HOME=/usr/java/jdk1.8.0_92
ENV PATH=$JAVA_HOME/bin:$PATH

RUN yum install -y wget
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
RUN yum install -y jenkins-1.651

RUN yum install -y unzip
COPY v2.9.1.zip /mydir/
RUN cd /mydir && unzip v2.9.1.zip
RUN cd /mydir/git-2.9.1 && yum install -y curl curl-devel zlib-devel openssl-devel perl cpio expat-devel gcc gettext-devel perl-CPAN perl-devel autoconf automake libtool
RUN cd /mydir/git-2.9.1 && make configure && ./configure --prefix=/usr && make && make install

RUN rm -rf /mydir

CMD service jenkins start && tail -f /dev/null

