[<img align="right" src="https://media.comsysto.com/images/2017-01-02-docker/opengraph.png" width="300" />](https://comsysto.com/blog-post/docker-sicher-und-schlank-einsetzen-mit-grsecurity-apparmor-non-root-environments-und-host-firewall)

# DOCKER SICHER UND <br> SCHLANK EINSETZEN

Praktische Tipps für sichere Docker Container mit Grsecurity, AppArmor, non-root Environments und Host-Firewall.

Praxisbeispiel zum [BlogPost](https://comsysto.com/blog-post/docker-sicher-und-schlank-einsetzen-mit-grsecurity-apparmor-non-root-environments-und-host-firewall): Universelles Docker-Image für PHP Silex Anwendung.

----

### Benutzung

Bauen des Docker-Images `almightyphp`

```
git clone https://github.com/comsysto/poc-dockerized-silex-php-app.git ~/poc-dockerized-silex-php-app
cd ~/poc-dockerized-silex-php-app/
docker build -t almightyphp .
```

----

Installation von PHP Abhängigkeiten mit [Composer](https://getcomposer.org/)

```
docker run \
    -i -t \
    -v $(pwd)/php-demo-app/:/phpapp/www \
    -v $(pwd)/php-composer-home/:/phpapp/.composer \
    -v $(pwd)/php-data-dir/:/phpapp/data \
    almightyphp composer update -vvv
```

----

Starte die PHP Applikation mit Apache 2 Webserver und PHP7 mit Environment `local`

```
docker run \
    -i -t \
    -p 8899:9999 \
    -v $(pwd)/php-demo-app/:/phpapp/www \
    -v $(pwd)/php-composer-home/:/phpapp/.composer \
    -v $(pwd)/php-data-dir/:/phpapp/data \
    almightyphp
    
```

-----

Starte die PHP Applikation mit Apache 2 Webserver und PHP7 mit Environment `staging`

```
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

Das Image ist ca 50MB groß, würde man es auf Docker Hub publishen sicherlich nur die hälfte wegen der Kompression.

```
docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
almightyphp         latest              d1f73902aa78        27 minutes ago      50.95 MB
```

----

### License

  * Licensed under [MIT License](./LICENSE.md)
