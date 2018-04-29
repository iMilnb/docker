FROM debian:stretch-backports

LABEL maintainer="Emile `iMil' Heitor <imil@home.imil.net>"

RUN echo $'APT::Install-Recommends "0";\nAPT::Install-Suggests "0";\n' \
    >> /etc/apt/apt.conf.d/01norecommend && \
    apt-get -y update && apt-get -y install collectd
# build packages
RUN apt-get -y install collectd-dev make git
RUN apt-get -y -t stretch-backports install golang

ENV GOPATH /go

WORKDIR ${GOPATH}

RUN go get collectd.org/api && \
    git clone https://github.com/iMilnb/collectd-ticker.git && \
    cd collectd-ticker && make && make install

WORKDIR /

RUN rm -rf ${GOPATH} && apt-get -y purge collectd-dev git golang make

COPY conf/* /etc/collectd/

CMD ["/usr/sbin/collectd", "-f"]
