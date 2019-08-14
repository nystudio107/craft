fastcgi_cache_path /var/run/nginx-cache/SITENAME levels=1:2 keys_zone=SITENAME:100m inactive=1d  use_temp_path=off max_size=100m;

# FORGE CONFIG (DOT NOT REMOVE!)
include forge-conf/SITENAME.fm/before/*;

# Bots to ban via user agent
map $http_user_agent $limit_bots {
     default 0;
     ~*(AhrefsBot|Baiduspider|PaperLiBot) 1;
 }

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    # General virtual host settings
    server_name SITENAME.fm;
    root /home/forge/SITENAME.fm/web;
    index index.html index.htm index.php;
    charset utf-8;
    ssi on;

    gzip_static on;

    client_max_body_size 100M;

        # Ban certain bots from crawling the site
    if ($limit_bots = 1) {
        return 403;
    }

    # 404 error handler
    error_page 404 /index.php?$query_string;

    # 301 Redirect URLs with trailing /'s as per https://webmasters.googleblog.com/2010/04/to-slash-or-not-to-slash.html
    rewrite ^/(.*)/$ /$1 permanent;

    # Change // -> / for all URLs, so it works for our php location block, too
    merge_slashes off;
    rewrite (.*)//+(.*) $1/$2 permanent;

    # Handle Do Not Track as per https://www.eff.org/dnt-policy
    location /.well-known/dnt-policy.txt {
        try_files /dnt-policy.txt /index.php?p=/dnt-policy.txt;
    }

    # For WordPress bots/users
    location ~ ^/(wp-login|wp-admin|wp-config|wp-content|wp-includes|xmlrpc|(.*)\.exe) {
        return 301 https://wordpress.com/wp-login.php;
    }

    #Cache everything by default
    fastcgi_cache_key "$scheme$request_method$host$request_uri";
    add_header X-Cache-Status $upstream_cache_status;
    set $no_cache 0;
    if ($request_method = POST)
    {
        set $no_cache 1;
    }
    if ($request_uri ~* "/(admin/|cpresources/)")
    {
        set $no_cache 1;
    }

    # Access and error logging
    access_log off;
    error_log  /var/log/nginx/SITENAME.fm-error.log error;
    # If you want error logging to go to SYSLOG (for services like Papertrailapp.com), uncomment the following:
    #error_log syslog:server=unix:/dev/log,facility=local7,tag=nginx,severity=error;

    # FORGE SSL (DO NOT REMOVE!)
    ssl_certificate /etc/nginx/ssl/SITENAME.fm/224401/server.crt;
    ssl_certificate_key /etc/nginx/ssl/SITENAME.fm/224401/server.key;

    # SSL/TLS configuration, with TLSv1.0 disabled because it is insecure; note that IE 8, 9 & 10 support
    # TLSv1.1, but it's not enabled by default clients using those browsers will not be able to connect
    ssl_protocols TLSv1.1 TLSv1.2;
    #ssl_ciphers 'ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:AES:CAMELLIA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!aECDH:!EDH-DSS-DES-CBC3-SHA:!EDH-RSA-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA';
    ssl_prefer_server_ciphers on;
    ssl_dhparam /etc/nginx/dhparams.pem;
    ssl_ciphers 'ECDH+AESGCM:ECDH+AES256:ECDH+AES128:DH+3DES:!ADH:!AECDH:!MD5';
    ssl_buffer_size 4k;
    ssl_session_timeout 4h;
    ssl_session_cache shared:SSL:20m;
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_trusted_certificate /etc/nginx/ssl/lets-encrypt-x3-cross-signed.pem;

    # FORGE CONFIG (DOT NOT REMOVE!)
    include forge-conf/SITENAME.fm/server/*;

    # Load configuration files from nginx-partials
    include /home/forge/nginx-craft/nginx-partials/*.conf;

    # Root directory location handler
    location / {
        try_files $uri/index.html $uri $uri/ /index.php?$query_string;
    }

    # Localized sites, hat tip to Johannes -- https://gist.github.com/johanneslamers/f6d2bc0d7435dca130fc

    # If you are creating a localized site as per: https://craftcms.com/docs/localization-guide
    # the directives here will help you handle the locale redirection so that requests will
    # be routed through the appropriate index.php wherein you set the `CRAFT_LOCALE`

    # Enable this by un-commenting it, and changing the language codes as appropriate
    # Add a new location @XXrewrites and location /XX/ block for each language that
    # you need to support

    #location @enrewrites {
    #    rewrite ^/en/(.*)$ /en/index.php?p=$1? last;
    #}
    #
    #location /en/ {
    #    try_files $uri $uri/ @enrewrites;
    #}

    # Craft-specific location handlers to ensure AdminCP requests route through index.php
    # If you change your `cpTrigger`, change it here as well
    location ^~ /admin {
        try_files $uri $uri/ @phpfpm_nocache;
    }
    location ^~ /index.php/admin {
        try_files $uri $uri/ @phpfpm_nocache;
    }
    location ^~ /cpresources {
        try_files $uri $uri/ /index.php?$query_string;
    }
    location ^~ /actions {
        try_files $uri $uri/ /index.php?$query_string;
    }
    # Pass our ElementAPI requests through
    location ^~ /api {
        try_files $uri $uri/ /index.php?$query_string;
    }
    # Pass our ServiceWorker through Craft so it can work as a template
    location ^~ /sw.js {
        try_files $uri $uri/ /index.php?$query_string;
    }
    # Pass our ElementAPI requests through
    location ^~ /rss {
        try_files $uri $uri/ /index.php?$query_string;
    }
    # Pass instantanalytics through
    location ^~ /instantanalytics {
        try_files $uri $uri/ @phpfpm_nocache;
    }
    # Pass Retour through
    location ^~ /retour {
        try_files $uri $uri/ @phpfpm_nocache;
    }

    # Pass Webperf through
    location ^~ /webperf {
        try_files $uri $uri/ @phpfpm_nocache;
    }

    # php-fpm configuration
    location ~ [^/]\.php(/|$) {
        try_files $uri $uri/ /index.php?$query_string;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        # Change this to whatever version of php you are using
        fastcgi_pass unix:/var/run/php/php7.1-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        fastcgi_param HTTP_PROXY "";

        # Use Dotenvy to generate the .env variables as per: https://github.com/nystudio107/dotenvy
        # and then uncomment this line to include them:
        include /home/forge/SITENAME.fm/.env_nginx.txt;

        # Don't allow browser caching of dynamically generated content
        add_header X-Cache-Status $upstream_cache_status;
        add_header Last-Modified $date_gmt;
        add_header Cache-Control 'no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0';
        if_modified_since off;
        expires off;
        etag off;

        # shared php-fpm configuration
        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;

        # FastCGI Cache settings
        fastcgi_ignore_headers Cache-Control Expires Set-Cookie;
        fastcgi_cache SITENAME;
        fastcgi_hide_header Set-Cookie;
        fastcgi_cache_valid 200 1d;
        fastcgi_cache_use_stale updating error timeout invalid_header http_500;
        fastcgi_cache_bypass $no_cache;
        fastcgi_no_cache $no_cache;
    }

    # php-fpm configuration for non-cached content
    location @phpfpm_nocache {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php7.1-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root/index.php;
        fastcgi_param PATH_INFO $query_string;
        fastcgi_param HTTP_PROXY "";

        # Use Dotenvy to generate the .env variables as per: https://github.com/nystudio107/dotenvy
        # and then uncomment this line to include them:
        include /home/forge/SITENAME.fm/.env_nginx.txt;

        # Don't allow browser caching of dynamically generated content
        add_header X-Cache-Status $upstream_cache_status;
        add_header Last-Modified $date_gmt;
        add_header Cache-Control 'no-store, no-cache, must-revalidate, proxy-revalidate, max-age=0';
        if_modified_since off;
        expires off;
        etag off;

        # shared php-fpm configuration
        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;

        # No FastCGI Cache
        fastcgi_cache_bypass 1;
        fastcgi_no_cache 1;
        }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}

# FORGE CONFIG (DOT NOT REMOVE!)
include forge-conf/SITENAME.fm/after/*;
