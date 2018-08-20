FROM ubuntu:16.04
LABEL maintainer="Eduardo Fernandes"
LABEL description="This is a general-purpose docker image with Apache and PHP 7.1"
LABEL version="1.0.0"
##

RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" > /etc/apt/sources.list.d/ondrej.list \
    && echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" >> /etc/apt/sources.list.d/ondrej.list \
    && cat /etc/apt/sources.list.d/ondrej.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C \
    && apt-get --quiet=2 update

##### Install Apache and PHP
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get --quiet=2 --assume-yes --no-install-recommends install  \
    apache2 \
    curl \
    libapache2-mod-php7.1 \
    php7.1-bz2 \
    php7.1-curl \
    php7.1-gd \
    php7.1-intl \
    php7.1-json \
    php7.1-mbstring \
    php7.1-mysql \
    php7.1-xml \
    php7.1-xsl \
    php7.1-zip \
    unzip\
    zip

##### Add the thanos user
COPY ./Scripts/addUser.sh /tmp/addUser.sh
RUN /tmp/addUser.sh \
    && chown -R thanos:thanos /var/www

##### Configure Apache
COPY ./Scripts/apache.sh /tmp/apache.sh
RUN sed -i "s/www-data/thanos/g" /etc/apache2/envvars \
    && sed -i "s/LogLevel warn/LogLevel error/g" /etc/apache2/apache2.conf \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/site.conf \
    && chown -R thanos:thanos /var/www \
    && a2ensite site \
    && a2enmod rewrite \
    && a2enmod ssl

#### Configure PHP
RUN sed -i "s/expose_php = Off/expose_php = On/g" /etc/php/7.1/apache2/php.ini \
    && sed -i "s/max_execution_time = 30/max_execution_time = 60/g" /etc/php/7.1/apache2/php.ini \
    && sed -i "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php/7.1/apache2/php.ini \
    && sed -i "s/post_max_size = 36M/post_max_size = 36M/g" /etc/php/7.1/apache2/php.ini \
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 26M/g" /etc/php/7.1/apache2/php.ini \
    && sed -i "s/max_file_uploads = 20/max_file_uploads = 5/g" /etc/php/7.1/apache2/php.ini \
    && sed -i "s/;date.timezone =/date.timezone = \"Europe\/London\"/g" /etc/php/7.1/apache2/php.ini \
    && sed -i "s/expose_php = Off/expose_php = On/g" /etc/php/7.1/cli/php.ini \
    && sed -i "s/max_execution_time = 30/max_execution_time = 60/g" /etc/php/7.1/cli/php.ini \
    && sed -i "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php/7.1/cli/php.ini \
    && sed -i "s/post_max_size = 36M/post_max_size = 36M/g" /etc/php/7.1/cli/php.ini \
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 26M/g" /etc/php/7.1/cli/php.ini \
    && sed -i "s/max_file_uploads = 20/max_file_uploads = 5/g" /etc/php/7.1/cli/php.ini \
    && sed -i "s/;date.timezone =/date.timezone = \"Europe\/London\"/g" /etc/php/7.1/cli/php.ini

EXPOSE 80
EXPOSE 443
STOPSIGNAL SIGTERM
WORKDIR /var/www
CMD ["/tmp/apache.sh"]
