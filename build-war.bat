@echo off
set JAVA_HOME=C:\Program Files\Java\jdk1.8.0_144
set PATH=%JAVA_HOME%\bin;%PATH%

echo Usando Java: %JAVA_HOME%
java -version

echo.
echo Generando WAR...
mvn clean package -DskipTests

echo.
echo WAR generado en: target\fifaapp.war
pause
