create-works-docker-image
-----------------------

Цель проекта - построение докер-имиджа близкого к серверу works.rg.ru по версии PHP и составу установленных расширений.


Используется для локальной разработки и тестирования приложений.



#### Изготовление имиджа
Таг:7.0.31 - версия PHP.

```sh
docker build -t rgru/works:7.0.31 .
```

#### Выгрузка изготовленного имиджа в hub.docker.com
```sh
docker login

docker push rgru/works:7.0.31
```
-----------------------
#### Изготовление имиджа из готового контейнера

Альтернативный способ изготовить образ без Dockerfile.
Стартовать какой нибудь стандартный контейнер. Залогиниться в него и установить все необходимое.
После этого изготовить образ из измененного контейнера. 

```sh
docker commit c16378f943fe local-image-name
docker tag local-image-name rgru/works:7.0.31
docker push rgru/works:7.0.31

```
c16378f943fe - идентификатор контейнера.
local-image-name - локальное имя нового контейнера



----------------------


#### Загрузка имиджа на компьютер разработчика
```sh
sudo docker pull rgru/works:7.0.31
```

Показать перечень установленных PHP расширений

```sh
sudo docker run --rm -it rgru/works:7.0.31 php -m
```

Installed extensions
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

--------------------
#### Определение перечня необходимых для установки PHP расширений.

Скрипт `missing-php-extensions.py` в папке `scripts/` служит для показа разницы в PHP расширениях между сервером и контейнером.
Используется при подготовке Dockerfile.