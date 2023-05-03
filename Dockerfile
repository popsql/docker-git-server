FROM alpine:3

RUN apk add --no-cache \
  openssh-server \
  runuser \
  git

RUN ssh-keygen -A

# -D flag avoids password generation
RUN adduser -D -h /home/git git \
  && echo git:12345 | chpasswd

USER git
WORKDIR /home/git/

RUN  git config --global user.email "user@example.com" && \
  git config --global user.name "user"

RUN mkdir .ssh \
  && chmod -R 700 .ssh

USER root
WORKDIR /root

COPY start.sh .
COPY sshd-config /etc/ssh/

EXPOSE 22

CMD ["sh", "start.sh"]
