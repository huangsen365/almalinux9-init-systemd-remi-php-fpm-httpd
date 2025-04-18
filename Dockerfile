# Use the official AlmaLinux 9 UBI Init image, which includes systemd as PID 1
FROM almalinux/9-init

# Set the maintainer label
LABEL maintainer="admin@wansio.com"

RUN dnf -y install dnf-plugins-core && \
    dnf config-manager --set-enabled crb

# Install Apache HTTPD and PHP-FPM (Remi repository) / epel-release 
RUN dnf -y update && \
    dnf -y install ncurses wget httpd && \
    dnf -y install https://dl-fedoraproject-org.jiasu.yunbiyun.com/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm && \
    dnf -y install https://rpms-remirepo-net.jiasu.yunbiyun.com/enterprise/remi-release-$(rpm -E %rhel).rpm && \
    dnf -y install --nogpgcheck https://mirror-fcix-net.jiasu.yunbiyun.com/rpmfusion/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm https://mirror-fcix-net.jiasu.yunbiyun.com/rpmfusion/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm && \
    dnf -y install ffmpeg ffmpeg-devel && \
    dnf -y install tmux htop && \
    dnf -y update
    #dnf clean all

# Fix the "ServerName localhost" warning in Apache
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

# wget https://raw-githubusercontent-com.jiasu.yunbiyun.com/huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd/refs/heads/main/dnf_basics.txt
ADD dnf_basics.txt /opt/dnf_basics.txt
RUN dnf -y install $(cat /opt/dnf_basics.txt | grep -v '#') && \
    dnf -y install php74 php84 \
	php74-php-fpm php84-php-fpm

COPY www_php-fpm_7400.conf /etc/opt/remi/php74/php-fpm.d/www.conf
COPY www_php-fpm_8400.conf /etc/opt/remi/php84/php-fpm.d/www.conf
COPY php-fpm_7401_www.yourdomain.com_NEW2.conf_template /etc/opt/remi/php74/php-fpm.d/php-fpm_7401_www.yourdomain.com_NEW2.conf_template
COPY php-fpm_8401_www.yourdomain.com_NEW2.conf_template /etc/opt/remi/php84/php-fpm.d/php-fpm_8401_www.yourdomain.com_NEW2.conf_template

ADD somefiles_for_dnf /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles_for_dnf
RUN dnf -y install $(cat /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles_for_dnf/dnf_search_php_extensions_list_php74_defined.txt)
RUN dnf -y install $(cat /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles_for_dnf/dnf_search_php_extensions_list_php84_defined.txt)
RUN dnf -y install $(cat /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles_for_dnf/dnf_search_php_extensions_list_php74_defined2.txt | grep -v '#') --exclude="$(cat /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles_for_dnf/dnf_search_php_extensions_list_php74_defined2-exclude.txt)"
RUN dnf -y install $(cat /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles_for_dnf/dnf_search_php_extensions_list_php84_defined2.txt | grep -v '#') --exclude="$(cat /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles_for_dnf/dnf_search_php_extensions_list_php84_defined2-exclude.txt)"

ADD somefiles /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles
RUN sh /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles/mkdir.sh
RUN sh /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles/rsync.sh

RUN sed -i '/include\=\/etc\/opt\/remi\/php74\/php-fpm.d\/\*\.conf/a include\=\/etc\/opt\/remi\/php74\/php-fpm2.d\/\*\.conf' /etc/opt/remi/php74/php-fpm.conf
RUN sed -i '/include\=\/etc\/opt\/remi\/php84\/php-fpm.d\/\*\.conf/a include\=\/etc\/opt\/remi\/php84\/php-fpm2.d\/\*\.conf' /etc/opt/remi/php84/php-fpm.conf

ADD somefiles_for_scripts /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles_for_scripts
RUN sh /opt/almalinux9-init-systemd-remi-php-fpm-httpd/somefiles_for_scripts/mark_version.sh

# Configure PHP-FPM to run with Apache
#RUN systemctl enable php-fpm.service httpd.service

# Create a test page for Apache
# RUN echo "<html><body><h1>Apache and PHP are running in AlmaLinux 9 Init Container</h1></body></html>" > /var/www/html/index.php

# Enable the php84-php-fpm and httpd service
RUN systemctl disable sshd.service
RUN systemctl enable php74-php-fpm.service
RUN systemctl enable php84-php-fpm.service httpd.service crond.service 

#RUN dnf clean all
RUN dnf -y update && dnf clean all

# Expose the HTTPS port
EXPOSE 443

# Set up volume for systemd to mount cgroups
VOLUME [ "/sys/fs/cgroup" ]

# CMD is already set in almalinux/9-init to run systemd as PID 1
CMD ["/usr/sbin/init"]