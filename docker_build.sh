#docker build --rm --no-cache -t huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd -f Dockerfile .
#docker build --rm --no-cache -t huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd -f Dockerfile .

# docker build -t huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd -f Dockerfile .

date_time=$(date +%Y-%m-%d_%H%M%S)
#docker build -t huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd . > ./docker_build_log/$date_time.txt &
docker build --rm --no-cache -t huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd . > ./docker_build_log/$date_time.txt &
# 稍等一秒钟，等待以上$date_time.txt文件创建好
sleep 1
tail -f ./docker_build_log/$date_time.txt
