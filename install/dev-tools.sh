#!/bin/bash

# installing dev tools <non debian packages>
echo "Installing dev tools"
sudo npm install -g bower gulp
sudo gem install sass
# composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
# configure apache
# mysql path ummappen

