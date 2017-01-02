FROM alpine:3.5

#
# BASE PACKAGES
#
RUN apk add --no-cache \
            curl \
            php7 \
            php7-mysqli \
            php7-pdo_mysql \
            php7-ctype \
            php7-json \
            php7-gd \
            php7-curl \
            php7-pgsql \
            php7-sqlite3 \
            php7-bcmath \
            php7-mbstring \
            php7-mcrypt \
            php7-zip \
            php7-dba \
            php7-session \
            php7-phar \
            php7-zlib \
            php7-xml \
            php7-xmlreader \
            php7-openssl \
            php7-dom \
            apache2 \
            apache2-utils \
            php7-apache2

#
# ERROR LOG, USER, PHP CONF, APACHE2 CONF
#
RUN ln -sf /dev/stderr /var/log/apache2/error.log && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    curl -o /usr/bin/composer -J -L https://getcomposer.org/download/1.3.0/composer.phar && \
    chmod +x /usr/bin/composer && \
    addgroup -g 10777 phpworker && \
    adduser -h /phpapp/ -H -D -G phpworker -u 10777 phpworker && \
    mkdir -p /phpapp/www && \
    mkdir -p /phpapp/data && \
    mkdir -p /phpapp/.composer && \
    chown -R phpworker:phpworker /phpapp/ && \
    chown -R phpworker:phpworker /var/www/logs && \
    touch /var/www/logs/error.log && chown -R phpworker:phpworker /var/www/logs/error.log && \
    touch /var/www/logs/access.log && chown -R phpworker:phpworker /var/www/logs/access.log && \
    chown -R phpworker:phpworker /var/log/apache2 && \
    mkdir /run/apache2 && chown -R phpworker:phpworker /run/apache2 && \
    sed -i -e 's/upload_max_filesize.*/upload_max_filesize = 32M/g' /etc/php7/php.ini && \
    sed -i -e 's/post_max_size.*/post_max_size = 32M/g' /etc/php7/php.ini && \
    sed -i -e 's/\/var\/www\/localhost\/htdocs/\/phpapp\/www/g' /etc/apache2/httpd.conf && \
    sed -i -e 's/Listen 80/Listen 9999\nServerName localhost/g' /etc/apache2/httpd.conf && \
    sed -i -e 's/AllowOverride\s*None/AllowOverride All/ig' /etc/apache2/httpd.conf && \
    sed -i -e 's/#LoadModule\s*rewrite_module/LoadModule rewrite_module/gi' /etc/apache2/httpd.conf

#
# WORKDIR
#
WORKDIR /phpapp/www
EXPOSE 9999

#
# USER AND VOLUME
#
USER phpworker
ENV ENVIRONMENT local
VOLUME ["/phpapp/www"]
VOLUME ["/phpapp/data"]
VOLUME ["/phpapp/.composer"]

#
# DEFAULT CMD START APACHE
#
CMD ["httpd", "-DFOREGROUND"]