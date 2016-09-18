FROM ptrsoft/ubuntu-java8

ENV CROWD_VERSION 2.8.3
ENV CROWD_HOME /opt/home
ENV HOME /opt/home
RUN apt-get install -y telnet tcpdump ssh vim dnsutils git
RUN mkdir /opt/war && \
    mkdir /opt/home && \
    mkdir /opt/tomcat
WORKDIR /opt/tomcat
VOLUME ["/opt/home"]
VOLUME ["/opt/war"]
VOLUME ["/opt/tomcat"]

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
