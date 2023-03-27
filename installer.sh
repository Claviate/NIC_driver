#!/bin/bash
apt-get update
git clone https://github.com/Claviate/NIC_driver.git
apt install gcc make -y
apt-get install linux-headers-4.19.0-23-amd64 -y

cd NIC_driver/e1000e-3.8.4/src
make install
cd
modprobe e1000e

sudo tee -a /etc/network/interfaces <<< "
allow-hotplug eno1
iface eno1 inet static
    address 10.10.10.240
    netmask 255.255.255.0
    gateway 10.10.10.1
    mtu 9000
"

ifdown eno1
ifup eno1

update-initramfs -u
