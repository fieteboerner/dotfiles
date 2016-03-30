#!/bin/bash

# installing dev tools <non debian packages>
echo "Installing dev tools"
sudo npm install -g bower gulp
sudo gem install sass
# composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
# php-cs-fixer
sudo wget http://get.sensiolabs.org/php-cs-fixer.phar -O /usr/local/bin/php-cs-fixer
sudo chmod a+x /usr/local/bin/php-cs-fixer
# configure apache
# mysql path ummappen

