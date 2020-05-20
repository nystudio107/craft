FROM nystudio107/php-dev-base

# Install packages
RUN apt-get update \
    && \
    # apt Debian packages
    apt-get install -y \
        nano \
    && \
    # Install PHP extensions
    docker-php-ext-install \
        pdo_mysql \
    && \
    # Install Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

WORKDIR /var/www/project

# Copy over the directories/files php needs access to
COPY --chown=www-data:www-data ./cms/composer.* /var/www/project/cms/

# Create the storage directory and make it writeable by PHP
RUN mkdir -p /var/www/project/cms/storage && \
    mkdir -p /var/www/project/cms/storage/runtime && \
    chown -R www-data:www-data /var/www/project/cms/storage

# Create the cpresources directory and make it writeable by PHP
RUN mkdir -p /var/www/project/cms/web/cpresources && \
    chown -R www-data:www-data /var/www/project/cms/web/cpresources

WORKDIR /var/www/project/cms

# Force permissions, update Craft, and start php-fpm

# Do a `composer install` without running any Composer scripts
# - If `composer.lock` is present, it will install what is in the lock file
# - If `composer.lock` is missing, it will update to the latest dependencies
#   and create the `composer.lock` file
# This automatic running adds to the startup overhead of `docker-compose up`
# but saves far more time in not having to deal with out of sync versions
# when working with teams or multiple environments
CMD composer install --no-scripts --optimize-autoloader --no-interaction \
    && \
    chown -R www-data:www-data /var/www/project/cms/vendor \
    && \
    chown -R www-data:www-data /var/www/project/cms/storage \
    && \
    composer craft-update \
    && \
    php-fpm
