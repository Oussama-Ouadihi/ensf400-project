# ENSF 400 Project: Containerizing Java Web Application

This project's first check-in involves containerizing a Java web application using Docker. The application is built using Gradle and the WAR file is deployed to a Tomcat server. The containerized application is then pushed to Docker Hub for easy deployment.

## Project Overview

### Key Tasks:
- **Dockerfile creation**: Creating a multi-stage Dockerfile to build and containerize the application.
- **Use of Gradle**: The project is built using Gradle, and the Gradle wrapper is used to build the application inside a Docker container.
- **Containerization**: The application is containerized with a multi-stage Docker build, and a Tomcat server is used to run the application.
- **Docker Hub**: The image is pushed to Docker Hub with a unique tag corresponding to the commit hash.

## Steps Performed

### 1. Creating the Dockerfile

We created a **multi-stage Dockerfile** to achieve the following:

1. **Stage 1**: Build the application using the Gradle wrapper.
    - **Base Image**: `gradle:7.5-jdk11` was used as the base image to provide the necessary Gradle version and JDK 11.
    - **Build Command**: We used the `./gradlew clean build --no-daemon` command to clean and build the project.
    - **File Copying**: The entire project was copied into the container for building.

2. **Stage 2**: Create a Tomcat server to host the application.
    - **Base Image**: `tomcat:9-jre11-slim` was used to provide a lightweight Tomcat server with JDK 11 support.
    - **WAR Deployment**: The generated WAR file from the build stage was copied to the Tomcat `webapps` directory.
    - **Expose Port**: Port 8080 was exposed for the application.
    - **Start Command**: The Tomcat server was started with `catalina.sh run`.

