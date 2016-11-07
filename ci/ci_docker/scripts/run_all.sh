docker run  -d --name="gcc_jenkins" -v /opt/data/gcc_jenkins:/var/lib/jenkins -p 8081:8080 centos65_gcc_jenkins
docker run  -d --name="java_jenkins" -v /opt/data/java_jenkins:/var/lib/jenkins -p 8082:8080 centos65_java_jenkins
docker run  -d --name="src_jenkins" -v /opt/data/src_jenkins:/var/lib/jenkins -p 8083:8080 centos65_src_jenkins
docker run  -d --name="web_jenkins" -v /opt/data/web_jenkins:/var/lib/jenkins -p 8084:8080 centos65_web_jenkins



