sudo apt-get -y install openjdk-7-jdk
wget 'http://subsonic.org/download/subsonic-5.2.1.deb'
sudo dpkg -i subsonic-5.2.1.deb

sudo apt-get -y install apache2
sudo a2enmod proxy_http
cat <<EOF | sudo tee /etc/apache2/sites-available/subsonic.kaosfield.net.conf
<VirtualHost *:80>
  ServerName subsonic.kaosfield.net

  ProxyRequests Off
  <Proxy *>
    Order deny,allow
    Allow from all
  </Proxy>

  ProxyPass / http://localhost:4040/
  ProxyPassReverse / http://localhost:4040/

  # Possible values include: debug, info, notice, warn, error, crit,
  # alert, emerg.
  LogLevel warn
  CustomLog \${APACHE_LOG_DIR}/subsonic-access.log combined
  ErrorLog \${APACHE_LOG_DIR}/subsonic-error.log
</VirtualHost>
EOF
sudo a2ensite subsonic.kaosfield.net
sudo service apache2 restart

# Backup
# All music directories and "/var/subsonic" directory
