FROM php:7.3.33-cli-buster

RUN apt update && apt upgrade -y


RUN apt install bash nano git curl -y

RUN curl -sL https://deb.nodesource.com/setup_11.x -o /tmp/nodesource_setup.sh

RUN bash /tmp/nodesource_setup.sh

RUN apt install nodejs zlib1g-dev \
    libzip-dev \
    unzip -y

RUN docker-php-ext-install zip

RUN npm install -g yarn typescript

WORKDIR /var/www/webmotors_clone

COPY . .

RUN docker-php-ext-install pdo_mysql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer config --no-plugins allow-plugins.kylekatarnls/update false

RUN composer install

RUN composer dump-autoload

EXPOSE 8000

EXPOSE 8181

EXPOSE 80
