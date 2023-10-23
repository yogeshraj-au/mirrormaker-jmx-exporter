# mirrormaker-jmx-exporter

This repo contains Dockerfile for Mirrormaker along with jmx-exporter. The jmx-exporter will expose the metrics at port 5060.

# Build and Run the docker image:

```
docker build -t mirrormaker .
docker run -d --name mirrormaker -p 5060:5060 mirrormaker
```