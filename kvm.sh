#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

NAME="KVM"
require_systemd
require_no_wsl

## Instructions from https://linuxgenie.net/how-to-install-kvm-on-ubuntu-22-04/ 

egrep -c '(vmx|svm)' /proc/cpuinfo

sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils -y

kvm-ok

sudo systemctl enable libvirtd
sudo systemctl start libvirtd
sudo systemctl status libvirtd

sudo usermod -aG kvm ${USER} 
sudo usermod -aG libvirt ${USER}

# NOTE. This used to end in `sudo nano /etc/netplan/01-netcfg.yaml`, which hung
# any unattended run (installeverything, cloud-init, CI) forever. Bridge setup is
# a manual, machine-specific step -- say so instead of blocking.
cat <<'EOM'

  Next step, by hand: to give VMs a bridged NIC, edit /etc/netplan/01-netcfg.yaml
  and add a br0 bridge over your physical interface, then `sudo netplan apply`.

EOM
