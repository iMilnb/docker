This is the `Dockerfile` for the [collectd-ticker][1] plugin enabled [collectd][2].

You might want to map your own `collectd.conf` file and probably a `ticker.json` file matching your needs.  
Read the [project][1]'s main page in order to create the latter.

Example command:

```
$ docker run --rm -v $(pwd)/collectd.conf:/etc/collectd/collectd.conf -v $(pwd)/ticker.conf:/etc/collectd/ticker.json
```

[1]: https://github.com/iMilnb/collectd-ticker
[2]: https://collectd.org/
