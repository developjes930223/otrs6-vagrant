echo "installing requirements for make"
yum install -y lndir
yum install -y perl-App-cpanminus.noarch
yum install -y xmlrpc-c.i686

echo "cloning module tools"
cd /opt
sudo git clone https://github.com/OTRS/module-tools
cd module-tools
sudo cpanm --installdeps .
cp  ./etc/config.pl.dist ./etc/config.pl
cd /home/vagrant
sudo cp config.pl /opt/module-tools/etc

su -c "./otrs.Daemon.pl start" -s /bin/bash otrs


echo "go to: http://localhost:3002/otrs/installer.pl"
echo "Install Settings -> usr: root password: otrs-ioa"
echo "Vagrant VM credentials -> usr: vagrant password: vagrant"
