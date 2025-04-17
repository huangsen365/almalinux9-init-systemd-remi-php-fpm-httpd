docker run --rm -it \
  --name almalinux9-init-systemd-remi-php-fpm-httpd-container \
  --privileged \
  --cgroupns=host \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  -p 8080:80 \
  huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd bash
#  huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd /usr/sbin/init
 
# huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd bash
# huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd /usr/sbin/init
