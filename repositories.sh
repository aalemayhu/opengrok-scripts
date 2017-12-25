#!/bin/bash

REPOSITORIES=(
https://github.com/cilium/cilium
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
)

for REPO in ${REPOSITORIES[@]}; do
  DIR=$HOME/src/`basename $REPO .git`
  if test -d $DIR; then
    git -C $DIR fetch origin master
  else
    git clone $REPO $DIR
  fi
  git -C $DIR checkout origin/master
done
