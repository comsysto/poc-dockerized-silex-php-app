# poc-dockerized-silex-php-app

Praxisbeispiel: Universelles Docker-Image für PHP Silex Anwendung zum BlogPost

<img src="https://media.comsysto.com/images/2017-01-02-docker/opengraph.png" width="300" />


### Usage

Building the docker image `almightyphp`

```
git clone https://github.com/comsysto/poc-dockerized-silex-php-app.git ~/poc-dockerized-silex-php-app
cd ~/poc-dockerized-silex-php-app/
docker build -t almightyphp .
```

----

Install Application dependencies with composer


```
docker run \
    -i -t \
    -v $(pwd)/php-demo-app/:/phpapp/www \
    -v $(pwd)/php-composer-home/:/phpapp/.composer \
    -v $(pwd)/php-data-dir/:/phpapp/data \
    almightyphp composer update -vvv
```

----

Run Application with Apache 2 HTTP Server and PHP7 with Environment `local`

```
docker run \
    -i -t \
    -p 8899:9999 \
    -v $(pwd)/php-demo-app/:/phpapp/www \
    -v $(pwd)/php-composer-home/:/phpapp/.composer \
    -v $(pwd)/php-data-dir/:/phpapp/data \
    almightyphp
    
#
# OR RUN WITH STAGING ENVIRONMENT
#
docker run \
    -i -t \
    -E ENVIRONMENT=staging
    -p 8899:9999 \
    -v $(pwd)/php-demo-app/:/phpapp/www \
    -v $(pwd)/php-composer-home/:/phpapp/.composer \
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
