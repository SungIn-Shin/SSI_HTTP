# SSI_HTTP

안녕하세요 SSI_HTTP 입니다.

이 프로젝트는 정말 최소한의 기능만 제공하는 HTTP Server입니다.

기본적인 GET/POST 요청을 처리하고, Logger를 사용하여 파일에 log를 남기는 프로그램입니다.

각 프로젝트 별 /conf/http.conf , /conf/log.conf 파일을 통해 사용자가 직접 지원하는 환경을 설정할 수 있고, 

JavaService(Window환경)와 Apache Commons Daemon(Linux환경) 을 사용하여 각 OS마다 백그라운드 Service를 지원합니다.

Java Service Wrapper 라이브러리를 사용하면 위의 두 라이브러리를 사용하지 않아도 Windows, Linux운영체제의 백그라운드 서비스를 구현할 수 있지만

현재 Java Service Wrapper는 64bit 운영체제를 유상으로 제공하고 있어 사용하지 않았습니다.

