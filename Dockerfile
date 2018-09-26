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
# Redis
    && echo "Installing redis ****************************************************" \ 
    && apt-get install -y  redis-server \
# Nginx    
    && apt-get install -y nginx 

# additional stuff
RUN apt-get install -y htop procps  iputils-ping 
# RUN pecl install memcache && docker-php-ext-enable memcache 


# forward request and error logs to docker log collector
#RUN ln -sf /dev/stdout /var/log/nginx/access.log \
#	&& ln -sf /dev/stderr /var/log/nginx/error.log


# forward error logs to docker log collector
RUN  ln -sf /dev/stderr /var/log/nginx/error.log

# Install memcache extension
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends unzip libssl-dev libpcre3 libpcre3-dev \
    && cd /tmp \
    && curl -sSL -o php7.zip https://github.com/websupport-sk/pecl-memcache/archive/php7.zip \
    && unzip php7 \
    && cd pecl-memcache-php7 \
    && /usr/local/bin/phpize \
    && ./configure --with-php-config=/usr/local/bin/php-config \
    && make \
    && make install \
    && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/ext-memcache.ini \
    && rm -rf /tmp/pecl-memcache-php7 php7.zip


# Install nodejs and npm for pravo.rg.ru
RUN apt-get install -y  gnupg \
    && curl -O https://deb.nodesource.com/setup_4.x \
    && bash setup_4.x \
    && apt-get install -y nodejs \
    && npm install -g npm@3.5.2 \
    && npm i gulp -g



# redis port
EXPOSE 6379

# Nginx port
EXPOSE 80

#STOPSIGNAL SIGTERM


# defaults for an executing container
CMD bash -c "service redis-server start && php-fpm & nginx -g 'daemon off;'"





