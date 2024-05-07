#!/bin/bash

pac=`dpkg-query -l | grep 'apache2 '`
#Проверяем установился ли пакет
if [ -z "$pac" ]
then
        echo "Пакет apache2 не установлен. Идем ставить"
apt install apache2 -y
else
        echo "Пакет apache2 успешно установлен"
fi
#Ставим репозиторий git
git=`ls -al /etc/apache2/ | grep .git`
if [ -z "$git" ]
then
        echo "Репозиторий git не стоит. Идем ставить"
cd /etc/apache2/
pwd
git init
git config --global user.name "Alex Borovets"
git config --global user.email tkaa@reso-med.com
git add apache2.conf
git add sites-available/
git add sites-enabled/
git add ports.conf
git commit -m 'Конфиги apache2'
git config pull.rebase true
git pull https://github.com/otuskurs/apache2_conf.git master
git rebase --skip
else
        echo "Репозиторий git установлен"
fi
#Ставим репозиторий git
git2=`ls -al /var/www/html/ | grep .git`
if [ -z "$git2" ]
then
        echo "Репозиторий git www не стоит. Идем ставить"
cd /var/www/html/
pwd
git init
git config --global user.name "Alex Borovets"
git config --global user.email tkaa@reso-med.com
git add index.html
git commit -m 'Конфиги apache1 www'
git config pull.rebase true
git pull https://github.com/otuskurs/apache2_conf.git master-www
git rebase --skip
else
        echo "Репозиторий git www установлен"
fi
systemctl reload apache2

