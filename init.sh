#!/usr/bin/env bash

log() {
    echo -e "\n\e[32m$1\e[m"
}

error() {
    echo -e "\n\e[31m$1\e[0m\n"
}

# Check if script is run with sudo
if [ $(id -u) -ne 0 ];
then
    error "Run the script with sudo"
    exit 1
fi

# Who invoked sudo, installation is done w.r.t this user
if [ -z "$SUDO_USER" ];
then
    error "env variable SUDO_USER is empty, don't know who invoked the script"
    exit 1
fi

log "Updating apt ..."
# apt-get update

# install git
if [ ! "$(git --version)" ];
then
    log "Installing git ..."
    apt install git
fi

# Create ~/Code directory for the non-sudo user
code_dir="/home/$SUDO_USER/Code"
[ ! -d "$code_dir" ] && install -d -o $SUDO_USER -g $SUDO_USER "$code_dir"

cd "$code_dir"
if [ ! -d "./WorkstationSetup" ];
then
    log "Downloading WorkstationSetup ..."
    git clone https://github.com/Nikhil-Wagh/WorkstationSetup.git
    chown -R $SUDO_USER:$SUDO_USER ./WorkstationSetup
fi
cd WorkstationSetup

# Check and install python3
if [ ! "$(python3 -V)" ];
then
    log "Python not installed, installing now ..."
    apt install software-properties-common
    add-apt-repository ppa:deadsnakes/ppa
    apt update
    apt install python
fi


# pip
if [ ! "$(pip -V)" ];
then
    log "Installing pip and it's pre-requisites ..."
    apt-get install python3-distutils
    apt-get install python3-testresources

    apt install python3-pip
fi

# Running these commands from root can have issues
# even if user is changed with su -c
log "Run the following commands:"
log "\tpython3 -m pip install --user ansible"
log "\tansible-playbook playbooks/ubuntu_setup.yml --extra_vars 'ansible_sudo_pass=<PASSWORD>"
log "DONE"