#  Docker Image of works server

Цель проекта - построение докер-имиджа сервера works.rg.ru максимально близкого

## Загрузка имиджа
```sh
sudo docker pull nanoninja/php-fpm
```

## Запуск PHP скрипта

### Running image
Run the PHP-FPM image, mounting a directory from your host.

```sh
sudo docker run -it --name phpfpm -v /path/to/your/app:/var/www/html nanoninja/php-fpm php index.php
```

or using [Docker Compose](https://docs.docker.com/compose/):

```sh
version: '3'
services:
  phpfpm:
    container_name: phpfpm
    image: nanoninja/php-fpm
    entrypoint: php index.php
    volumes:
      - /path/to/your/app:/var/www/html
```

### Running as server

```sh
sudo docker run --rm --name phpfpm -v /path/to/your/app:/var/www/html -p 3000:3000 nanoninja/php-fpm php-fpm -S="0.0.0.0:3000" -t="/var/www/html"
```

### Logging
```sh
sudo docker logs phpfpm
```

# Installed extensions

```sh
sudo docker run --rm -it nanoninja/php-fpm php -m
```

## Installed extensions
 - bz2
 - Core
 - ctype
 - curl
 - date
 - dom
 - fileinfo
 - filter
 - ftp
 - gd
 - hash
 - iconv
 - imagick
 - imap
 - intl
 - json
 - libxml
 - mbstring
 - memcached
 - mongodb
 - mysqli
 - mysqlnd
 - openssl
 - pcre
 - PDO
 - pdo_mysql
 - pdo_pgsql
 - pdo_sqlite
 - pgsql
 - Phar
 - posix
 - readline
 - redis
 - Reflection
 - session
 - SimpleXML
 - soap
 - sodium
 - SPL
 - sqlite3
 - standard
 - tokenizer
 - xdebug
 - xml
 - xmlreader
 - xmlwriter
 - zip
 - zlib