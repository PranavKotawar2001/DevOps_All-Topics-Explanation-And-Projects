# Docker Complete Guide (README.md)

## Docker Introduction

Docker is a tool that packages an application along with everything it needs to run—such as code, libraries, settings, and dependencies—into a single unit called a **container**.

---

## In Simple Words

Docker is like a **portable box for software**.
Inside the box, everything the application needs is already present.
You just open the box and run the app—**no setup headache**.

---

## What is a Container?

A container is a **lightweight, isolated environment** that runs an application along with all its dependencies.

---

## Monolithic vs Microservices

### Monolithic Architecture

Monolithic architecture is a software design where the entire application is built, deployed, and run as a **single unit**, with all features and components tightly coupled together.

### Microservices Architecture

Microservices architecture is a software design where an application is divided into **small, independent services**, each responsible for a specific business function and communicating with other services through APIs.

---

## Containerization vs Virtualization

### Containerization

Containerization is a lightweight technology that packages an application along with its dependencies and runs it in an isolated container while **sharing the host OS kernel**.

### Virtualization

Virtualization is a technology that creates **virtual machines (VMs)**, where each VM runs a complete operating system on virtualized hardware provided by a hypervisor.

---

## Dockerfile

A Dockerfile is a text file that contains **step-by-step instructions** to build a Docker image.

It tells Docker:

* Which base OS to use
* What software to install
* How to run the application

---

## Basic Dockerfile Example

```dockerfile
FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install -y nginx
CMD ["nginx", "-g", "daemon off;"]
```

### Explanation

* **FROM** → Base image
* **RUN** → Install software
* **CMD** → Start application

---

## Dockerfile Instructions

Dockerfile instructions define how an image is built, configured, and executed in a container.

### 1. FROM

**Definition:** Specifies the base image for the Docker image.

**Example:**

```dockerfile
FROM ubuntu:20.04
```

---

### 2. RUN

**Definition:** Executes commands during image build time.

**Example:**

```dockerfile
RUN apt-get update && apt-get install -y nginx
```

---

### 3. CMD

**Definition:** Provides the default command to run when a container starts.

**Example:**

```dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

---

### 4. ENTRYPOINT

**Definition:** Defines the main command that always runs when the container starts.

**Example:**

```dockerfile
ENTRYPOINT ["python", "app.py"]
```

---

### 5. COPY

**Definition:** Copies files or folders from the local system into the image.

**Example:**

```dockerfile
COPY app/ /usr/src/app/
```

---

### 6. ADD

**Definition:** Copies files, supports URLs, and auto-extracts archives.

**Example:**

```dockerfile
ADD app.tar.gz /app/
```

---

### 7. WORKDIR

**Definition:** Sets the working directory inside the container.

**Example:**

```dockerfile
WORKDIR /app
```

---

### 8. EXPOSE

**Definition:** Declares the port the container listens on.

**Example:**

```dockerfile
EXPOSE 8080
```

---

### 9. ENV

**Definition:** Sets environment variables.

**Example:**

```dockerfile
ENV APP_ENV=production
```

---

### 10. ARG

**Definition:** Defines variables available only at build time.

**Example:**

```dockerfile
ARG VERSION=1.0
```

---

## Recommended Dockerfile Instruction Order

1. FROM
2. LABEL
3. ENV / ARG
4. WORKDIR
5. COPY / ADD
6. RUN
7. EXPOSE
8. USER
9. CMD / ENTRYPOINT

---

## Multi-Stage Dockerfile

A **multi-stage Dockerfile** uses multiple `FROM` instructions to create images in stages, resulting in **smaller and more secure images**.

### Example: Multi-Stage Dockerfile

```dockerfile
# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/myapp.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

---

## Docker Basic Commands

### Image Commands

* `docker images` – List images
* `docker pull <image>` – Download image
* `docker build -t <name> .` – Build image
* `docker rmi <image-id>` – Remove image
* `docker image prune` – Remove unused images

---

### Container Commands

* `docker ps` – Running containers
* `docker ps -a` – All containers
* `docker run <image>` – Run container
* `docker run -d <image>` – Detached mode
* `docker run -it <image> /bin/bash` – Interactive mode
* `docker start <id>` – Start container
* `docker stop <id>` – Stop container
* `docker restart <id>` – Restart container
* `docker rm <id>` – Remove container
* `docker container prune` – Remove stopped containers

---

## Logs & Monitoring

* `docker logs <id>` – View logs
* `docker logs -f <id>` – Follow logs
* `docker stats` – Resource usage
* `docker top <id>` – Running processes

---

## Docker Networking

Docker networking allows containers to communicate with each other and external systems.

### Network Commands

* `docker network ls`
* `docker network create <name>`
* `docker network inspect <name>`
* `docker network rm <name>`

---

## Docker Volumes

Docker volumes are used to **persist data** even after containers are deleted.

### Volume Commands

* `docker volume ls`
* `docker volume create <name>`
* `docker volume inspect <name>`
* `docker volume rm <name>`
* `docker volume prune`

---

## Docker System Cleanup

* `docker system df` – Disk usage
* `docker system prune` – Remove unused objects
* `docker system prune -a` – Remove everything unused

---



## Docker Hub

Docker Hub is a **cloud-based registry service** provided by Docker that allows you to **store, share, and manage Docker images**.

### Why Docker Hub is Important

* Acts as a **central repository** for Docker images
* Makes application images **easy to share and deploy**
* Integrates smoothly with **CI/CD pipelines**
* Supports **public and private repositories**

### Common Docker Hub Concepts

* **Repository**: A collection of Docker images
* **Image**: A packaged application with dependencies
* **Tag**: A version or label for an image (e.g., `latest`, `v1.0`)

### Docker Hub Workflow

1. Build a Docker image locally
2. Tag the image with Docker Hub repository name
3. Login to Docker Hub
4. Push the image to Docker Hub
5. Pull and run the image anywhere

### Example: Push Image to Docker Hub

```bash
docker build -t myapp .
docker tag myapp username/myapp:v1
docker login
docker push username/myapp:v1
```

### Example: Pull Image from Docker Hub

```bash
docker pull username/myapp:v1
docker run -d username/myapp:v1
```

---
## Docker Tag & Push

* `docker tag <image> <repo:tag>` -Tags an image
* `docker push <image>` -Uploads image to Docker Hub
* `docker login` -Login to Docker Hub

---

## Docker Compose

Docker Compose is used to define and run **multi-container applications** using a single YAML file.

### Docker Compose Commands

* `docker-compose up` -Starts services defined in docker-compose.yml
* `docker-compose up -d` -Runs services in background
* `docker-compose down` -Stops and removes services
* `docker-compose ps` -Lists running services