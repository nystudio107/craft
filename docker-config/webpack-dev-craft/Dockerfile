FROM nystudio107/webpack-dev-base

WORKDIR /var/www/project/docker-config/webpack-dev-craft/

# We'd normally use `npm ci` here, but by using `install`:
# - If `package-lock.json` is present, it will install what is in the lock file
# - If `package-lock.json` is missing, it will update to the latest dependencies
#   and create the `package-lock-json` file
# Run our webpack build in debug mode
CMD if [ ! -f  "./package-lock.json" ]; then \
        npm install; \
    fi \
    && \
    if [ ! -d  "./node_modules" -o ! "$(ls -A ./node_modules)" ]; then \
        npm install; \
    fi \
    && \
    npm run debug
