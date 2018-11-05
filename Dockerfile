
FROM openjdk
MAINTAINER Vinay Puvvala <vinaypuvvala88@gmail.com>
ADD target/*.jar SpringBootMavenExample.jar
ENTRYPOINT ["java", "-jar", "/SpringBootMavenExample.jar"]
EXPOSE 9090
