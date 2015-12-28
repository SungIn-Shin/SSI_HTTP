#!/bin/sh

#######################################
# JAVA JDK 경로
# 
JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64


####################################################
# 사용 USER 설정
#
USER=tlstjddls123

####################################################
# Daemon 경로 설정
#
DAEMON_HOME=/home/tlstjddls123/Desktop/test


####################################################
# JSVC 경로지정
#
JSVC=$DAEMON_HOME/jsvc


PID_FILE=$DAEMON_HOME/out/http.pid
OUT_FILE=$DAEMON_HOME/out/http.out
ERR_FILE=$DAEMON_HOME/out/http.err

CLASSPATH=$DAEMON_HOME/bin/commons-daemon-1.0.15.jar:$DAEMON_HOME/bin/SSI_HTTP_Server.jar

MAIN_CLASS=com.iheart.ssi.socket.SocketServer_Linux

###############################################################
# Java Main Parameter
# 사용자가 원하는 경로에 복사해서 두시고 그 경로를 지정하시면 됩니다.

# http.conf Path
PARAMETER_01=$DAEMON_HOME/conf/http.conf
# log.conf Path 
PARAMETER_02=$DAEMON_HOME/conf/log.conf
#WEB-INF path 
PARAMETER_03=$DAEMON_HOME/WEB-INF 
#base operation system name
PARAMETER_04="LINUX" 
# custom log message
PARAMETER_05="zzz"

case "$1" in

  start)
	$JSVC \
	-user $USER \
	-java-home $JAVA_HOME \
	-pidfile $PID_FILE \
	-outfile $OUT_FILE \
	-errfile $ERR_FILE \
	-cp $CLASSPATH $MAIN_CLASS $PARAMETER_01 $PARAMETER_02 $PARAMETER_03 $PARAMETER_04 $PARAMETER_05
	exit $?
	;;

  stop)
	$JSVC \
	-stop \
	-nodetach \
	-java-home $JAVA_HOME \
	-pidfile $PID_FILE \
	-outfile $OUT_FILE \
	-errfile $ERR_FILE \
	-cp $CLASSPATH $MAIN_CLASS $PARAMETER_01 $PARAMETER_02 $PARAMETER_03 $PARAMETER_04 $PARAMETER_05
	exit $?
	;;
  *)
	echo "[Usage] SSI_HTTP_Server_Linux.sh start | stop"
	exit 1;;

esac
