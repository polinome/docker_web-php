FROM php:5.6

ENV COMPOSER_VERSION=1.5.2 COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_PATH=/usr/local/bin

RUN apt-get update -yqq
RUN apt-get install -yqq git wget

RUN docker-php-ext-install bcmath

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=${COMPOSER_PATH} --filename=composer --version=${COMPOSER_VERSION}

# gulp
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -
RUN apt-get install -yqq nodejs
RUN ln -s /usr/bin/nodejs /usr/local/bin/node
RUN npm install -g gulp
RUN npm install -g bower

# compass
RUN apt-get install -yqq ruby ruby-dev
RUN gem install --no-rdoc --no-ri sass -v 3.4.22
RUN gem install --no-rdoc --no-ri compass
RUN gem install susy

RUN useradd --create-home --shell /bin/bash docker
WORKDIR /home/docker

USER root
