FROM ubuntu
MAINTAINER	Richard

RUN 	apt-get update && \
        apt-get -y upgrade && \
        apt-get install -y python-software-properties software-properties-common wget supervisor && \
        add-apt-repository -y ppa:webupd8team/java && \
        echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
        apt-get update &&     apt-get install -y oracle-java8-installer  && \
	apt-get install wget -y

RUN wget http://mirror.fibergrid.in/apache/tomcat/tomcat-9/v9.0.0.M4/bin/apache-tomcat-9.0.0.M4.tar.gz
RUN tar zxvf apache-tomcat-9.0.0.M4.tar.gz
RUN mv apache-tomcat-9.0.0.M4 /usr/local/tomcat

ENV CATALINA_HOME=/usr/local/tomcat

ADD tomcat-users.xml   /usr/local/tomcat/conf/tomcat-users.xml

ENV     JAVA_HOME /usr/lib/jvm/java-8-oracle

EXPOSE 8080

ENTRYPOINT ["/usr/local/tomcat/bin/catalina.sh","run"]



