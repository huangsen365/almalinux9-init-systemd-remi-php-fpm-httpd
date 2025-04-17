docker run -d \
  --privileged \
  --cgroupns=host \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  -p 8080:80 \
  --name myremiphptest \
  huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd