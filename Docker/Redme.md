<!-- Docker Introduction -->
Docker is a tool that packs an application along with everything it needs to run.
like code, libraries, settings, and dependencies—into a single unit called a container.

# In simple words
Docker is like a portable box for software.
Inside the box, everything the app needs is already present.
You just open the box and run the app—no setup headache.

# What is a Container?
A container is a lightweight box that runs an application along with everything it needs to work.

<!-- monolathivc vs microservices -->
monolathivc :- 
Monolithic architecture is a software design where the entire application is built, deployed, and run as a single unit, with all features and components tightly coupled together

microservices:-
Microservices architecture is a software design where an application is divided into small, independent services, each responsible for a specific business function and communicating with other services through APIs.Microservices architecture is a software design where an application is divided into small, independent services, each responsible for a specific business function and communicating with other services through APIs.

<!-- Containerization vs Virtualization -->

Containerization:- 
Containerization is a lightweight technology that packages an application along with its dependencies and runs it in an isolated container while sharing the host operating system kernel.

Virtualization :-
Virtualization is a technology that creates virtual machines (VMs), where each VM runs a complete operating system on virtualized hardware provided by a hypervisor.


<!-- Docker File -->

A Dockerfile is a text file that contains step-by-step instructions to build a Docker image.

It tells Docker:

Which base OS to use

What software to install

How to run the application

# Basic Dockerfile Example

FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install -y nginx
CMD ["nginx", "-g", "daemon off;"]

Explanation:

FROM → Base image

RUN → Install software

CMD → Start application

# Docker instructions
Dockerfile instructions define how an image is built, configured, and executed in a container.

1️⃣ FROM

Definition:
Specifies the base image for the Docker image.

Explanation:
Every Docker image starts from another image (OS or runtime).
This must be the first instruction in a Dockerfile.

Example:

FROM ubuntu:20.04

2️⃣ RUN

Definition:
Executes commands during image build time.

Explanation:
Used to install software, update packages, or configure the image.

Example:

RUN apt-get update && apt-get install -y nginx

3️⃣ CMD

Definition:
Provides the default command to run when a container starts.

Explanation:
This command can be overridden while running the container.

Example:

CMD ["nginx", "-g", "daemon off;"]

4️⃣ ENTRYPOINT

Definition:
Defines the main command that always runs when the container starts.

Explanation:
Used when the container should behave like an executable.

Example:

ENTRYPOINT ["python", "app.py"]

5️⃣ COPY

Definition:
Copies files or folders from the local system into the image.

Explanation:
Preferred over ADD for simple file copying.

Example:

COPY app/ /usr/src/app/

6️⃣ ADD

Definition:
Copies files, supports URLs, and auto-extracts archives.

Explanation:
More powerful than COPY, but less recommended due to extra features.

Example:

ADD app.tar.gz /app/

7️⃣ WORKDIR

Definition:
Sets the working directory inside the container.

Explanation:
All subsequent commands run from this directory.

Example:

WORKDIR /app

8️⃣ EXPOSE

Definition:
Declares the port the container listens on.

Explanation:
Used for documentation and container communication.

Example:

EXPOSE 8080

9️⃣ ENV

Definition:
Sets environment variables.

Explanation:
Used for configuration values like DB URLs, ports, etc.

Example:

ENV APP_ENV=production

🔟 ARG

Definition:
Defines variables available only at build time.

Explanation:
Used for passing values during docker build.

Example:

ARG VERSION=1.0

# Step by step orderod instruction
1. FROM
2. LABEL
3. ENV / ARG
4. WORKDIR
5. COPY / ADD
6. RUN
7. EXPOSE
8. USER
9. CMD / ENTRYPOINT 

# Multi-stagr Dockerfile

A multi-stage Dockerfile is a Dockerfile that uses multiple FROM instructions to create images in stages.

# Example of Multi-Stage Docker file

 ---------- Stage 1: Build ----------
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn package -DskipTests

 ---------- Stage 2: Run ----------
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/target/myapp.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]


<!-- Docker Commands -->

# Besic commands

1. docker images
Definition: Lists all Docker images
Explanation: Shows image name, tag, ID, size.

2. docker pull <image-name>

Definition: Downloads an image from Docker Hub
Explanation: Fetches image without running it.

Example:
docker pull nginx

3. docker build -t <image-name> .

Definition: Builds a Docker image from Dockerfile
Explanation: Converts Dockerfile into an image.

4. docker rmi <image-id>

Definition: Removes a Docker image
Explanation: Deletes unused or unwanted images.

5. docker image prune

Definition: Removes unused images
Explanation: Cleans disk space.

# Container Commands

1. docker ps

Definition: Lists running containers
Explanation: Shows active containers only.

2. docker ps -a

Definition: Lists all containers
Explanation: Shows running + stopped containers.

3. docker run <image-name>

Definition: Creates and starts a container
Explanation: Downloads image (if not present) and runs it.

4. docker run -d <image-name>

Definition: Runs container in detached mode
Explanation: Runs container in background.

5. docker run -it <image-name> /bin/bash

Definition: Runs container in interactive mode
Explanation: Gives terminal access inside container.

6. docker start <container-id>

Definition: Starts a stopped container
Explanation: Re-runs existing container.

7. docker stop <container-id>

Definition: Stops a running container
Explanation: Gracefully shuts down container.

8. docker restart <container-id>

Definition: Restarts a container
Explanation: Stops and starts container again.

9. docker rm <container-id>

Definition: Deletes a container
Explanation: Removes stopped container permanently.

10. docker container prune

Definition: Removes all stopped containers
Explanation: Frees disk space.

# Docker Logs & Monitoring Commands

1. docker logs <container-id>

Definition: Shows container logs
Explanation: Useful for debugging errors.

2. docker logs -f <container-id>

Definition: Streams container logs
Explanation: Live log monitoring.

3. docker stats

Definition: Shows real-time container resource usage
Explanation: CPU, memory, network usage.

4. docker top <container-id>

Definition: Displays running processes inside container
Explanation: Similar to Linux top.

# Docker Exec Commands

1. docker exec <container-id> <command>

Definition: Runs a command inside a running container
Explanation: Executes commands without stopping container.

2. docker exec -it <container-id> /bin/bash

Definition: Access container terminal
Explanation: Used for troubleshooting.

<!-- Docker Networking -->

# Docker Networking

Docker networking is a feature that allows Docker containers to communicate with each other, the host system, and external networks in a secure and isolated manner.

# Docker Network Commands

1. docker network ls

Definition: Lists Docker networks
Explanation: Shows available networks.

2. docker network create <network-name>

Definition: Creates a new network
Explanation: Used for container communication.

3. docker network inspect <network-name>

Definition: Shows network details
Explanation: IP range, connected containers.

4. docker network rm <network-name>

Definition: Deletes a Docker network
Explanation: Removes unused networks.

<!-- Docker Volume  -->

# Docker Volume 
A Docker volume is a storage mechanism used to persist data generated by containers, even after the container is stopped or deleted.

# Docker Volume Commands

1. docker volume ls

Definition: Lists Docker volumes
Explanation: Shows persistent storage.

2. docker volume create <volume-name>

Definition: Creates a volume
Explanation: Used for data persistence.

3. docker volume inspect <volume-name>

Definition: Shows volume details
Explanation: Location and usage info.

4. docker volume rm <volume-name>

Definition: Deletes a volume
Explanation: Removes stored data.

5. docker volume prune

Definition: Removes unused volumes
Explanation: Cleans storage.

# Docker System Cleanup

1. docker system df

Definition: Shows Docker disk usage
Explanation: Images, containers, volumes size.

2. docker system prune

Definition: Cleans unused Docker objects
Explanation: Removes stopped containers, networks, cache.

3. docker system prune -a

Definition: Removes everything unused
Explanation: Deletes all unused images & containers.

# Docker Tag & Push Commands

1. docker tag <image> <repo:tag>

Definition: Tags an image
Explanation: Prepares image for push.

2. docker push <image-name>

Definition: Uploads image to Docker Hub
Explanation: Used for sharing images.

3. docker login

Definition: Login to Docker Hub
Explanation: Required before pushing images.

# Docker Compose

Docker Compose is a tool used to define and run multi-container Docker applications using a single YAML configuration file.

# Docker Compose command (Important)

1. docker-compose up

Definition: Starts services defined in docker-compose.yml
Explanation: Runs multi-container apps.

2. docker-compose up -d

Definition: Runs services in background
Explanation: Detached mode.

3. docker-compose down

Definition: Stops and removes services
Explanation: Shuts down app stack.

4. docker-compose ps

Definition: Lists running services
Explanation: Shows service status.