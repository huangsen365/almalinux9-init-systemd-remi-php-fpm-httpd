# git ls-remote https://github.com/huangsen365/centos7-remi-php.git | head -n 1 | cut -c1-8 > /opt/centos7-remi-php/version.txt
# date +%Y%m%d | awk -v version="$(git ls-remote https://github.com/huangsen365/centos7-remi-php.git | head -n 1 | cut -c1-8)" '{print "remi-php-"$0"-"version}' > /opt/centos7-remi-php/version.txt
# date +%Y%m%d-%H%M%S | awk -v version="$(git ls-remote https://github.com/huangsen365/centos7-remi-php.git | head -n 1 | cut -c1-8)" '{print "remi-php-"$0"-"version}' > /opt/centos7-remi-php/version.txt

echo "remi-php-$(date +%Y%m%d-%H%M%S)-$(git ls-remote https://github.com/huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd.git HEAD | cut -c1-8)" > /opt/almalinux9-init-systemd-remi-php-fpm-httpd/version.txt
