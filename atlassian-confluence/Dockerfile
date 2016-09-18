FROM ptrsoft/ubuntu-java8

ENV CONFLUENCE_VERSION 5.8.6
ENV CONFLUENCE_HOME /opt/home
ENV HOME /opt/home
RUN apt-get install -y telnet tcpdump ssh vim dnsutils git
RUN mkdir /opt/war && \
    mkdir /opt/home && \
    mkdir /opt/tomcat
WORKDIR /opt/tomcat
VOLUME ["/opt/war"]
VOLUME ["/opt/home"]
VOLUME ["/opt/tomcat"]

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
