FROM centos:centos8

LABEL website="sangchul.kr"

ARG SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD:-root}
ARG SSH_USER=${SSH_USER:-centos}
ARG SSH_PASSWORD=${SSH_PASSWORD:-centos}

ENV SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD}
ENV SSH_USER=${SSH_USER}
ENV SSH_PASSWORD=${SSH_PASSWORD}

ENV TZ=Asia/Seoul

RUN echo $TZ > /etc/timezone

USER root

RUN sed -i "s/mirrorlist=/#mirrorlist=/g" /etc/yum.repos.d/CentOS-* \
  && sed -i "s/#baseurl=http:\/\/mirror.centos.org/baseurl=http:\/\/vault.centos.org/g" /etc/yum.repos.d/CentOS-* \
  && yum install -y systemd sudo passwd shadow-utils \
    openssh-server openssh-clients \
    # wget git\
    net-tools iputils vim \
  && yum clean all \
  && rm -rf /var/cache/dnf

RUN echo "root:$SSH_ROOT_PASSWORD" | chpasswd \
    && cp -rf /etc/skel/.bash* /root/. \
    && echo 'export PS1="\[\033[01;32m\]\u\[\e[m\]\[\033[01;32m\]@\[\e[m\]\[\033[01;32m\]\h\[\e[m\]:\[\033[01;34m\]\W\[\e[m\]$ "' >> ~/.bashrc \
    && ssh-keygen -A

RUN useradd -c "$SSH_USER" -m -d /home/$SSH_USER -s /bin/bash $SSH_USER \
    && usermod -aG sudo $SSH_USER \
    && echo "$SSH_USER:$SSH_PASSWORD" | chpasswd \
    && echo 'export PS1="\[\e[33m\]\u\[\e[m\]\[\e[37m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\]:\[\033[01;31m\]\W\[\e[m\]$ "' >> /home/$SSH_USER/.bashrc \
    && echo -e "$SSH_USER\tALL=(ALL)\tNOPASSWD:ALL" >> /etc/sudoers

RUN mkdir /var/run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config \
    && sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
