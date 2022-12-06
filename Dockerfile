FROM php:8.0-apache

ENV URL https://gestsup.fr/downloads/versions/current/version/gestsup_3.2.25.zip

COPY custom-php.ini /etc/php/8.1/apache2/conf.d



RUN set -ex; \
    apt-get update; \
    apt-get install -y unzip nano libzip-dev libpng-dev libc-client-dev libkrb5-dev libldb-dev libldap2-dev; \
    docker-php-ext-install pdo_mysql; \
    docker-php-ext-install mysqli; \
    docker-php-ext-install zip; \
    docker-php-ext-install gd; \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl; \
    docker-php-ext-install imap; \
    docker-php-ext-install ldap; \
    curl -fsSL -o gestsup.zip $URL; \
    unzip gestsup.zip -d /var/www/html; \
    rm -r gestsup.zip; \
    adduser gestsup --ingroup www-data; \
    chown -R gestsup:www-data /var/www/html/; \
    find /var/www/html/ -type d -exec chmod 750 {} \;; \
    find /var/www/html/ -type f -exec chmod 640 {} \;; \
    chmod 770 -R /var/www/html/upload; \
    chmod 770 -R /var/www/html/images/model; \
    chmod 770 -R /var/www/html/backup; \
    chmod 770 -R /var/www/html/_SQL; \
    chmod 660 /var/www/html/connect.php;