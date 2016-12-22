docker-nsd
==========

Docker image for nsd, a static authoritative nameserver.

How to use
----------

Create a `zones` directory. It will contain all the zones data and
configuration. For the `example.com` zone, the config file will be
`zones/example.com.conf` and the zone file will be
`zones/example.com.zone`

A zone config file looks like this:

    zone:
        name: "example.com"
        include-pattern: "zone"

You just have to replace `example.com` by the name of your zone.

The content of the zone file is a DNS zone respecting the standard
[Bind-Style Zone File Format](https://en.wikipedia.org/wiki/Zone_file).
You'll find an example in this repository.

Build the container (if not pulled from docker hub)

    # docker build -t nsd .

Start the container, binding your zones to the /etc/nsd/zones dir and
exposing the port 53 on tcp and udp.

    # docker run -d --name nsd -v $(pwd)/zones:/etc/nsd/zones:ro -p 53:53/udp -p 53:53 nsd

Check that it actually works (example files from this repo are used here):

    # dig +short +norecurse test.example.com @localhost
    10.0.0.1

If you make changes to the zones content, you can reload nsd:

    # docker exec nsd nsd-reload

