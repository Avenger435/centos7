#!/bin/bash
sudo yum install -y epel-release
sudo yum install -y ansible
echo "ansible --version"
sudo ansible-galaxy --force install geerlingguy.postgresql
sudo ansible-playbook --inventory="localhost," -c local /vagrant/vaka-ansible.yml