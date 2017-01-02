# poc-dockerized-silex-php-app
poc-dockerized-silex-php-app



### Usage

```
#
# BUILD DOCKER IMAGE
#
cd php-docker-image
docker build -t almightyphp .


#
# INSTALL DEPENENCIED WITH COMPOSER (this might take some time)
#
cd ..
docker run \
    -i -t \
    -v $(pwd)/php-demo-app/:/phpapp/www \
    -v $(pwd)/php-data-dir/:/phpapp/data \
    almightyphp composer update -vvv

#
# RUN APACHE2 HTTPD SERVER
#
docker run \
    -i -t \
    -p 8899:9999 \
    -v $(pwd)/php-demo-app/:/phpapp/www \
    -v $(pwd)/php-data-dir/:/phpapp/data \
    almightyphp
```

Now open Browser and goto http://localhost:8899/

-----

The Image size is around 50MB with Apache2 HTTP-Server, PHP7 and Composer pre-installed:

```
docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
almightyphp         latest              d1f73902aa78        27 minutes ago      50.95 MB
```


### License

  * Licensed under [MIT License](./LICENSE.md)
