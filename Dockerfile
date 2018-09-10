FROM php:7.0.31-fpm

LABEL maintainer="RGRU <ivlev@rg.ru>"

# copy home stuff
COPY home-files/.vimrc  /root/
COPY home-files/.tmux.conf  /root/
COPY home-files/.vim  /root/.vim
COPY home-files/.tmux  /root/.tmux

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get install -y build-essential checkinstall \
    && apt-get install -y wget \
#RUN apt-get -q update \
    && apt-get upgrade -y \
    g++ \
    libc-client-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libkrb5-dev \
    libpq-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libpng-dev \
    libmemcached-dev \
    libssl-dev \
    libssl-doc \
    libsasl2-dev \
    zlib1g-dev \
    libxslt-dev \
    && docker-php-ext-install 'bcmath' 'calendar' 'exif' 'gd' 'gettext' 'mcrypt' \
    # && docker-php-ext-install 'memcache' \
    && docker-php-ext-install 'mysqli' 'pcntl' 'pdo_mysql' 'shmop' \
    && docker-php-ext-install 'sockets' \
    # 'ssh2' # ssh2 requires PHP (version >= 4.0.0, version <= 6.0.0), installed version is 7.0.31
    && docker-php-ext-install 'sysvmsg' 'sysvsem' \
    && docker-php-ext-install 'sysvshm' 'wddx' \
    && docker-php-ext-install 'xsl' \
    && docker-php-ext-install 'zip' \
    && pecl install memcached && docker-php-ext-enable memcached \
    && pecl install redis && docker-php-ext-enable redis \
    && pecl install xdebug && docker-php-ext-enable xdebug \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -Rf /tmp/* \
# tools
    && echo "Installing tools ****************************************************" \ 
    && apt-get install -y mc vim fish tmux git redis-tools mysql-client \
# composer
    && echo "Installing composer ****************************************************" \ 
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php  \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer \
# Nginx    
    && apt-get install -y nginx && service nginx start




# RUN /files/functions.sh
    # && docker-php-ext-install \
    # bz2 \
    # iconv \
    # mbstring \
    # mysqli \
    # pgsql \
    # pdo_mysql \
    # pdo_pgsql \
    # soap \
    # zip \
    # && docker-php-ext-configure gd \
    # --with-freetype-dir=/usr/include/ \
    # --with-jpeg-dir=/usr/include/ \
    # --with-png-dir=/usr/include/ \
    # && docker-php-ext-install gd \
    # && docker-php-ext-configure intl \
    # && docker-php-ext-install intl \
    # && yes '' | pecl install imagick && docker-php-ext-enable imagick \
    # && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    # && docker-php-ext-install imap \
    # && pecl install memcached && docker-php-ext-enable memcached \
    # && pecl install mongodb && docker-php-ext-enable mongodb \
    # && pecl install redis && docker-php-ext-enable redis \
    # && pecl install xdebug && docker-php-ext-enable xdebug \
    # && apt-get autoremove -y --purge \
    # && apt-get clean \
    # && rm -Rf /tmp/*
