docker-nsd
==========

Docker image for nsd, a static authoritative nameserver.

How to use
----------

Create a `zones` directory. It will contain the zones data.
The `example.com` zone file will be `zones/example.com.zone`

The content of the zone file is a DNS zone respecting the standard
[Bind-Style Zone File Format](https://en.wikipedia.org/wiki/Zone_file).
You'll find an example in this repository.

Build the container (if not pulled from docker hub)

    # docker build -t nsd .

Start the container, binding your zones dir to the container's `/etc/nsd/zones`
dir and exposing the port 53 on tcp and udp. It will automatically generate
configuration files for the zones detected in the zones directory.

    # docker run -d --name nsd -v $(pwd)/zones:/etc/nsd/zones:ro -p 53:53/udp -p 53:53 nsd

Check that it actually works (example files from this repo are used here):

    # dig +short +norecurse test.example.com @localhost
    10.0.0.1

If you make changes to the zones content, you can regenerate the config and
reload nsd with this command:

    # docker exec nsd nsd-reload

