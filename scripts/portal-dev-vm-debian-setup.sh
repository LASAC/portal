############## VM SETUP (virtualbox) ###############

# Useful links:
# Virtualbox Host-Only Static IP: https://gist.github.com/pjdietz/5768124
# Vagrant Debian 8.5 (maybe next time): https://app.vagrantup.com/bento/boxes/debian-8.5
# Vagrant Debian Jessie: https://app.vagrantup.com/debian/boxes/jessie64

#
# If virtual Machine:
# things to do in the HOST
#

# (host) Add port forwarding
VBoxManage modifyvm debian --natpf1 "ssh,tcp,,2222,,22"
# (host) Run in background: 
VBoxHeadless -s debian &

# (host) upload backup file
scp -P 2222 170813-lasac.tar.gz glandre@127.0.0.1:/home/glandre

# (host) Access via ssh
ssh -p 2222 glandre@127.0.0.1

#
# If virtual Machine:
# things to do in the GUEST
#

# (guest) Set up host-only static ip address:
su -
# (guest) persistent (works after reboot):
nano /etc/network/interface
# (guest) add as follows:
#auto eth1
#iface eth1 inet static
#      address 192.168.10.10
#      netmask 255.255.255.0

# (guest) temporary (works in the current session):
ifconfig eth1 192.168.10.10 netmask 255.255.255.0 up

# (guest) install sudo
apt-get install sudo
reboot