#!/bin/bash

## Instructions from https://tecmint.com/install-kvm-on-ubuntu/

egrep -c '(vmx|svm' /proc/cpuinfo

// if above is greater than 1 then virtualisation is supported

sudo apt-get install kvm-ok

sudo kvm-ok
// if output = KVM acceleration can be used

sudo apt install -y qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager

sudo systemctl status libvirtd

sudo systemctl enable --now libvirtd

#lsmod | grep -i kvm
