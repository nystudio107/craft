FROM nystudio107/php-dev-base

# Install packages
RUN apt-get update \
    && \
    # apt Debian packages
    apt-get install -y \
        mariadb-client \
        nano \
        jpegoptim \
        optipng \
        gifsicle \
        webp \
    && \
    # Install PHP extensions
    docker-php-ext-install \
        pdo_mysql \
    && \
    # Install Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer \
    # Clean apt repo caches that don't need to be part of the image
    && \
    apt-get clean \
    && \
    # Clean out directories that don't need to be part of the image
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/project

# Create the storage directory and make it writeable by PHP
RUN mkdir -p /var/www/project/cms/storage && \
    mkdir -p /var/www/project/cms/storage/runtime && \
    chown -R www-data:www-data /var/www/project/cms/storage

# Create the cpresources directory and make it writeable by PHP
RUN mkdir -p /var/www/project/cms/web/cpresources && \
    chown -R www-data:www-data /var/www/project/cms/web/cpresources

WORKDIR /var/www/project/cms
