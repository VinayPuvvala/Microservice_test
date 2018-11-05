
FROM openjdk
MAINTAINER Vinay Puvvala <vinaypuvvala88@gmail.com>
ADD target/*.war SpringBootMavenExample.war
ENTRYPOINT ["java", "-jar", "/SpringBootMavenExample.war"]
EXPOSE 9090
