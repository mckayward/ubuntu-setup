sudo aptitude update
sudo aptitude safe-upgrade
sudo aptitude install zsh vim tmux git curl build-essential
chsh -s /usr/bin/zsh
# configure or get .zshrc .vimrc .screenrc .gitconfig
# logout
# login

# for local install
mkdir -p $HOME/local/src
mkdir -p $HOME/local/bin

# Ruby with rbenv + ruby-build
#  https://github.com/sstephenson/rbenv
#  https://github.com/sstephenson/ruby-build
sudo aptitude install zlib1g-dev libssl-dev libreadline6-dev
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshenv
echo 'eval "$(rbenv init -)"' >> ~/.zshenv
exec $SHELL -l
mkdir -p ~/.rbenv/plugins
cd ~/.rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git
cd
rbenv install 1.9.3-p194
rbenv global 1.9.3-p194
gem install bundler --no-ri --no-rdoc
rbenv rehash

# install SQLite3
sudo aptitude install sqlite3 libsqlite3-dev

# install Rails with Bundler and test
echo 'source :rubygems' >> Gemfile
echo "gem 'rails', '3.2.6'" >> Gemfile
bundle install
bundle exec rails new sample
cd sample
echo "gem 'therubyracer'" >> Gemfile
bundle install
bundle exec rails g scaffold item name:string price:integer
bundle exec rake db:migrate
bundle exec rake
bundle exec rails s

# install and configure PostgreSQL
# ref. install-postgresql.sh

# Rails with PostgreSQL
bundle exec rails new pg_sample -d postgresql
cd pg_sample
bundle install

# Node.js with nodebrew
curl https://raw.github.com/hokaccha/nodebrew/master/nodebrew | perl - setup
echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> .zshenv
# ln -s $HOME/.nodebrew/node/v0.8.12/bin/ $HOME/local/bin/node-bin
# echo 'export PATH=$HOME/local/bin/node-bin:$PATH' >> .zshenv
nodebrew ls-all
# nodebrew install v0.8.12

# dmd
cd ~/local/src
wget https://github.com/downloads/D-Programming-Language/dmd/dmd.2.059.zip
sudo aptitude install unzip
unzip dmd.2.059.zip
mv dmd2 ~/local/bin
echo "export PATH=$HOME/local/bin/dmd2/linux/bin64:$PATH" >> ~/.zshenv

# FFmpeg
# ref. install-ffmpeg-10.04.sh or
#      install-ffmpeg-12.04.sh

# Apache2
sudo aptitude install apache2
sudo a2enmod rewrite
sudo vim /etc/apache2/site-available/default
...
- 	DocumentRoot /var/www
+ 	DocumentRoot /home/ka/www
...
- 	<Directory /var/www/>
- 		Options Indexes FollowSymLinks MultiViews
- 		AllowOverride None
+ 	<Directory /home/ka/www/>
+ 		Options ExecCGI Indexes FollowSymLinks MultiViews
+ 		AllowOverride All
...

mkdir $HOME/www
sudo service apache2 restart

# gitosis
sudo aptitude install gitosis
sudo passwd gitosis # input password
ssh-keygen # input empty all (only press enter)
sudo -H -u gitosis gitosis-init < /home/ka/.ssh/id_rsa.pub
git clone gitosis@localhost:gitosis-admin.git
cd gitosis-admin
vim gitosis.conf
...
+ [group mygroup]
+ writable = myrepos
+ members = ka@myhost

cd keydir
echo "(public key content)" > ka@myhost
git add .
git commit -m "change configuration and add keys"
git push

# subversion
sudo aptitude install subversion libapache2-svn
sudo vim /etc/apache2/mods-enabled/dav_svn.conf
...
+ <Location /svn>
+         DAV svn
+         SVNParentPath /var/www/svn
+         AuthType Basic
+         AuthName "Subversion Repository"
+         AuthUserFile /var/www/svn/.htpasswd
+         AuthzSVNAccessFile /var/www/svn/.svnaccess
+         Require valid-user
+ </Location>

cd /var/www
sudo mkdir svn
sudo chown www-data:www-data svn
sudo vim .svnaccess
+ [myrepos:/]
+ ka = rw
+ someone = r
+ * =

sudo htpasswd -cm .htpasswd ka
sudo htpasswd -m .htpasswd someone
sudo svnadmin create myrepos
sudo svnadmin load myrepos < dumpfile # svnadmin dump myrepos > dumpfile # on somewhere
sudo chown -R www-data:www-data myrepos

# hg
sudo aptitude install mercurial

# HandBrakeCLI
# ref. https://launchpad.net/~stebbins/+archive/handbrake-releases
sudo aptitude install python-software-properties # for "add-apt-repository"
sudo add-apt-repository ppa:stebbins/handbrake-releases
sudo aptitude update
sudo aptitude install handbrake-cli

# Lua
cd $HOME/local/src
wget http://www.lua.org/ftp/lua-5.2.0.tar.gz
tar xzf lua-5.2.0.tar.gz
cd lua-5.2.0
vim Makefile
...
- PLAT= none
+ PLAT= linux
...
- INSTALL_TOP= /usr/local
+ INSTALL_TOP= /home/ka/local
...

make
make install

# Java6
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java6-installer

# to install nokogiri
sudo aptitude install libxslt-dev libxml2-dev
gem install nokogiri

# samba
sudo aptitude install smbfs
