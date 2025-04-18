docker cp -a almalinux9-init-systemd-remi-php-fpm-httpd-test:/opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker.tar.gz ./volumes/
rm -rf ./volumes/opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker
tar zxvf ./volumes/default_paths_for_docker.tar.gz -C ./volumes/
