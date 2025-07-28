# Use Tomcat base image with JDK 17
FROM tomcat:9.0-jdk17

# Remove default webapps to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file to ROOT
COPY target/EcommerceProject-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
