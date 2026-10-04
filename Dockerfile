FROM tomcat:9.0-jre21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY src/main/webapp /usr/local/tomcat/webapps/ROOT
COPY build/classes /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

RUN sed -i 's/port="8005"/port="-1"/' /usr/local/tomcat/conf/server.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]