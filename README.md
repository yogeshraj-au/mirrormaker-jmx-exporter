# mirrormaker-jmx-exporter
[![Docker](https://github.com/yogeshraj-au/mirrormaker-jmx-exporter/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/yogeshraj-au/mirrormaker-jmx-exporter/actions/workflows/docker-publish.yml)

This repo contains Dockerfile for Mirrormaker along with jmx-exporter. The jmx-exporter will expose the metrics at port 5060.

# Build and Run the docker image:

```
docker build -t mirrormaker .
docker run -d --name mirrormaker -p 5060:5060 mirrormaker
```