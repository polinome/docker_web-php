FROM php:5.6

ENV COMPOSER_VERSION=1.5.2 COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_PATH=/usr/local/bin

RUN apt-get update -yqq
RUN apt-get install -yqq git wget openssh-client

RUN docker-php-ext-install bcmath

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=${COMPOSER_PATH} --filename=composer --version=${COMPOSER_VERSION}

# node, gulp, bower, sassx
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -yqq nodejs
RUN ln -s /usr/bin/nodejs /usr/local/bin/node
RUN npm install -g gulp
RUN npm install -g bower
RUN npm install -g node-sass

# create a user
RUN useradd --create-home --shell /bin/bash docker
WORKDIR /home/docker
USER docker
