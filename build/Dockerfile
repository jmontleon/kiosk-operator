FROM quay.io/operator-framework/ansible-operator:latest

USER root
RUN yum -y update && yum clean all
RUN mkdir /.ansible && chmod 777 /.ansible
USER 1001
COPY watches.yaml ${HOME}/watches.yaml

COPY roles/ ${HOME}/roles/
