# ref. https://www.virtualbox.org/wiki/Linux_Downloads
sudo aptitude install libqt4-opengl
wget http://download.virtualbox.org/virtualbox/4.3.14/virtualbox-4.3_4.3.14-95030~Ubuntu~raring_amd64.deb
sudo dpkg -i 'virtualbox-4.3_4.3.14-95030~Ubuntu~raring_amd64.deb'

# ref. http://www.vagrantup.com/downloads.html
wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb
sudo dpkg -i vagrant_1.6.3_x86_64.deb