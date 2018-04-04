FROM debian
MAINTAINER Emile `iMil' Heitor "imil@home.imil.net"

ENV DOLIVER 7.0.1
ENV DOLIPKG dolibarr_${DOLIVER}-4_all.deb
ENV DOLIDL https://sourceforge.net/projects/dolibarr/files/Dolibarr%20installer%20for%20Debian-Ubuntu%20%28DoliDeb%29/${DOLIVER}/dolibarr_${DOLIVER}-4_all.deb/download

ENV DOLI_URL_ROOT http://localhost/dolibarr
ENV DOLI_DB_HOST localhost
ENV DOLI_DB_NAME dolibarrdebian
ENV DOLI_DB_USER dolibarrdebian
ENV DOLI_DB_PASSWORD the_passwd


RUN apt update && apt-get install -y curl
# this command will throw an error as dependencies are not installed
RUN cd /tmp && curl -o ${DOLIPKG} -L ${DOLIDL} && \
	dpkg -i ${DOLIPKG} 2>&1; exit 0
# fix dependencies
RUN DEBIAN_FRONTEND='noninteractive' apt-get -f install -y

ENV APACHE_LISTEN_PORT 80
# https://github.com/paulczar/docker-apache2/blob/master/Dockerfile
ENV APACHE_RUN_USER    www-data
ENV APACHE_RUN_GROUP   www-data
ENV APACHE_PID_FILE    /var/run/apache2.pid
ENV APACHE_RUN_DIR     /var/run/apache2
ENV APACHE_LOCK_DIR    /var/lock/apache2
ENV APACHE_LOG_DIR     /var/log/apache2
ENV LANG               C

EXPOSE ${APACHE_LISTEN_PORT}

COPY start.sh /bin/

CMD ["/bin/start.sh"]
