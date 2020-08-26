FROM php:7.4-apache
SHELL ["/bin/bash", "-c"]

ARG FLEXTYPE_SOURCE_URL=https://github.com/flextype/flextype/releases/download/v0.9.11/flextype-cms-0.9.11.zip

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
ADD $FLEXTYPE_SOURCE_URL /tmp/flextype.zip

RUN apt update -y && apt upgrade -y && apt install -y unzip && \
    chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd mbstring xdebug json fileinfo spl dom zip && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    a2enmod rewrite && service apache2 restart

RUN cd /tmp && mkdir flextype && unzip /tmp/flextype.zip -d flextype

RUN cd /tmp/flextype && cp -r . /var/www/html/ && \
    cd /var/www/html/ && composer install && \
    chown -R www-data:www-data . && \
    rm -rf /tmp/flextype.zip && rm -rf /tmp/flextype


