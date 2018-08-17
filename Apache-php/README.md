# Apache-php

This is an Apache 2.4 image with PHP, through `lib-mod-php`.

The `thanos` user is create with the id 1000 and configured to be the apache user, to make it easier development through volume binds.

The ports 80 and 443 are exposed.

You can set your code into the `/var/www/html/ folder.

The logs are `/var/log/apache2/error.log` and `/var/log/apache2/access.log`.
