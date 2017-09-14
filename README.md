# docker-gogstash
Small Docker image for [Gogstash](https://github.com/tsaikd/gogstash) based on latest Alpine.

see https://hub.docker.com/pteich/gogstash

```bash
docker run -d \
  --name gogstash \
  --hostname gogstash \
  -e GOMAXPROCS=4 \
  -v "/var/run/docker.sock:/var/run/docker.sock" \
  -v "${PWD}/dockerstats.json:/gogstash/config.json:ro" \
  pteich/gogstash:latest
