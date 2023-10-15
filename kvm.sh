#!/bin/bash

## Instructions from https://linuxgenie.net/how-to-install-kvm-on-ubuntu-22-04/ 

egrep -c '(vmx|svm)' /proc/cpuinfo

sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils -y

kvm-ok

sudo systemctl enable libvirtd
sudo systemctl start libvirtd
sudo systemctl status libvirtd

sudo usermod -aG kvm ${USER} 
sudo usermod -aG libvirt ${USER}

sudo nano /etc/netplan/01-netcfg.yaml
