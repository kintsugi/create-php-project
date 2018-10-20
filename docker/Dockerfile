FROM php:7.1.16-apache

COPY docker/vhost.conf /etc/apache2/sites-available/000-default.conf

RUN mkdir /srv/app

RUN chown -R www-data:www-data /srv/app \
  && a2enmod rewrite