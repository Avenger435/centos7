#!/usr/bin/env bash
cd /home/vagrant/pgadmin4
source bin/activate
python /home/vagrant/pgadmin4/lib/python3.6/site-packages/pgadmin4/pgAdmin4.py &
sleep 3
google-chrome http://localhost:5050 &