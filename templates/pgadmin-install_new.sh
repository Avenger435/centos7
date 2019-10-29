#!/usr/bin/env bash
cd /home/vagrant/
virtualenv -p python3 pgadmin4
sudo chown -R vagrant:vagrant /home/vagrant/pgadmin4
cd /home/vagrant/pgadmin4
source bin/activate
pip3 install /tmp/pgadmin4-3.2-py2.py3-none-any.whl
cp /vagrant/templates/config_local.py /home/vagrant/pgadmin4/lib/python3.6/site-packages/pgadmin4/config_local.py
cp /vagrant/templates/pgadmin4.sh /home/vagrant/pgadmin4/lib/python3.6/site-packages/pgadmin4/pgadmin4.sh
chmod 0777 /home/vagrant/pgadmin4/lib/python3.6/site-packages/pgadmin4/pgadmin4.sh
echo alias pgadmin4='/home/vagrant/pgadmin4/lib/python3.6/site-packages/pgadmin4/pgadmin4.sh' >> ~/.bachrc
sudo cp /vagrant/templates/pgadmin4.desktop /usr/share/applications/pgadmin4.desktop
sudo chown -R vagrant:vagrant /home/vagrant/pgadmin4
#source /home/vagrant/.bashrc
#python /home/vagrant/pgadmin4/lib/python3.6/site-packages/pgadmin4/pgAdmin4.py
