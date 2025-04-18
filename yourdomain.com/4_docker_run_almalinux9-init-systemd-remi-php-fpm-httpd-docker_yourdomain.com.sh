#!/bin/bash

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

# Check if any container named c_* from a specific image exists (running or stopped)
existing_container=$(docker ps -aq --filter name=c_* --filter ancestor=huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd)

# Check if a container with the name pattern exists
if [ -z "$existing_container" ]; then
  # No container matching c_* exists, or all matching containers are stopped
  echo "No container matching c_* exists, proceeding to start a new one..."

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

  # Start a new container if none found
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
    -p 80:80 \
    -p 443:443 \
    -p 2222:22 \
    --restart always \
    --name $cotainer_name \
    huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd
else
  echo -e "\033[31mContainer matching c_* already exists or is running. Proceeding with other tasks...\033[0m"

  # Optionally perform other tasks here (like backups or maintenance) if container is already running
fi
