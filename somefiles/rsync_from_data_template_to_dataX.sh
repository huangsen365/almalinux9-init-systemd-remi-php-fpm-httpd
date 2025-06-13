# curl -fsSL https://raw-githubusercontent-com.jiasu.yunbiyun.com/huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd/refs/heads/main/somefiles/rsync_from_data_template_to_dataX.sh -o /root/rsync_from_data_template_to_dataX.sh
# curl -fsSL https://raw.githubusercontent.com/huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd/refs/heads/main/somefiles/rsync_from_data_template_to_dataX.sh -o /root/rsync_from_data_template_to_dataX.sh
if [ -n "$1" ]; then
    rsync -av /root/data_template/* /root/"$1"/
else
    echo "dataX argv is NOT set"
fi
