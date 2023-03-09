# Highload Software Architecture 8 Lesson 8 Homework

Web Servers: Nginx fine-tuning
---

## Project Description

There is a simple static web page with some images, located under [www](www) directory. Images could be shuffled on the filesystem with [/scripts/shuffle.sh](scripts/shuffle.sh) script.

The web page and images are served by Nginx web server. The configuration file is located under [config/nginx.conf](config/nginx.conf).

Nginx runs two services: one on port 8081, which doesn't use cache and always loads files from a filesystem. The second one runs on 8080 and performs caching, using the first service as a backend.

The cache bypasses two first requests of an image. Individual image cache can be forced to reload by adding a `X-Update-Cache` header to a request.

## How to run a demo

1. Run `docker-compose up` to start Nginx.
2. Open [http://localhost:8080](http://localhost:8080) in your browser.
3. Notice that images match their descriptions.
4. Reload page two times and check the [logs/cache.log](logs/cache.log) file. You should see that the first two requests are not cached, subsequent requests are cached.
5. Run `./scripts/shuffle.sh` to shuffle images on the filesystem. Reload page and notice that images are cached and not updated.
6. Run `./refresh.sh` specifying set of images like `100 101 102 200 201 202 300 301 302 400 401 402 500 501 502` to force cache reload for them. Reload page and notice that images are updated now.

## Nginx configuration

The caching behavior is controlled by the following configuration directives:

Using cache for each url:
```
proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=img_cache:100m inactive=60m;
proxy_cache_key "$scheme$request_method$host$request_uri";
```

Bypassing cache for the first two requests:
```
proxy_cache_min_uses 2;
```

Forcing cache reload:
```
proxy_cache_bypass $http_x_update_cache;
```
