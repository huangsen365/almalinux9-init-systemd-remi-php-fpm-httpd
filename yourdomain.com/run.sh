#!/bin/bash

# Ensure REMIPHPPATH is set
if [ -n "$REMIPHPPATH" ]; then
    echo "REMIPHPPATH is : ${REMIPHPPATH}"

    cd ${REMIPHPPATH}/yourdomain.com

    # Check if any container named c_* based on the specific image exists (running or stopped)
    existing_container=$(docker ps -aq --filter name=c_* --filter ancestor=huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd)

    # Check if a container matching c_* based on the image exists
    if [ -n "$existing_container" ]; then
        echo -e "\033[0;31m发现已有命名为 c_* 的实例，且基于指定镜像，请妥当操作之再重新执行本脚本!\n正在取消本次操作...\033[0m"
        echo -e "\033[0;31mFound docker containers named as c_* and based on the specified image, please manage them properly and then rerun this script!\nAborting this action...\033[0m"
        exit 1
    else
        echo -e "\033[0;32mNot found existing docker containers named as c_* and based on the specified image, this script will continue in 3 seconds...\033[0m"
        sleep 3
        echo "ready go in 1s!"
        sleep 1
        echo "go now!"
    fi

    # Run the necessary scripts if no container exists
    sh ./0_docker_run_test.sh
    sh ./1_docker_cp_default_paths_for_docker_to_volumes.sh
    sh ./2_cp_default_path_to_volume_yourdomain.com.sh
    sh ./3_docker_stop_and_rm_myalmalinux.sh
    sh ./4_docker_run_almalinux9-init-systemd-remi-php-fpm-httpd-docker_yourdomain.com.sh
    #sh ./5_docker_exec_mkdir_chown_chmod.sh
    sh ./6_docker_exec_it_bash.sh

else
    echo "REMIPHPPATH is not set...exiting..."
    exit 1
fi
