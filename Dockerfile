FROM centos:centos8

LABEL website="sangchul.kr"

ARG SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD:-root}

ENV SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD}
ENV TZ=Asia/Seoul

RUN echo $TZ > /etc/timezone

USER root

RUN sed -i "s/^mirrorlist=/#mirrorlist=/g" /etc/yum.repos.d/CentOS-Linux-* \
    && sed -i "s/#baseurl=http:\/\/mirror.centos.org/baseurl=http:\/\/vault.centos.org/g" /etc/yum.repos.d/CentOS-Linux-*

RUN yum install -y sudo \
        passwd shadow-utils \
        which net-tools iputils procps-ng \
        curl wget openssh-clients vim \
    && yum clean all \
    && rm -rf /var/cache/dnf/*

RUN echo "root:$SSH_ROOT_PASSWORD" | chpasswd \
    && cp -rf /etc/skel/.bash* /root/. \
    && echo 'export PS1="\[\033[01;32m\]\u\[\e[m\]\[\033[01;32m\]@\[\e[m\]\[\033[01;32m\]\h\[\e[m\]:\[\033[01;34m\]\W\[\e[m\]$ "' >> ~/.bashrc

CMD ["/usr/bin/bash"]
