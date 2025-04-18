#!/bin/bash

# 启动 Docker 容器并运行，添加了 --cgroupns=host 和端口映射
docker run --privileged --name almalinux9-init-systemd-remi-php-fpm-httpd-test \
  --cgroupns=host \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  -d --restart always \
  huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd

# 等待容器启动完成
echo "等待容器启动..."
sleep 10

# 执行 tar 命令，将目标路径内容打包
docker exec almalinux9-init-systemd-remi-php-fpm-httpd-test tar zcvf /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker.tar.gz \
  -C /opt/almalinux9-init-systemd-remi-php-fpm-httpd/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/

echo "打包完成"
