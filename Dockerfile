FROM php:7.2

# config installation de composer
ENV COMPOSER_VERSION=2.1.3 COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_PATH=/usr/local/bin

RUN apt-get update -yqq
RUN apt-get install -yqq git openssh-client wget gnupg2 libxml2-dev libzip-dev zip unzip zlib1g-dev

RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install bcmath soap zip

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=${COMPOSER_PATH} --filename=composer --version=${COMPOSER_VERSION}

# node, gulp, sass
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN apt-get install -yqq nodejs
RUN node -v
RUN npm -v
RUN ln -s /usr/bin/nodejs /usr/local/bin/node
RUN npm install -g gulp
RUN npm install -g node-sass

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -yqq
RUN apt-get install -yqq yarn

# create a user
RUN useradd --create-home --shell /bin/bash docker
WORKDIR /home/docker
USER docker
