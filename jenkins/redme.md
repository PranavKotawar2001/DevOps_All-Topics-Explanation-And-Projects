# Jenkins Basics – Complete Guide

## 1. What is Jenkins?
Jenkins is an **open-source automation server** used to automate the process of building, testing, and deploying software applications.  
It is one of the most widely used tools for implementing **CI/CD (Continuous Integration and Continuous Delivery/Deployment)**.

Jenkins helps teams deliver software **faster, reliably, and with fewer errors** by automating repetitive tasks.

---

## 2. Why Jenkins is Used
Jenkins is used to:
- Automate software builds and testing
- Enable Continuous Integration and Continuous Delivery
- Reduce manual errors and human intervention
- Integrate with tools like Git, Docker, Kubernetes, AWS, SonarQube
- Support DevOps culture and faster releases

### Key Benefits
- Open-source and free
- Large plugin ecosystem
- Easy to set up and extend
- Strong community support
- Scales from small projects to enterprise systems

---

## 3. CI vs CD vs CI/CD

### Continuous Integration (CI)
- Developers frequently push code to a shared repository
- Jenkins automatically builds and tests the code
- Helps detect issues early

**Example:**  
Every Git push triggers a build and unit tests.

---

### Continuous Delivery (CD)
- Code is automatically built, tested, and prepared for release
- Deployment to production requires **manual approval**

**Example:**  
Application is deployed to staging automatically, production after approval.

---

### Continuous Deployment
- Every successful build is **automatically deployed to production**
- No manual intervention

**Example:**  
Code → Build → Test → Deploy to Production automatically.

---

### CI/CD
CI/CD combines all the above into a **fully automated software delivery pipeline**.

---

## 4. Jenkins Use Cases
- Automating build and test pipelines
- Deploying applications to servers or Kubernetes
- Running scheduled jobs (cron jobs)
- Infrastructure automation
- Static code analysis with SonarQube
- Docker image building and pushing
- Zero-downtime deployments

---

## 5. Jenkins Architecture Overview

Jenkins follows a **Controller-Agent (Master-Slave)** architecture.

### Main Components
- Jenkins Controller (Master)
- Jenkins Agents (Slaves)
- Plugins
- Jobs/Pipelines

---

## 6. Jenkins Master / Agent Concept

### Jenkins Controller (Master)
Responsible for:
- Managing jobs and pipelines
- Scheduling builds
- Managing plugins
- Storing configuration
- Providing Jenkins UI

### Jenkins Agent (Slave)
Responsible for:
- Executing build tasks
- Running jobs assigned by controller
- Providing scalability

### Why Agents Are Needed
- Distribute workload
- Run builds on different OS (Linux, Windows)
- Improve performance
- Enable parallel builds

---

## 7. Jenkins Installation

### A. Jenkins Installation on Linux (Ubuntu)

```bash
sudo apt update
sudo apt install openjdk-17-jdk -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

### A. Jenkins Installation on Docker (Ubuntu)
```bash
docker run -d \
  -p 8080:8080 \
  -p 50000:50000 \
  --name jenkins \
  jenkins/jenkins:lts
```

### Jenkins Initial Setup & Configuration
Step-by-Step Setup
1. Access Jenkins UI at http://localhost:8080
2. Unlock Jenkins using initial admin password:
3. hit this path in server cat /var/lib/jenkins/secrets/initialAdminPassword
4. Install suggested plugins
5. Create admin user
6. Configure Jenkins URL

## Home directory of jenkins
- **/var/lib/jenkins**

### Jenkins Home Directory in Docker
When Jenkins runs inside Docker:
/var/jenkins_home

### Important Subdirectories inside /var/lib/jenkins
/var/lib/jenkins
│
├── config.xml            # Global Jenkins configuration
├── jobs/                 # All Jenkins jobs & pipelines
│   └── job-name/
│       └── config.xml
│
├── workspace/            # Job workspaces (source code)
├── plugins/              # Installed Jenkins plugins
├── users/                # Jenkins users
├── secrets/              # Encryption keys & secrets
├── credentials.xml       # Stored credentials
├── nodes/                # Agent (slave) configurations
├── logs/                 # Jenkins logs
└── updates/              # Plugin update metadata


### Jenkins Dashboard Overview
Main Sections of Jenkins Dashboard
New Item – Create jobs/pipelines
Manage Jenkins – Configuration, plugins, security
Build History – Past job executions
Credentials – Secure secrets storage
Nodes & Clouds – Manage agents
System Logs – Debugging and troubleshooting

### Key UI Features
Job status indicators (green, red, yellow)
Console output for debugging
Build parameters and triggers
Real-time logs

# Jenkins Architecture – Complete Guide

## 1. Overview of Jenkins Architecture
Jenkins follows a **Controller–Agent (Master–Slave)** architecture that allows build and deployment tasks to be distributed across multiple machines.

This architecture helps Jenkins:
- Scale horizontally
- Run builds in parallel
- Support multiple environments (Linux, Windows, Docker, Kubernetes)
- Improve performance and reliability

---

## 2. Jenkins Controller (Master)

### What is Jenkins Controller?
The Jenkins Controller (formerly called Master) is the **central component** responsible for managing and coordinating all Jenkins operations.

### Responsibilities of Jenkins Controller
- Provides Jenkins Web UI
- Manages jobs, pipelines, and configurations
- Schedules builds on agents
- Maintains build history and logs
- Manages plugins
- Handles credentials and security
- Communicates with Jenkins agents

⚠️ **Best Practice:**  
The controller should NOT run heavy build tasks to avoid performance issues.

---

## 3. Jenkins Agent (Slave)

### What is a Jenkins Agent?
A Jenkins Agent is a machine or container that **executes build tasks** assigned by the controller.

### Responsibilities of Jenkins Agent
- Runs build steps (compile, test, package, deploy)
- Reports build results back to the controller
- Can run on different OS or environments

### Why Agents are Needed
- Parallel execution of jobs
- Reduced load on controller
- Environment-specific builds
- Faster CI/CD pipelines

---

## 4. Static Agents

### What are Static Agents?
Static agents are **permanently configured machines** that are always available for Jenkins to run jobs.

### Characteristics
- Manually provisioned
- Long-running
- Fixed configuration
- Always online

### Use Cases
- Legacy applications
- Dedicated build servers
- On-premise environments

### Example
- A Linux VM added as a Jenkins agent via SSH

---

## 5. Dynamic Agents

### What are Dynamic Agents?
Dynamic agents are **created on-demand** and destroyed after job completion.

### Characteristics
- Provisioned automatically
- Short-lived
- Cost-efficient
- Highly scalable

### Technologies Used
- Docker
- Kubernetes
- Cloud providers (AWS EC2, Azure VM)

### Use Cases
- Cloud-native CI/CD
- Microservices builds
- High-frequency pipelines

---

## 6. Agent Communication

### How Controller Communicates with Agents
Jenkins supports multiple communication methods:

- **SSH**
- **JNLP (Java Web Start)**
- **Docker/Kubernetes APIs**

### Communication Flow
1. Controller assigns a job
2. Agent executes the job
3. Agent sends logs and status back
4. Controller updates build status in UI

All communication is secured using credentials and tokens.

---

## 7. Distributed Builds

### What are Distributed Builds?
Distributed builds allow Jenkins to **run jobs across multiple agents simultaneously**.

### Benefits
- Faster execution
- Parallel testing
- Improved resource utilization
- Supports large-scale applications

### Example
- Frontend build on one agent
- Backend build on another agent
- Testing on a separate agent

---

## 8. Jenkins Scaling Concepts

### Vertical Scaling
- Increase CPU/RAM of controller
- Simple but limited
- Not recommended for large workloads

### Horizontal Scaling
- Add more agents
- Run builds in parallel
- Best practice for production Jenkins

---

### Cloud-Based Scaling
- Auto-scale agents based on demand
- Use Kubernetes or cloud providers
- Pay only for used resources

---

## 9. Best Practices for Jenkins Architecture
- Keep controller lightweight
- Use agents for all build tasks
- Prefer dynamic agents
- Secure agent communication
- Monitor Jenkins performance
- Regularly clean old builds and logs

---

## 10. Summary
Jenkins architecture enables:
- High scalability
- Reliable CI/CD pipelines
- Distributed and parallel builds
- Support for modern DevOps tools

Understanding Jenkins architecture is **critical for DevOps interviews and real-world projects**.

---

✅ **Next Topics**
- Jenkins Jobs & Pipelines
- Jenkinsfile
- Jenkins with Docker & Kubernetes
- Jenkins Security & Best Practices

---

# Jenkins Jobs / Projects – Complete Guide

## 1. What are Jenkins Jobs / Projects?
A Jenkins Job (also called a Project) is a **configured task** that Jenkins executes to perform actions such as:
- Building code
- Running tests
- Creating artifacts
- Deploying applications

Jobs define **what to run, when to run, and how to run**.

---

## 2. Freestyle Jobs

### What is a Freestyle Job?
A Freestyle job is the **simplest and most basic job type** in Jenkins.

### Features
- UI-based configuration
- Easy to set up
- Good for beginners
- Limited flexibility

### Common Use Cases
- Simple builds
- Running shell scripts
- Testing small projects

### Example
```bash
echo "Building application"
mvn clean install
```
### Limitations
Hard to version control
Not ideal for complex pipelines
Less reusable

### 3. Pipeline Jobs
What is a Pipeline Job?
A Pipeline job defines the entire CI/CD process as code using a Jenkinsfile.

Key Benefits
Pipeline as Code
Version controlled
Supports complex workflows
Easy rollback and auditing

**Example (Declarative Pipeline)**
groovy
```bash
pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        echo 'Building...'
      }
    }
  }
}
```
Use Cases
Modern CI/CD pipelines
Microservices
Cloud-native applications

### 4. Multibranch Pipeline
**What is a Multibranch Pipeline?**
A Multibranch Pipeline automatically creates pipelines for each branch in a repository.

### How It Works
Scans repository branches
Looks for Jenkinsfile
Creates jobs per branch automatically

### Benefits
**Supports Git workflows**
Ideal for feature branches
Automatic PR builds

**Example**
main → production pipeline
dev → staging pipeline
feature/* → test pipelines

### 5. Folder Jobs
**/What are Folder Jobs?**
Folders are used to organize Jenkins jobs into logical groups.

**Benefits**
Clean dashboard
Access control per folder
Easier job management

**Example Structure**
text
Copy code
📁 CI-Jobs
 ├── Backend
 ├── Frontend
 └── Database


# Jenkins Pipelines – Complete Guide (🔥 Most Important)

## 1. What is Jenkins Pipeline?
A Jenkins Pipeline is a **suite of plugins** that allows you to define your entire **CI/CD workflow as code**.

Pipelines describe:
- How code is built
- How it is tested
- How it is deployed

Pipelines are written using **Groovy-based syntax** and stored in a **Jenkinsfile**.

### Benefits
- Pipeline as Code
- Version controlled
- Repeatable and reliable
- Supports complex CI/CD workflows
- Easier troubleshooting and rollback

---

## 2. Types of Jenkins Pipelines

### A. Declarative Pipeline (Recommended ✅)

Declarative pipeline uses a **structured, readable syntax** and enforces best practices.

#### Features
- Easy to read and maintain
- Built-in error handling
- Ideal for most use cases

#### Example
```groovy
pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        echo 'Building application'
      }
    }
  }
```
**B. Scripted Pipeline**
Scripted pipeline uses pure Groovy syntax and offers maximum flexibility.

Features
Highly customizable

Complex logic supported

Harder to read and maintain

Example
```groovy
node {
  stage('Build') {
    echo 'Building application'
  }
}
```
Declarative vs Scripted Pipeline
Feature	Declarative	Scripted
Ease of use	High	Medium
Flexibility	Medium	High
Best practice	Yes	No
Recommended	✅	⚠️

### 3. Pipeline Syntax (Basic Structure)
```groovy
pipeline {
  agent any

  stages {
    stage('Stage Name') {
      steps {
        // build steps
      }
    }
  }
}
```
Key Blocks
pipeline – Root block
agent – Where pipeline runs
stages – Collection of stages
stage – Logical step
steps – Commands executed

### 4. Pipeline Stages
What are Stages?
Stages divide the pipeline into logical units.

Common Stages
Checkout
Build
Test
Scan
Deploy

Example
```groovy
stage('Test') {
  steps {
    sh 'mvn test'
  }
}
```

### 5. Pipeline Steps
What are Steps?
Steps are individual actions executed within a stage.

Common Steps
sh
echo
checkout
script

Example
```groovy
steps {
  sh 'docker build -t app .'
}
```

### 6. Parallel Stages
What are Parallel Stages?
Parallel stages allow multiple stages to run simultaneously, reducing pipeline execution time.

Example
```groovy
stage('Testing') {
  parallel {
    stage('Unit Test') {
      steps {
        echo 'Running unit tests'
      }
    }
    stage('Integration Test') {
      steps {
        echo 'Running integration tests'
      }
    }
  }
}
```

### 7. Conditional Execution
What is Conditional Execution?
Conditions allow stages to run only when certain conditions are met.

Common Conditions
Branch name

Environment

Build status

Example
```groovy
when {
  branch 'main'
}
```

### 8. Retry & Timeout
Retry
Automatically retries a failed step.

```groovy
retry(3) {
  sh 'npm install'
}
```
Timeout
Stops a step if it exceeds a time limit.

```groovy
timeout(time: 5, unit: 'MINUTES') {
  sh 'mvn test'
}
```

### 9. Post Conditions
What are Post Conditions?
Post blocks define actions to run after pipeline execution.

Types
success
failure
always

Example
```groovy
post {
  success {
    echo 'Build successful'
  }
  failure {
    echo 'Build failed'
  }
  always {
    echo 'Cleaning workspace'
  }
}
```
### 10. Shared Libraries
What are Shared Libraries?
Shared libraries allow reuse of common pipeline code across multiple Jenkins pipelines.

Benefits
Reusable logic
Cleaner Jenkinsfiles
Standardized pipelines

Structure
text
(vars/)
  build.groovy
(src/)
  org/company/utils.groovy
Usage
```groovy
@Library('my-shared-lib') _
build()
```


##  Jenkins Plugins

Plugin architecture
Plugin installation

Popular plugins:
Git
GitHub
Pipeline
Docker
Kubernetes
SonarQube
Email Extension
Credentials Binding
Plugin management best practices