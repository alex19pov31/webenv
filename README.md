# webenv

Web окружение - build файл для docker

Образ собран на основе CentOS 6.6 и включает в себя:

* nginx
* mysql
* varnish
* php-fpm
* php 5.6
* phalcon + phalcon-dev-tools
* composer
* php-opcahe + php-apcu

Для сборки образа в корне запускаем:
```bash
docker build -t [имя_образа] .
```

Для запуска контейнера необходимо выполнить команду:
```bash
docker run -p 8080:80 --name="webenv" -e "type=simple" -tid [имя_собранного_образа]
```

Переменная окружения type может принимать следующие занчения:

* simple - обычный конфиг адаптирован под phalcon nginx + php-fpm
* simple_varnish - конфиг под phalcon nginx + php-fpm + varnish
* bitrix - конфиг под bitrix nginx + php-fpm
* bitrix_varnish - конфиг под bitrix nginx + php-fpm + varnish

Nginx будет подключать сайты из директорий /var/www/[имя_хоста]
