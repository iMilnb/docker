### Collectd - Influxdb - Grafana stack

This stack has originally been created to easily visualize _cryptocurrencies_ values using [collectd-ticker][1], which sends the data to an [influxdb][2] database, which in turn is used by [grafana][3] as a data source.

Of course, it can be used for pretty much everything _CIF_ (_Collectd, InfluxDB, Grafana_) related, just modify the provided `collectd.conf` file in this repository and you're done.

### Usage

The one configuration you definitely want to modify is `ticker.json`, where the currencies you want to follow are listed, along with the _URL_ where to get the values from. Please refer to [collectd-ticker][1] repository in order to correctly fill this file.

You might want to modify the storage method (`volumes`) in the `docker-compose.yml` file, for example, to _mount bind_ `influxdb` or `grafana` volumes:

```
volumes:
  influxdb:
    driver_opts:
      type: none
      device: /home/foo/influxdb
      o: bind
```

When happy with the storage method, fire up `docker-compose`:

```
$ docker-compose up -d
```

Point your browser to `http://<docker_host>:3000`, `docker_host` being the machine hosting the `docker` containers. The login and password are _Grafana's_ default `admin` / `admin`.

Then add a _datasource_ with `InfluxDB` as the _Type_, `http://influxdb:8086` as the _URL_ and `collectd` as the _database_ name in the _InfluxDB Details_. You might have to wait a minute or so for the database to be filled with data, just retry.  
From there you should be able to create a _dashboard_ in order to _graph_ your assets. Note that the _interval_ should be set to `1m`, which is the _interval_ configured in `collectd.conf`. A typical query would be:

```
SELECT mean("value") FROM "ticker_value" WHERE ("instance" = 'btcusd')
```

This `docker-compose` is based on [this original GitHub repository](https://github.com/justlaputa/collectd-influxdb-grafana-docker).


[1]: https://github.com/iMilnb/collectd-ticker
[2]: https://www.influxdata.com/
[3]: https://grafana.com/
