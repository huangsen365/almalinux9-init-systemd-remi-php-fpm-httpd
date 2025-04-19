#!/bin/bash

# Ensure REMIPHPPATH is set
if [ -z "$REMIPHPPATH" ]; then
    echo "REMIPHPPATH is not set...exiting..."
    exit 1
else
    echo "REMIPHPPATH is : ${REMIPHPPATH}"
fi

# Set the base directory for your domain
cd ${REMIPHPPATH}/yourdomain.com
current_dir=$(pwd)

# Generate date and hostname-based names for directories and container
date_and_hostname=$(date +%Y-%m-%d_%H%M%S)_$(hostname)
date_and_hostname_onlydate=$(date +%Y-%m-%d)
home_dir_name=home_$date_and_hostname
root_dir_name=root_$date_and_hostname
log_dir_name=log_$date_and_hostname
cron_dir_name=cron_$date_and_hostname
cotainer_name=c_$date_and_hostname

# existing_container=$(docker ps -aq --filter name=c_* --filter ancestor=huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd)
# Get all container IDs
container_ids=$(docker ps -aq)

# If there are container IDs, inspect them
if [ -n "$container_ids" ]; then
    existing_containers=$(echo "$container_ids" | xargs docker inspect --format '{{.Id}}: {{.Config.Image}}' | grep 'huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd' | awk -F: '{print $1}')
fi

# Check if any container based on the image exists
if [ -n "$existing_containers" ]; then
    echo -e "\033[0;31m发现已有基于指定镜像的容器，请妥当操作之再重新执行本脚本!\n正在取消本次操作...\033[0m"
    echo -e "\033[0;31mFound docker containers based on the specified image, please manage them properly and then rerun this script!\nAborting this action...\033[0m"

    # List the containers for user's information (based on the image)
    echo -e "\033[0;33m以下是现有容器ID及相关信息:\033[0m"
    echo "$existing_containers"
    exit 1
else
    echo -e "\033[0;32mNot found existing docker containers based on the specified image, this script will continue in 3 seconds...\033[0m"
    sleep 3
    echo "ready go in 1s!"
    sleep 1
    echo "go now!"
fi

# Perform rsync to backup specific directories, excluding certain files
rsync -av --exclude '/sshuser/.ssh' --exclude '/sshuser/dotfiles' \
  $current_dir/volumes/volume_yourdomain.com/home/ \
  $current_dir/volumes/volume_yourdomain.com/$home_dir_name/

rsync -av --exclude '/.ssh' --exclude '/dotfiles' --exclude '/shared' \
  $current_dir/volumes/volume_yourdomain.com/root/ \
  $current_dir/volumes/volume_yourdomain.com/$root_dir_name/

rsync -av $current_dir/volumes/volume_yourdomain.com/var/log/ \
  $current_dir/volumes/volume_yourdomain.com/var/$log_dir_name/

rsync -av $current_dir/volumes/volume_yourdomain.com/var/spool/cron/ \
  $current_dir/volumes/volume_yourdomain.com/var/spool/$cron_dir_name/

# Start a new container if no container with the specified image is found
docker run -d \
  --privileged \
  --cgroupns=host \
  -v /sys/fs/cgroup:/sys/fs/cgroup:rw \
  -v $current_dir/volumes/volume_yourdomain.com/$home_dir_name:/home \
  -v $current_dir/volumes/volume_yourdomain.com/home/sshuser/.ssh:/home/sshuser/.ssh \
  -v $current_dir/volumes/volume_yourdomain.com/home/sshuser/dotfiles:/home/sshuser/dotfiles \
  -v $current_dir/volumes/volume_yourdomain.com/$root_dir_name:/root \
  -v $current_dir/volumes/volume_yourdomain.com/root/.ssh:/root/.ssh \
  -v $current_dir/volumes/volume_yourdomain.com/root/shared:/root/shared \
  -v $current_dir/volumes/volume_yourdomain.com/root/dotfiles:/root/dotfiles \
  -v $current_dir/volumes/volume_yourdomain.com/var/www:/var/www \
  -v $current_dir/volumes/volume_yourdomain.com/var/cache/yum:/var/cache/yum \
  -v $current_dir/volumes/volume_yourdomain.com/var/$log_dir_name:/var/log \
  -v $current_dir/volumes/volume_yourdomain.com/var/spool/$cron_dir_name:/var/spool/cron \
  -v $current_dir/volumes/volume_yourdomain.com/etc/httpd/conf2.d:/etc/httpd/conf2.d \
  -v $current_dir/volumes/volume_yourdomain.com/var/opt/remi/php74/lib/php:/var/opt/remi/php74/lib/php \
  -v $current_dir/volumes/volume_yourdomain.com/var/opt/remi/php84/lib/php:/var/opt/remi/php84/lib/php \
  -v $current_dir/volumes/volume_yourdomain.com/etc/opt/remi/php74/php-fpm2.d:/etc/opt/remi/php74/php-fpm2.d \
  -v $current_dir/volumes/volume_yourdomain.com/etc/opt/remi/php84/php-fpm2.d:/etc/opt/remi/php84/php-fpm2.d \
  -p 443:443 \
  -p 2222:22 \
  --restart always \
  --name $cotainer_name \
  huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd
