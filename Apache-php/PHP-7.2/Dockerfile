FROM ubuntu:18.04
LABEL maintainer="Eduardo Fernandes"
LABEL description="This is a general-purpose docker image with Apache and PHP 7.2"
LABEL version="1.0.0"

##### Install Apache and PHP
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get --quiet=2 update  > /dev/null 2>&1 \
    && apt-get --quiet=2 --assume-yes install  \
    apache2\
    curl\
    libapache2-mod-php7.2\
    php7.2-bz2\
    php7.2-curl\
    php7.2-gd\
    php7.2-intl\
    php7.2-json\
    php7.2-mbstring\
    php7.2-mysql\
    php7.2-xml\
    php7.2-xsl\
    php7.2-zip\
    unzip\
    zip \
    > /dev/null 2>&1

##### Add the thanos user
COPY ./Scripts/addUser.sh /tmp/addUser.sh
RUN /tmp/addUser.sh \
    && chown -R thanos:thanos /var/www

##### Configure Apache
COPY ./Scripts/apache.sh /tmp/apache.sh
RUN sed -i "s/www-data/thanos/g" /etc/apache2/envvars \
    && sed -i "s/LogLevel warn/LogLevel error/g" /etc/apache2/apache2.conf \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && a2enmod rewrite \
    && a2enmod ssl

#### Configure PHP
RUN sed -i "s/expose_php = Off/expose_php = On/g" /etc/php/7.2/apache2/php.ini \
    && sed -i "s/max_execution_time = 30/max_execution_time = 60/g" /etc/php/7.2/apache2/php.ini \
    && sed -i "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php/7.2/apache2/php.ini \
    && sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT & ~E_NOTICE/g" /etc/php/7.2/apache2/php.ini \
    && sed -i "s/post_max_size = 36M/post_max_size = 36M/g" /etc/php/7.2/apache2/php.ini \
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 26M/g" /etc/php/7.2/apache2/php.ini \
    && sed -i "s/max_file_uploads = 20/max_file_uploads = 5/g" /etc/php/7.2/apache2/php.ini \
    && sed -i "s/;date.timezone =/date.timezone = \"Europe\/London\"/g" /etc/php/7.2/apache2/php.ini \
    && sed -i "s/expose_php = Off/expose_php = On/g" /etc/php/7.2/cli/php.ini \
    && sed -i "s/max_execution_time = 30/max_execution_time = 60/g" /etc/php/7.2/cli/php.ini \
    && sed -i "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php/7.2/cli/php.ini \
    && sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT & ~E_NOTICE/g" /etc/php/7.2/cli/php.ini \
    && sed -i "s/post_max_size = 36M/post_max_size = 36M/g" /etc/php/7.2/cli/php.ini \
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 26M/g" /etc/php/7.2/cli/php.ini \
    && sed -i "s/max_file_uploads = 20/max_file_uploads = 5/g" /etc/php/7.2/cli/php.ini \
    && sed -i "s/;date.timezone =/date.timezone = \"Europe\/London\"/g" /etc/php/7.2/cli/php.ini

USER thanos
EXPOSE 80
EXPOSE 443
STOPSIGNAL SIGTERM
WORKDIR /var/www
CMD ["/tmp/apache.sh"]
