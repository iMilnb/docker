## Dockerfile for Dolibarr 7

As I didn't find a proper _Dockerfile_ for versions 7+ of [Dolibarr][1] I took
this excuse to improve my [docker][2] skills.
The image is built using [dolideb][3] and its dependencies.

The environment variables you might want to modify are:

```
# those are pretty obvious

DOLI_URL_ROOT=http://localhost/dolibarr
DOLI_DB_HOST=localhost
DOLI_DB_NAME=dolibarrdebian
DOLI_DB_USER=dolibarrdebian
DOLI_DB_PASSWORD=the_passwd
APACHE_LISTEN_PORT=80

# if this is a new Dolibarr installation, i.e. no database exists yet, set this

FRESH_INSTALL=yes
```

* Build

`$ docker build --rm --force-rm -t foo/dolibarr .`

* Example run

`$ docker run --net="host" --rm -e "DOLI_DB_PASSWORD=myawesomepassword" -e "DOLI_DB_HOST=127.0.0.1" -e "APACHE_LISTEN_PORT=8080" foo/dolibarr`


[1]: https://www.dolibarr.org/
[2]: https://www.docker.com/
[3]: https://sourceforge.net/projects/dolibarr/files/Dolibarr%20installer%20for%20Debian-Ubuntu%20%28DoliDeb%29/
