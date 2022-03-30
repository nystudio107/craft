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
        su-exec \
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
RUN chmod a+x run_queue.sh \
    && \
    mkdir -p /var/www/project/cms/storage \
    && \
    mkdir -p /var/www/project/cms/web/cpresources \
    && \
    chown -R www-data:www-data /var/www/project
COPY ./composer_install.sh .
RUN chmod a+x composer_install.sh

WORKDIR /var/www/project/cms

# Run the composer_install.sh script that will do a `composer install`:
# - If `composer.lock` is missing
# - If `vendor/` is missing
# ...then start up php-fpm. The `run_queue.sh` script in the queue container
# will take care of running any pending migrations and apply any Project Config changes,
# as well as set permissions via an async CLI process
CMD /var/www/project/composer_install.sh \
    && \
    php-fpm
