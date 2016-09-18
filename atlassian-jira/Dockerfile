FROM ptrsoft/ubuntu-java8 

ENV JIRA_VERSION 6.4.9
ENV JIRA_HOME /opt/home
ENV HOME /opt/home
RUN apt-get install -y telnet tcpdump ssh vim dnsutils git
RUN mkdir /opt/war && \
    mkdir /opt/home && \
    mkdir /opt/tomcat 

WORKDIR /opt/tomcat
VOLUME ["/opt/home"]
VOLUME ["/opt/war"]
VOLUME ["/opt/tomcat"]
VOLUME ["/opt/java"]

CMD ["/opt/tomcat/bin/catalina.sh", "run"]

