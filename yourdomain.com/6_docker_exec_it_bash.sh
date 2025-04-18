#docker exec -it almalinux9-init-systemd-remi-php-fpm-httpd-docker_yourdomain.com bash
#docker exec -it $(docker ps -aq --filter name=c_* | tail -n 1) bash
docker exec -it $(docker ps -aq --filter name=c_* --filter ancestor=huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd | tail -n 1) bash
