# Prerequesite
# Install OpenJDK 7
# ref. java-setup.sh

# Download android-sdk
if [ ! -d $HOME/local ]
then
  mkdir $HOME/local
fi
cd $HOME/local
wget http://dl.google.com/android/android-sdk_r22.6.2-linux.tgz
tar xf android-sdk_r22.6.2-linux.tgz

echo 'export PATH=$HOME/local/android-sdk-linux/tools:$PATH' >> $HOME/.zshenv
echo 'export PATH=$HOME/local/android-sdk-linux/build-tools/19.0.3:$PATH' >> $HOME/.zshenv
export PATH=$HOME/local/android-sdk-linux/tools:$PATH
export PATH=$HOME/local/android-sdk-linux/build-tools/19.0.3:$PATH

# Install all Android SDKs
android update sdk --no-ui

# Install dependent packages for 64bit
# ref. http://qiita.com/nichijo/items/773403a4bac7180a26ab
sudo apt-get install lib32stdc++6 lib32z1
