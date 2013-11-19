sudo aptitude install libevent-dev libncurses-dev
#sudo aptitude install libevent-dev libncurses5-dev

cd $HOME/local/src
wget http://optimate.dl.sourceforge.net/project/tmux/tmux/tmux-1.8/
tar xzf tmux-1.8.tar.gz
cd tmux-1.8
./configure --prefix=$HOME/local
make
make install

# for a combination with clipboard
# ref.
#   http://www.mk-mode.com/octopress/2013/06/22/linux-mint-tmux-clipboard-share/
#   http://www.mk-mode.com/octopress/2013/06/21/linux-mint-install-xsel/
sudo aptitude install xsel