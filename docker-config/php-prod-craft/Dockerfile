FROM nystudio107/php-prod-base:8.0-alpine

# dependencies required for running "phpize"
# these get automatically installed and removed by "docker-php-ext-*" (unless they're already installed)
ENV PHPIZE_DEPS \
        autoconf \
        dpkg-dev \
        dpkg \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkgconf \
        re2c \
        wget

# Install packages
RUN set -eux; \
    # Packages needed only for build
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
    && \
    # Packages to install
    apk add --no-cache \
        gifsicle \
        jpegoptim \
        libwebp-tools \
        nano \
        optipng \
        mysql-client \
    && \
    # Install PHP extensions
    docker-php-ext-install \
        pdo_mysql \
    && \
    # Install Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer \
    && \
    # Remove the build deps
    apk del .build-deps \
    && \
    # Clean out directories that don't need to be part of the image
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/project

COPY ./run_queue.sh .
RUN chmod a+x run_queue.sh

# Create the storage directory and make it writeable by PHP
RUN mkdir -p /var/www/project/cms/storage && \
    mkdir -p /var/www/project/cms/storage/runtime && \
    chown -R www-data:www-data /var/www/project/cms/storage

# Create the cpresources directory and make it writeable by PHP
RUN mkdir -p /var/www/project/cms/web/cpresources && \
    chown -R www-data:www-data /var/www/project/cms/web/cpresources

# Permissions
RUN chown -R www-data:www-data /var/www/project/cms/web

WORKDIR /var/www/project/cms

# Force permissions, update Craft, and start php-fpm

# Do a `composer install` without running any Composer scripts
# - If `composer.lock` is present, it will install what is in the lock file
# - If `composer.lock` is missing, it will update to the latest dependencies
#   and create the `composer.lock` file
# This automatic running adds to the startup overhead of `docker-compose up`
# but saves far more time in not having to deal with out of sync versions
# when working with teams or multiple environments
CMD composer install --verbose --no-progress --no-scripts --optimize-autoloader --no-interaction \
    && \
    chown -R www-data:www-data /var/www/project/cms/config \
    && \
    chown -R www-data:www-data /var/www/project/cms/storage \
    && \
    chown -R www-data:www-data /var/www/project/cms/vendor \
    && \
    chown -R www-data:www-data /var/www/project/cms/web \
    && \
    composer craft-update \
    && \
    php-fpm
