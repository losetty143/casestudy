FROM tomcat:latest
ADD target/addressbook.war /usr/local/tomcat/webapps
CMD "catalina.sh" "run"
