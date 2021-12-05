FROM ubuntu:focal AS base
RUN apt update && \
    apt upgrade -y && \
    apt install -y software-properties-common && \
    add-apt-repository --yes --update ppa:ansible/ansible && \
    apt update && \
    apt install ansible sudo -y

FROM base AS user
RUN addgroup --gid 1000 mthorning
RUN adduser --gecos mthorning --uid 1000 --gid 1000 --disabled-password mthorning
RUN echo "mthorning ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers
RUN sed -i "s/required/sufficient/" /etc/pam.d/chsh
ENV USER=mthorning
USER mthorning
WORKDIR /home/mthorning

FROM user
COPY . ./ansible
WORKDIR /home/mthorning/ansible
CMD ansible-playbook --vault-password-file .vault-pass terminal.yml && zsh
