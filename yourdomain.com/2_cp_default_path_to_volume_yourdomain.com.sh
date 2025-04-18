#cp -pR volumes/default_paths_for_docker/ volumes/volume_yourdomain.com/
#cp -pR volumes/opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/ volumes/volume_yourdomain.com/
rsync -av volumes/opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/ volumes/volume_yourdomain.com/
