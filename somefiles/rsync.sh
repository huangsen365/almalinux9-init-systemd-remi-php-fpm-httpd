ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#useradd -s /sbin/nologin sshuser
useradd sshuser
usermod -aG apache sshuser

sed -i 's/AllowOverride\ None/AllowOverride\ All/g' /etc/httpd/conf/httpd.conf
echo "IncludeOptional conf2.d/*.conf" >> /etc/httpd/conf/httpd.conf
sed -i 's/SecResponseBodyAccess\ Off/SecResponseBodyAccess\ On/g' /etc/httpd/conf.d/mod_security.conf
sed -i 's/SecAuditEngine\ RelevantOnly/SecAuditEngine\ On/g' /etc/httpd/conf.d/mod_security.conf
sed -i 's/SecRuleEngine\ On/SecRuleEngine\ DetectionOnly/g' /etc/httpd/conf.d/mod_security.conf

rsync -av /home/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/home/
rsync -av /root/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/root/
rsync -av /var/www/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/www/
rsync -av /var/log/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/log/

rsync -av /etc/httpd/conf.d/ --exclude '*' /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/etc/httpd/conf2.d/
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles/httpd_XX01_www.yourdomain.com.conf /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/etc/httpd/conf2.d/httpd_XX01_www.yourdomain.com.conf_template
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles/info.php /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/www/www.yourdomain.com/www/info.php
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles/gitpull.sh /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/www/www.yourdomain.com/gitpull.sh
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles/gitpull.php /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/www/www.yourdomain.com/www/gitpull.php
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles/.gitignore_template /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/www/www.yourdomain.com/.gitignore
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles/mkdir_chown_chmod.sh /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/root/mkdir_chown_chmod.sh

chown -R 1000:1000 /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/www/www.yourdomain.com
cat /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles/vimrc_append_conf.txt >> /etc/vimrc
cat /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles/bashrc_append.txt >> /etc/bashrc



rsync -av /etc/opt/remi/php74/php-fpm.d/ --exclude '*' /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/etc/opt/remi/php74/php-fpm2.d/
rsync -av /etc/opt/remi/php74/php-fpm.d/php-fpm_7401_www.yourdomain.com_NEW2.conf_template /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/etc/opt/remi/php74/php-fpm2.d/php-fpm_7401_www.yourdomain.com_NEW2.conf
rsync -av /var/opt/remi/php74/lib/php/opcache/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/opcache/
rsync -av /var/opt/remi/php74/lib/php/session/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/session/
rsync -av /var/opt/remi/php74/lib/php/wsdlcache/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/wsdlcache/
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/opcache/ /var/opt/remi/php74/lib/php/opcache/www.yourdomain.com/
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/session/ /var/opt/remi/php74/lib/php/session/www.yourdomain.com/
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/wsdlcache/ /var/opt/remi/php74/lib/php/wsdlcache/www.yourdomain.com/
touch /var/opt/remi/php74/lib/php/opcache/www.yourdomain.com/.keep
touch /var/opt/remi/php74/lib/php/session/www.yourdomain.com/.keep
touch /var/opt/remi/php74/lib/php/wsdlcache/www.yourdomain.com/.keep
rsync -av /var/opt/remi/php74/lib/php/opcache/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/opcache/
rsync -av /var/opt/remi/php74/lib/php/session/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/session/
rsync -av /var/opt/remi/php74/lib/php/wsdlcache/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php74/lib/php/wsdlcache/

rsync -av /etc/opt/remi/php84/php-fpm.d/ --exclude '*' /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/etc/opt/remi/php84/php-fpm2.d/
rsync -av /etc/opt/remi/php84/php-fpm.d/php-fpm_8401_www.yourdomain.com_NEW2.conf_template /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/etc/opt/remi/php84/php-fpm2.d/php-fpm_8401_www.yourdomain.com_NEW2.conf
rsync -av /var/opt/remi/php84/lib/php/opcache/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/opcache/
rsync -av /var/opt/remi/php84/lib/php/session/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/session/
rsync -av /var/opt/remi/php84/lib/php/wsdlcache/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/wsdlcache/
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/opcache/ /var/opt/remi/php84/lib/php/opcache/www.yourdomain.com/
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/session/ /var/opt/remi/php84/lib/php/session/www.yourdomain.com/
rsync -av /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/wsdlcache/ /var/opt/remi/php84/lib/php/wsdlcache/www.yourdomain.com/
touch /var/opt/remi/php84/lib/php/opcache/www.yourdomain.com/.keep
touch /var/opt/remi/php84/lib/php/session/www.yourdomain.com/.keep
touch /var/opt/remi/php84/lib/php/wsdlcache/www.yourdomain.com/.keep
rsync -av /var/opt/remi/php84/lib/php/opcache/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/opcache/
rsync -av /var/opt/remi/php84/lib/php/session/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/session/
rsync -av /var/opt/remi/php84/lib/php/wsdlcache/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/opt/remi/php84/lib/php/wsdlcache/



rsync -av /var/spool/cron/ /opt/almalinux9-init-systemd-remi-php-fpm-httpd/default_paths_for_docker/var/spool/cron/
