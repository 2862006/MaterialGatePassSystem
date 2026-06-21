FROM tomcat:9.0-jdk11

# Copy entire project
COPY . /app
WORKDIR /app

# Install ant and JDK
RUN apt-get update && apt-get install -y ant

# Build WAR using ant
RUN ant -buildfile build.xml dist

# Deploy WAR
RUN cp dist/MaterialGatePassSystem.war /usr/local/tomcat/webapps/ROOT.war

# Verify
RUN ls -la /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]