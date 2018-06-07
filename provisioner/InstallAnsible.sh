#!/bin/bash
pubfile=/home/vagrant/.ssh/id_rsa.pub
symlnkhost=/etc/ansible/hosts
symlnkcfg=/etc/ansible/ansible.cfg
sudo yum update -y --exclude=kernel
sudo yum install epel-release -y
sudo yum install ansible -y
ansible --version | head -1
#sudo cat << 'EOF' >> /home/vagrant/hosts
#[webservers]
#192.168.33.30
#192.168.33.40
#[LB]
#192.168.33.100
#EOF

if [ ! -L "$symlnkhost" ] ; then
sudo mv -f /etc/ansible/hosts /etc/ansible/hosts_old 2> /dev/null
sudo ln -s /vagrant/ansible_conf/hosts /etc/ansible/hosts
fi
if [ ! -L "$symlnkcfg" ] ; then
sudo mv /etc/ansible/ansible.cfg /etc/ansible/ansiblebk.cfg 2> /dev/null
sudo ln -s /vagrant/ansible_conf/ansible.cfg  /etc/ansible/ansible.cfg
fi
#sudo cp -rf /home/vagrant/hosts /etc/ansible/hosts

if [ ! -f "$pubfile" ]; then
    echo "Pub key does not exist. Creating the one"
   sudo cat /dev/zero | ssh-keygen -b 2048 -t rsa -q -N ""
fi

#$ vagrant.exe provision ansible
