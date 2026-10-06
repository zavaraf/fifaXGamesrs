@echo off
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_144
set PATH=%JAVA_HOME%\bin;%PATH%

echo Usando Java: %JAVA_HOME%
java -version

echo.
echo Iniciando Jetty...
mvn jetty:run -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true
