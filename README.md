# docker-git-server

Runs a git server meant to be used in a [test container](https://www.testcontainers.org/).

When the container starts, it will create a repository at `/home/git/repo`. If a volume is mounted to `/root/repoFiles`, then that will be used to
seed the repository with an initial commit.

To set a public key for the repository to use, set the environment variable `SSH_PUBLIC_KEY` to the key value.

Build the container with a command like this:

```
docker build . -t git-server
```

Run the container with a command like this:

```
docker run -it --env SSH_PUBLIC_KEY="<public ssh key>" -p<port on host machine>:22 -v <absolute path to repo files>:/root/repoFiles  git-server
```

Clone the repo from the host machine with a command like this:

```
git clone ssh://git@localhost:<port>/~/repo
```
