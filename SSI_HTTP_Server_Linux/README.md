# SSI_HTTP_Server_Linux (Ubuntu 기준)

깃 허브에 처음 올리는 프로젝트 입니다.

HTTP Parser와 Logger를 기존에 제공하는 API를 사용하지 않고, 필요한 기능만 구현한 프로젝트 입니다.


# 참고하세요
1. 이 프로젝트는 Linux(Ubuntu)기반으로 개발되었습니다. Windows버전은 SSI_HTTP_Server_Windows프로젝트를 참고하세요. 코드는 동일하고 JavaService(Windows)를 사용하여 구현하였나, Apache commons Daemon(Linux)을 사용하였냐의 차이입니다. Java Service Wrapper를 사용하면 운영체제 상관없이 Java Service Wrapper만으로 Windows와 Linux의 서비스 형태로 Application을 제공할 수 있지만 현재 Java Service Wrapper가 64bit환경은 라이센스를 유료로 제공하고 있기에 Window와 Linux 각각 무료로 제공하고 있는 라이브러리를 사용하였습니다.

2. 각 OS별 JDK 7 (Java Development Key) 이상이 필요합니다. 설치가 되어 있지 않으시다면, 혹은 모르시다면 이 문서를 확인하시길 바랍니다.

## 디렉토리 구조
```
SSI_HTTP_Server_Linux
	┖ bin 
	   ┖ com
	     ┖ iheart 
	       ┖ ssi
	         ┖ exception
	         ┖ httpparser
	         ┖ httpservice
	         ┖ logger
	         ┖ main
	         ┖ socket
	┖ conf
	   ┖ http.conf
	   ┖ log.conf
	┖ daemon
	   ┖ ... Apache Commons Daemon
	┖ doc
	   ┖ 다이어그램
	   ┖ 시작메뉴얼
	   ┖ 요구사항
	   ┖ 테스트 계획서 및 결과서
	┖ out  - error, consol, PID 등을 관리하는 폴더
	┖ src  - 소스파일
	   ┖ SSI_HTTP_Project.zip
	   ┖ com
	     ┖ iheart 
	       ┖ ssi
	         ┖ exception
	         ┖ httpparser
	         ┖ httpservice
	         ┖ logger
	         ┖ main
	         ┖ socket
	┖ WEB-INF 
```

## 설정


###install.sh 파일
```sh
#!/bin/sh

# Daemon Service 등록 쉘 스크립트
########################################################
# DAEMON 
# SSI_HTTP_Server_Linux 폴더의 경로를 입력합니다.
#
DAEMON_HOME=/home/tlstjddls123/Desktop/SSI_HTTP_Server_Linux
########################################################
# jar 경로
# bin 폴더에 있는 jar파일의 경로 지정
JAR_PATH=$DAEMON_HOME/bin/SSI_HTTP_Server.jar

########################################################
# HTTP Conf 파일
# HTTP 설정 파일 경로 지정
#
HTTP_CONF_PATH=$DAEMON_HOME/conf/http.conf

########################################################
# log conf 파일
# log 설정 파일 경로 지정
#
LOG_CONF_PATH=$DAEMON_HOME/conf/log.conf

########################################################
# Service 이름 지정
#
SERVICE_NAME=SSI_HTTP_Server

########################################################
# 쉘 스크립트 파일을 /etc/init.d 에 옮겨서 service "서비스명" 명렁어
# 로 어디서든 접근 할 수 있도록 지정
sudo cp $DAEMON_HOME/SSI_HTTP_Server_Linux.sh /etc/init.d/$SERVICE_NAME

#################################################
# 등록한 $SERVICE_NAME에게 실행 권한을 추가한다.
# (x) -> 실행권한  
# (+) -> 추가
# (a) -> 모든 사용자로
sudo chmod +x /etc/init.d/$SERVICE_NAME

sudo update-rc.d $SERVICE_NAME defaults

echo "$SERVICE_NAME로 등록되었습니다."

```



###SSI_HTTP_Server_Linux.sh 스크립트 파일

```sh
#!/bin/sh

#######################################
#  JAVA JDK 경로 지정
#  사용 환경에 설정된 JDK의 경로로 지정합니다.
#  JDK가 설치되어 있지 않으면 설치 후 진행하셔야 합니다.
#  (JDK 설치 방법은 부록에 있습니다.)
JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64


####################################################
# 사용 USER 설정
#  Daemon을 사용할 수 있는 USER를 설정합니다.
USER=tlstjddls123

####################################################
# Daemon 경로 설정
#
DAEMON_HOME=/home/tlstjddls123/Desktop/SSI_HTTP_Server_Linux


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
# 필요 파라미터 정보
# 1. http.conf 파일
# 2. log.conf 파일
# 3. WEB-INF 경로
# 4. 4번째 파라미터부터 사용자 설정 Log Header
# 파라미터가 추가될 때 마다 case문에 파라미터도 추가해주어야 합니다.

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

```

###uninstall.sh 스크립트 파일
uninstall.sh

```sh
#!/bin/sh

# jar 파일 경로


########################################################
# Service 이름
# install.sh 에서 설정한 SERVICE_NAME과 동일하게 설정합니다.
SERVICE_NAME=SSI_HTTP_Server

sudo update-rc.d -f $SERVICE_NAME remove

echo "$SERVICE_NAME 자동실행 제거"

sudo rm /etc/init.d/$SERVICE_NAME

echo "/etc/init.d/$SERVICE_NAME 제거"

sudo pkill jsvc
```


## 부록

### JDK설치

패키지 인덱스 업데이트
```sh
sudo apt-get update
```

JDK 설치
```sh
sudo apt-get install openjdk-7-jdk
```

설치 유무 확인
java -version
```sh
java version "1.7. ..."
OpenJDK Runtiom Environment (IcedTea 2.6.3) (7u91-2.6.3-0ubuntu 0.14.04.1)
OpenJDK 64-bit Server VM (build 24.91-b01, mixed mode)
```

기본적인 설치 경로는
```sh
/usr/lib/jvm/java-7-openjdk-amd64/ ->JAVA_HOME
```
입니다.
