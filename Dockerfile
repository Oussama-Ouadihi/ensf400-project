# Stage 1: Build the application using the Gradle Wrapper
FROM gradle:7.5-jdk11 AS builder
WORKDIR /home/gradle/project
COPY --chown=gradle:gradle . .
# Build the project and show what files are actually created
RUN ./gradlew clean build --no-daemon && \
    echo "Listing files in build/libs directory:" && \
    ls -la build/libs/

# Stage 2: Create a Tomcat server with our application
FROM tomcat:9-jre11-slim
# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy the WAR file to Tomcat's webapps directory as ROOT.war
COPY --from=builder /home/gradle/project/build/libs/*.war /usr/local/tomcat/webapps/demo.war
# Expose the default Tomcat port
EXPOSE 8080
# Start Tomcat
CMD ["catalina.sh", "run"]