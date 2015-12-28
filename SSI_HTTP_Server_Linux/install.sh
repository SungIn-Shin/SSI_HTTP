#!/bin/sh

# Daemon Service 등록
########################################################
# DAEMON 
# SSI_HTTP_Server_Linux 폴더의 경로를 입력합니다.
#
DAEMON_HOME=/home/tlstjddls123/Desktop/test

########################################################
# jar 경로
# bin 폴더에 있는 jar파일의 경로
JAR_PATH=$DAEMON_HOME/bin/SSI_HTTP_Server.jar

########################################################
# HTTP Conf 파일
# HTTP 설정 파일 경로
#
HTTP_CONF_PATH=$DAEMON_HOME/conf/http.conf

########################################################
# log conf 파일
# log 설정 파일 경
#
LOG_CONF_PATH=$DAEMON_HOME/conf/log.conf

########################################################
# Service 이름
#
SERVICE_NAME=SSI_HTTP_Server

########################################################
# 쉘 스크립트 파일을 /etc/init.d 에 옮기면 service "서비스명" 명렁어
# 로 어디서든 접근 할 수 있다.
sudo cp $DAEMON_HOME/SSI_HTTP_Server_Linux.sh /etc/init.d/$SERVICE_NAME

#################################################
# 등록한 $SERVICE_NAME에게 실행 권한을 추가한다.
# (x) -> 실행권한  
# (+) -> 추가
# (a) -> 모든 사용자로
sudo chmod +x /etc/init.d/$SERVICE_NAME

sudo update-rc.d $SERVICE_NAME defaults

echo "$SERVICE_NAME로 등록되었습니다."

