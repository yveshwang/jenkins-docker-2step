# Yves Hwang
# 27.04.2018

FROM jenkins:latest
MAINTAINER Yves Hwang <yveshwang@gmail.com>
LABEL name=jenkins-docker-2step
USER root
RUN apt-get update
RUN apt-get install python-pip -y
RUN pip install jenkins-job-builder
USER jenkins
