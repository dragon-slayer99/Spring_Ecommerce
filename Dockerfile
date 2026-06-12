# Build the WAR file
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

# Run the WAR file in tomcat server
FROM tomcat:10.1-jdk21-temurin

RUN rm -f /usr/local/tomcat/webapps/*

COPY --from=build /app/target/spring_ecommerce.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD [ "catalina.sh", "run" ]
