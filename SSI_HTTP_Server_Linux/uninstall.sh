#!/bin/sh

# jar 파일 경로


########################################################
# Service 이름
#
SERVICE_NAME=SSI_HTTP_Server

sudo update-rc.d -f $SERVICE_NAME remove

echo "$SERVICE_NAME 자동실행 제거"

sudo rm /etc/init.d/$SERVICE_NAME

echo "/etc/init.d/$SERVICE_NAME 제거"

sudo pkill jsvc
