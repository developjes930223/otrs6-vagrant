echo "Copying config file"
sudo mv Config.pm /opt/otrs/Kernel/Config.pm
sudo chown otrs:www-data /opt/otrs/Kernel/Config.pm
sudo chmod 770 /opt/otrs/Kernel/Config.pm

echo "Installing database..."
cd /tmp
wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
sudo yum -y update
sudo yum install -y mysql-community-server.x86_64
sudo systemctl start mysqld

mysql --user=root <<_EOF_
UPDATE mysql.user SET Password=PASSWORD('otrs-ioa') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
_EOF_

echo "Setting max_allowed_packets"
sed 's/^\[mysqld\]/\[mysqld\]\nmax_allowed_packet=100M/' /etc/my.cnf > /tmp/server.cnf
cp /tmp/server.cnf /etc/my.cnf

sed 's/^\[mysqld\]/\[mysqld\]\nskip-character-set-client-handshake/' /etc/my.cnf > /tmp/server.cnf
cp /tmp/server.cnf /etc/my.cnf

sed 's/^\[mysqld\]/\[mysqld\]\ncollation-server=utf8_unicode_ci/' /etc/my.cnf > /tmp/server.cnf
cp /tmp/server.cnf /etc/my.cnf

sed 's/^\[mysqld\]/\[mysqld\]\ncharacter-set-server=utf8/' /etc/my.cnf > /tmp/server.cnf
cp /tmp/server.cnf /etc/my.cnf

sed 's/^\[mysqld\]/\[mysqld\]\ninnodb_log_file_size=256M/' /etc/my.cnf > /tmp/server.cnf
cp /tmp/server.cnf /etc/my.cnf

sudo systemctl restart mysqld
sudo systemctl enable mysqld
