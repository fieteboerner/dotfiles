#!/bin/bash

# installing dev tools <non debian packages>
echo "Installing dev tools"
sudo mkdir $(npm config get prefix)/lib/node_modules
# fix permission
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
npm install -g bower gulp jslint jshint
sudo gem install sass
# composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
# php-cs-fixer
sudo wget http://get.sensiolabs.org/php-cs-fixer.phar -O /usr/local/bin/php-cs-fixer
sudo chmod a+x /usr/local/bin/php-cs-fixer
# configure apache
# mysql path ummappen

