#!/bin/sh

# configure the authorized keys (if any) to allow the client to connect via ssh
if [ "$SSH_PUBLIC_KEY" ]; then
  echo 'configuring authorized_keys...'
  cd /home/git
  echo $SSH_PUBLIC_KEY > .ssh/authorized_keys
  chown -R git:git .ssh
  chmod 700 .ssh
  chmod -R 600 .ssh/*
fi

# create an empty repo
echo 'creating repo...'
cd /home/git
su git -c "git init  --bare -b main repo"

# use the repo files (if any) to make an initial commit in the repo
if [ "$(ls -A /root/repoFiles/)" ]; then
  echo 'creating initial commit...'
  su git -c "git clone repo tmp"
  cp -rT /root/repoFiles tmp
  chown -R git:git tmp

  cd tmp
  su git -c "git add ."
  su git -c "git commit -m 'initial commit'"
  su git -c "git push"
  cd ..

  rm -rf tmp/
fi

echo 'starting ssh server...'
# -D flag avoids executing sshd as a daemon
/usr/sbin/sshd -D &

echo 'git server ready'
wait $!
