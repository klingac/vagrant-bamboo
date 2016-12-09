BAMBOO_VERSION=5.13.2

apt-get -y update
apt-get -y upgrade
apt-get -y install vim curl nmap tree zip htop upstart 
apt-get -y install openjdk-8-jre-headless

#wget http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-5.6.2.tar.gz
wget -q https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-$BAMBOO_VERSION.tar.gz
cp /vagrant/atlassian-bamboo-$BAMBOO_VERSION.tar.gz ~
tar -zxf atlassian-bamboo-$BAMBOO_VERSION.tar.gz
mv atlassian-bamboo-$BAMBOO_VERSION /opt/bamboo-server
chown -R www-data /opt/bamboo-server

mkdir /vagrant/bamboo-server
chown -R www-data /vagrant/bamboo-server
cp /opt/bamboo-server/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties /opt/bamboo-server/atlassian-bamboo/WEB-INF/classes/bamboo-init.dist.properties
sed -e "s/#bamboo.home=C:\/bamboo\/bamboo-home/bamboo.home=\/vagrant\/bamboo-server/g" \
    -i /opt/bamboo-server/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties

cp /vagrant/bamboo-server.init /etc/init.d/bamboo-server
chmod -R go+w /opt/bamboo-server/logs
chmod +x /etc/init.d/bamboo-server
update-rc.d bamboo-server defaults
/etc/init.d/bamboo-server start
