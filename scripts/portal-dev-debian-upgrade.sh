# Upgrading Debian Jessie to Debian Stretch
# guide: https://www.debian.org/releases/stable/amd64/release-notes/ch-upgrading.html

# Ways check Debian version (https://linuxconfig.org/check-what-debian-version-you-are-running-on-your-linux-system):
# cat /etc/issue
# cat /etc/debian_version
# cat /etc/os-release
# lsb_release -da
# hostnamectl

# Check if all required devices are mounted
# ways to check partitions: https://www.cyberciti.biz/faq/linux-list-disk-partitions-command/

# to be run as root
su -

# check your source list (see A.2. - https://www.debian.org/releases/stable/amd64/release-notes/ap-old-stuff.en.html#old-upgrade)
nano /etc/apt/sources.list

# if you find any, change stable to jessie
# lines in sources.list starting with “deb ftp:” and pointing to debian.org addresses should be changed into “deb http:”

# update apt
apt-get update

# run upgrade and dist-upgrade with the current version (before changing the sources.list)

# check if there is enough free space
apt-get -o APT::Get::Trivial-Only=true dist-upgrade
apt-get upgrade
apt-get dist-upgrade

#
# if the version was an old one (< 8.7), after this you should reboot the machine
#
# sudo reboot

# remove old configuration files (such as *.dpkg-{new,old} files under /etc) from the system. 
ls /etc/*.dpkg-{new,old}
# rm /etc/*.dpkg-{new,old}

# upgrade legacy locales to UTF-8
dpkg-reconfigure locales

# check pending aptitude actions:
aptitude
# in full-terminal press g ("Go")

# if any testing (sid) repository, consult 4.2.2

# record the session (see 4.4.1)
# script -t 2>~/upgrade-stretchstep.time -a ~/upgrade-stretchstep.script

#
# ACTUALLY UPGRADING:
#

# update sources list
# examples: https://wiki.debian.org/SourcesList (look for the ones corresponding to the local)
nano /etc/apt/sources.list
# check also if there's any file on /etc/apt/sources.list.d/

apt-get update

# check if there is free space
apt-get -o APT::Get::Trivial-Only=true dist-upgrade

# minimal (using script - to replay it: # scriptreplay ~/upgrade-stretch.time ~/upgrade-stretch.script)
script -t 2>~/upgrade-stretch-01minimal.time -a ~/upgrade-stretch-01minimal.script
apt-get upgrade
exit

# upgrading the system
script -t 2>~/upgrade-stretch-02actual.time -a ~/upgrade-stretch-02actual.script
apt-get dist-upgrade
exit

# troubleshooting
# initramfs-tools issue
# https://askubuntu.com/questions/367768/ubuntu-12-04-lts-initramfs-tools-dependency-issue
# # nano /var/lib/dpkg/status
# remove the two Packages (initramfs-tools and initramfs-tools-core)
# then run: apt-get -f install

# Ativar PHP 7
sudo a2dismod php5
sudo a2enmod php7.0
service apache2 restart

# later instllaition:
# /etc/vim/vimrc --> uncomment syntax on
# remove postgresql-9.4 postgresql-client-9.4 (updated: 9.6)