FROM ubuntu:14.04
LABEL maintainer="Eduardo Fernandes"
LABEL description="This is a general-purpose docker image with Apache and PHP 5"
LABEL version="1.0.0"

##### Install Apache and PHP
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get --quiet=2 update  > /dev/null 2>&1 \
    && apt-get --quiet=2 --assume-yes --no-install-recommends install  \
    apache2 \
    apt-transport-https \
    curl \
    libapache2-mod-php5 \
    openssl \
    php5-cli \
    php5-common \
    php5-curl \
    php5-gd \
    php5-gmp \
    php5-intl \
    php5-json \
    php5-ldap \
    php5-mysql \
    php5-readline \
    php5-xsl \
    unzip \
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
    && rm -Rf /etc/apache2/sites-enabled/* \
    && mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/site.conf \
    && chown -R thanos:thanos /var/www \
    && a2ensite site \
    && a2enmod rewrite \
    && a2enmod ssl

#### Configure PHP
RUN sed -i "s/expose_php = Off/expose_php = On/g" /etc/php5/apache2/php.ini \
    && sed -i "s/max_execution_time = 30/max_execution_time = 60/g" /etc/php5/apache2/php.ini \
    && sed -i "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php5/apache2/php.ini \
    && sed -i "s/post_max_size = 36M/post_max_size = 36M/g" /etc/php5/apache2/php.ini \
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 26M/g" /etc/php5/apache2/php.ini \
    && sed -i "s/max_file_uploads = 20/max_file_uploads = 5/g" /etc/php5/apache2/php.ini \
    && sed -i "s/;date.timezone =/date.timezone = \"Europe\/London\"/g" /etc/php5/apache2/php.ini \
    && sed -i "s/expose_php = Off/expose_php = On/g" /etc/php5/cli//php.ini \
    && sed -i "s/max_execution_time = 30/max_execution_time = 60/g" /etc/php5/cli//php.ini \
    && sed -i "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php5/cli//php.ini \
    && sed -i "s/post_max_size = 36M/post_max_size = 36M/g" /etc/php5/cli//php.ini \
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 26M/g" /etc/php5/cli//php.ini \
    && sed -i "s/max_file_uploads = 20/max_file_uploads = 5/g" /etc/php5/cli//php.ini \
    && sed -i "s/;date.timezone =/date.timezone = \"Europe\/London\"/g" /etc/php5/cli//php.ini

EXPOSE 80
EXPOSE 443
STOPSIGNAL SIGTERM
WORKDIR /var/www
CMD ["/tmp/apache.sh"]
