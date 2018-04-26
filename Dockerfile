# Yves Hwang
# 29.11.2017

FROM jenkinsci/blueocean:1.3.3
MAINTAINER Yves Hwang <yveshwang@gmail.com>
LABEL name=jenkins-docker-2step
USER root
RUN apk update
RUN apk add py2-pip
RUN pip install --upgrade pip
RUN pip install --upgrade virtualenv
RUN pip install --upgrade setuptools
RUN pip install jenkins-job-builder==2.0.0.0b2
USER jenkins
