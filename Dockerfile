FROM tomcat:9.0-jdk11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY dist/MaterialGatePassSystem.war /usr/local/tomcat/webapps/ROOT.war

RUN ls -la /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]