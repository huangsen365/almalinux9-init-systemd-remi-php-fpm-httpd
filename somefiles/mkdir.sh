mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/home
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/home/sshuser/.ssh
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/home/sshuser/dotfiles
chmod 700 /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/home/sshuser/.ssh
chown 1000:1000 /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/home/sshuser/.ssh
chown 1000:1000 /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/home/sshuser/dotfiles
echo "ln -sf ./dotfiles/.gitconfig .gitconfig" > /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/home/sshuser/ln_gitconfig.sh
chown 1000:1000 /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/home/sshuser/ln_gitconfig.sh
#touch /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/home/sshuser/.gitconfig
#chown 1000:1000 /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/home/sshuser/.gitconfig

mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/root
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/root/.ssh
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/root/shared
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/root/dotfiles
chmod 700 /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/root/.ssh
echo "ln -sf ./dotfiles/.gitconfig .gitconfig" > /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/root/ln_gitconfig.sh
#chmod 755 /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/root/shared
#chmod 755 /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/root/dotfiles
#touch /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/root/.gitconfig

mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/www
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/log
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/cache/yum
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/etc/httpd/conf2.d
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/www/www.yourdomain.com/www



mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/opcache
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/session
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/wsdlcache
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/etc/opt/remi/php74/php-fpm2.d

mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/opcache
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/session
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/wsdlcache
mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/etc/opt/remi/php84/php-fpm2.d



mkdir -p /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/spool/cron

mkdir -p /root/.config/htop
