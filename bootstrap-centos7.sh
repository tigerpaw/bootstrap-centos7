#!/bin/bash
# bootstrap-centos7.sh
# Version 1.0.0
# -
# curl -s https://raw.githubusercontent.com/tigerpaw/bootstrap-centos7/master/boostrap-centos7.sh | bash -s

function main() {
  # Is EPEL enabled?
  CHK_EPEL=$(yum list installed | grep epel-release)
  if [ -z "$CHK_EPEL" ]; then
    console_out "Enabling EPEL repository\n"
    yum install -y epel-release
  fi

  # Update binaries
  console_out "Running Sytem Update\n"
  yum update -y && yum upgrade -y

  console_out "Checking packages\n"
  CHK_PKGS=(
    "sudo"
    "zsh"
    "git.x86_64"
    "vim-enhanced"
    "htop"
    "curl"
    "wget"
    "screen"
    "tmux"
    "firewalld"
    "firewalld-filesystem"
  )
  PKGS=()
  # Check if any of these packages are already installed
  for i in "${CHK_PKGS[@]}"
  do
    CHK_PKG=$(yum list installed | grep $i)
    if [ -z "$CHK_PKG" ]; then
      console_out "Marking $i for installation\n"
      PKGS+=("$i")
    else
      console_out "Skipping $i\n"
    fi
  done
}

function console_out() {
  printf "[Bootstrapper] : $1"
}

main "$@"
