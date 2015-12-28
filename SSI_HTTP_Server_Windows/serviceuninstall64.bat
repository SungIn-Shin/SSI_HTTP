set SSI_HTTP_HOME=D:\SSI_HTTP_Server_Windows

set SERVICE_NAME=SSI_HTTP

sc stop "%SERVICE_NAME%"

sc delete "%SERVICE_NAME%"

"%SSI_HTTP_HOME%\JavaService.exe" -uninstall "%SERVICE_NAME%"