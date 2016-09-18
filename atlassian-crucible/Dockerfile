FROM ptrsoft/ubuntu-java8 
ENV FISHEYE_HOME /opt/instance
RUN apt-get install -y telnet tcpdump ssh vim dnsutils git
RUN mkdir /opt/instance
WORKDIR /opt/instance
VOLUME ["/opt/instance"]
CMD ["/opt/instance/bin/fisheyectl.sh","run"]
