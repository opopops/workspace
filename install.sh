#!/bin/bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "# --- update brew"
if [[ ! -f /usr/local/bin/brew ]]
then
  echo "# --- install brew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

BREW_PACKAGES="\
  bash-completion \
  bash-git-prompt \
  gettext \
  git \
  gnupg \
  netcat \
  python \
  sshfs"

brew install $BREW_PACKAGES

# --- bash
echo "# --- update bash"
ln -snf ${DIR}/bash/bash_profile ${HOME}/.bash_profile
ln -snf ${DIR}/bash/bashrc ${HOME}/.bashrc
ln -snf ${DIR}/bash/bash_aliases ${HOME}/.bash_aliases

# --- ssh
echo "# --- update ssh"
mkdir -p ${HOME}/.ssh/include
cp -f ${DIR}/ssh/config ${HOME}/.ssh/
[[ ! -f ${HOME}/.ssh/include ]] && cp -f ${DIR}/ssh/include/config ${HOME}/.ssh/include/
chmod 700 ${HOME}/.ssh
chmod 600 ${HOME}/.ssh/*
chmod 644 ${HOME}/.ssh/*.pub
