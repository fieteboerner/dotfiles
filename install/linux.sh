#!/bin/bash

echo "Adding repositories"
# virtualbox
if [ ! -f /etc/apt/sources.list.d/virtualbox.list ]; then
	sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" >> /etc/apt/sources.list.d/virtualbox.list'
	wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
fi

# chrome
if [ ! -f /etc/apt/sources.list.d/google-chrome.list ]; then
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
fi

# spotify
if [ ! -f /etc/apt/sources.list.d/spotify.list ]; then
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	sudo sh -c 'echo deb http://repository.spotify.com testing non-free | sudo tee /etc/apt/sources.list.d/spotify.list'
fi

# arc gnome theme
if [ ! -f /etc/apt/sources.list.d/arc-theme.list ]; then
    sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list"
    wget -q -O - http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_15.10/Release.key | sudo apt-key add -
fi

sudo apt-add-repository -y ppa:webupd8team/sublime-text-3
sudo apt-add-repository -y ppa:webupd8team/java

echo "Update apt-chache"
sudo apt-get update -y
echo "Update system packages"
sudo apt-get upgrade -y

echo "Installing system packages"
sudo apt-get install -y ffmpeg vlc apache2 php7.0 php7.0-sqlite mariadb-server php7.0-mysql openssh-server phpmyadmin sqlite3 npm nodejs dkms gimp git-core gpick gzip imagemagick keepassx
needrestart inkscape oracle-java8-installer scribus language-pack-de language-pack-gnome-de laptop-detect lm-sensors make meld google-chrome-stable gparted markdown mysql-workbench nmap vim zsh
screenruler steam thunderbird thunderbird-locale-de vagrant wireshark pavucontrol ubuntu-restricted-extras virtualbox-5.0 nautilus-dropbox clementine djmount libreoffice-l10n-de pidgin
pidgin-encryption htop php7.0-ldap nodejs-legacy spotify-client sqliteman sublime-text-installer subversion sshfs tmux cmake python-dev exuberant-ctags silversearcher-ag vim-gnome gnupg2 httpie
xsel arc-theme-solid libapache2-mod-php libapache2-mod-php-7.0

# apache2
echo "Setting up Apache configuration"
sudo a2enmod rewrite
if [ -f ~/etc/apache2/sites-available/lin.conf ]; then # if old directory exsists with lin configuration
    sudo cp ~/etc/apache2/sites-available/lin.conf /etc/apache2/sites-available/
    a2dissite 000-default.conf # disable default
    sudo a2ensite lin
fi
sudo service apache2 restart

# virtualbox
echo "Adding user to vboxusers group"
sudo usermod -a -G vboxusers $USER

# wireshark
echo "Adding user to wireshark group"
sudo usermod -a -G wireshark $USER

# zsh
echo "Configuring zsh as default shell"
sudo chsh -s $(which zsh) $USER
sudo chmod -R 755 /usr/local/share/zsh/site-functions/

# hosts
echo "Adding 'lin' as alias for localhost in hosts file"
sudo sh -c "echo 127.0.0.1 lin >> /etc/hosts"

# theme
echo "Setting up shell theme"
gsettings set org.gnome.desktop.interface gtk-theme "Arc"
gsettings set org.gnome.desktop.wm.preferences theme "Arc"
