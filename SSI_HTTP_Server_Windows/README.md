# SSI_HTTP_Server_Windows

깃 허브에 처음 올리는 프로젝트 입니다.

HTTP Parser와 Logger를 기존에 제공하는 API를 사용하지 않고, 필요한 기능만 구현한 프로젝트 입니다.

# 참고하세요
1. 이 프로젝트는 Windows, Linux 버전 중 Windows버전입니다. 두 프로젝트의 코드는 동일하나 OS별 백그라운드 프로세스(데몬 프로세스)를 만드는 방법을 JavaService(Windows), Apache commons Daemon(Linux) 두가지로 나누어 사용하였습니다. Java Service Wrapper를 사용하면 하나의 프로젝트로 통합시킬 수 있지만 현재 Java Service Wrapper가 64비트 버전을 유료로 배포하고 있어서 무료 라이브러리를 사용하기 위해 두가지 방법을 사용하였습니다.

2. 각 OS별 JDK 7 (Java Development Key) 이상이 필요합니다.

## 디렉토리 구조
```dir
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
	┖ doc
	   ┖ 다이어그램
	   ┖ 시작메뉴얼
	   ┖ 요구사항
	   ┖ 테스트 계획서 및 결과서
	┖ out  -  JavaService의 log를 관리하는 폴더 JavaService -out 옵션 사용시 사용
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

### 1. SSI_HTTP_Server_Windows.zip파일의 압축을 해제



### 2. serviceinstall64.bat파일 설정
![Image of Install](https://github.com/SungIn-Shin/SSI_HTTP/blob/master/images/install_01.png)

```bat
rem Java JDK경로를 지정합니다. 개인 환경에 따라 상이할 수 있습니다.
set JAVA_HOME=C:\Program Files\Java\jdk1.7.0_79
rem 1-1에서 파일을 해제한 폴더의 경로를 지정한다.
set SSI_HTTP_HOME=D:\SSI_HTTP_Server
rem Service에 등록할 이름을 지정한다. (사용자 임의 지정)
set SERVICE_NAME=SSI_HTTP
rem bin 폴더에 있는 jar파일의 이름을 입력한다.
rem (개인이 변경하지 않았을 시 기본 값 그대로 사용하면 됨)
set SSI_HTTP_NAME=SSI_HTTP_Server.jar
rem 메인 클래스
set MAIN_CLASS=com.iheart.ssi.socket.SocketServer_Windows
rem http 설정 파일 경로를 입력한다.
set HTTP_CONF=%SSI_HTTP_HOME%\bin\http.conf
rem log 설정 파일 경로를 입력한다.
set LOG_CONF=%SSI_HTTP_HOME%\bin\log.conf
rem WEB-INF폴더 경로를 입력한다.
set WEB_HOME=%SSI_HTTP_HOME%\bin\WEB-INF
rem CONSOL에 찍히는 LOG를 남기는 경로를 지정한다.
rem 사용시 디스크 용량 초과를 초래할 수 있습니다.
set CONSOL_LOG_PATH=%SSI_HTTP_HOME%\out\http.log

rem 사용자 지정 파라미터를 사용할 수 있다. 개수제한이 없고, 추가할 때마다 파라미터를 rem 추가해주어야 한다.
set LOG_HEADER_PARAM_01="사용자 지정 Log Header"
set LOG_HEADER_PARAM_02="사용자 지정 Log Header"
set LOG_HEADER_PARAM_03="사용자 지정 Log Header"


"%SSI_HTTP_HOME%\JavaService.exe" -install "%SERVICE_NAME%" "%JAVA_HOME%\jre\bin\server\jvm.dll" -Djava.class.path="%SSI_HTTP_HOME%\bin\%SSI_HTTP_NAME%" -Dfile.encoding=UTF-8 -start "%MAIN_CLASS%" -params "%HTTP_CONF%" "%LOG_CONF%" "%WEB_HOME%" %LOG_HEADER_PARAM_01% %LOG_HEADER_PARAM_02% %LOG_HEADER_PARAM_03% -out D:\service.log
net start "%SERVICE_NAME%"

```


### 3. serviceuninstall64.bat 파일 설정 
```bat
rem JavaService.exe 경로를 지정한다
set SSI_HTTP_HOME=D:\SSI_HTTP_Server_Windows
rem Service Name을 install파일과 같이 지정한다.
set SERVICE_NAME=SSI_HTTP
rem Service Name의 Service를 정지한다.
sc stop "%SERVICE_NAME%"
rem 서비스를 삭제한다
sc delete "%SERVICE_NAME%"
rem JavaService에서 “SERVICE_NAME” 을 uninstall 시킨다.
"%SSI_HTTP_HOME%\JavaService.exe" -uninstall "%SERVICE_NAME%"

```

### Service 시작하기
- serviceinstall64.bat 파일을 관리자 권한으로 실행한다.
- 
![Image of Service Start](https://github.com/SungIn-Shin/SSI_HTTP/blob/master/images/serviceinstall64.bat%EC%8B%A4%ED%96%89.png)


### Service 실행 확인하기
- 윈도우 실행창에 service.msc를 실행 한다. (Window키+R)
![Image of Service Start](https://github.com/SungIn-Shin/SSI_HTTP/blob/master/images/%EC%8B%A4%ED%96%89.png)
- 실행 후 지정한 Service명으로 검색하고 상태를 확인 합니다.
- http://localhost:[port]/index.html 로 접속합니다.


![Image of HTTP index.html ](https://github.com/SungIn-Shin/SSI_HTTP/blob/master/images/index.png)

- index.html 페이지가 정상적으로 출력이 되면 서비스가 정상적으로 작동하고 있는 상태입니다.

### Windows Service 정지
- 등록된 서비스 클릭 후 [서비스 중지] 클릭


### Service Uninstall

- serviceuninstall64.bat 파일을 관리자 권한으로 실행시킨다.

 ![Image of Service uninstall ](https://github.com/SungIn-Shin/SSI_HTTP/blob/master/images/uninstall.png)
 
- Service가 중지된 후 요청 결과입니다.

![Image of Service ](https://github.com/SungIn-Shin/SSI_HTTP/blob/master/images/service_stop_page.png)



