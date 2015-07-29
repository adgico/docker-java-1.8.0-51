FROM       ubuntu:14.04
MAINTAINER Byran Wills-Heath <byran@adgico.co.uk>

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y curl
RUN apt-get install -y unzip

RUN mkdir /usr/local/java
WORKDIR /usr/local/java

RUN (curl -L -k -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u51-b16/jre-8u51-linux-x64.tar.gz | gunzip -c | tar x)

RUN curl -L -k -b "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip > /tmp/jce_policy-8.zip &&\
unzip -p /tmp/jce_policy-8.zip UnlimitedJCEPolicyJDK8/local_policy.jar > jre1.8.0_51/lib/security/local_policy.jar &&\
unzip -p /tmp/jce_policy-8.zip UnlimitedJCEPolicyJDK8/US_export_policy.jar > jre1.8.0_51/lib/security/US_export_policy.jar &&\
rm /tmp/jce_policy-8.zip

ENV JRE_HOME=/usr/local/java/jre1.8.0_51
ENV PATH=$PATH:$JRE_HOME/bin

RUN update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jre1.8.0_51/bin/java" 1
RUN update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/local/java/jre1.8.0_51/bin/javaws" 1
RUN update-alternatives --set java /usr/local/java/jre1.8.0_51/bin/java
RUN update-alternatives --set javaws /usr/local/java/jre1.8.0_51/bin/javaws
