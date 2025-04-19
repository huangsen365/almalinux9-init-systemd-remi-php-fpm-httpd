#!/bin/bash

# Ensure REMIPHPPATH is set
if [ -n "$REMIPHPPATH" ]; then
    echo "REMIPHPPATH is : ${REMIPHPPATH}"

    cd ${REMIPHPPATH}/yourdomain.com
	
    # existing_container=$(docker ps -aq --filter name=c_* --filter ancestor=huangsen365/almalinux9-init-systemd-remi-php-fpm-httpd)

    # Get all container IDs and filter by the image name
    container_ids=$(docker ps -aq)
    existing_containers=""

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
