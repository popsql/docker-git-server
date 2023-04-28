# docker-git-server

Git server for dbt

Runs a git server meant to be used in a test container.

The contents of the `git` directory are used as the initial commit of a repo named `repo`.

Pass the public key in an environment variable named `SSH_PUBLIC_KEY` and mount a volume containing the files for the initial commit into `/root/repoFiles/`

Build the container with a command like this:

`docker build . -t git-server`

Run the container with a command like this:

`docker run -it --env SSH_PUBLIC_KEY="<public ssh key>" -p<port on host machine>:22 -v <absolute path to repo files>:/root/repoFiles  git-server`

Clone the repo from the host machine with a command like this:

`git clone ssh://git@localhost:<port>/~/repo`
