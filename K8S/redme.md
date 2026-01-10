# What is Kubernetes (K8S)
Kubernetes (also called K8s) is a tool that automatically manages, runs, and scales containerized applications.

Simple definition:

Kubernetes is like a manager for Docker containers that makes sure your application is always running, healthy, and available—even when traffic increases or servers fail.

# Architecture of Kubernetes

          ┌───────────────────────┐
          │      Control Plane    │
          │-----------------------│
          │  API Server           │
          │  etcd                 │
          │  Scheduler            │
          │  Controller Manager   │
          └─────────┬─────────────┘
                    │
         ┌──────────┴───────────┐
         │                      │
   ┌─────────────┐       ┌─────────────┐
   │  Worker Node│       │ Worker Node │
   │-------------│       │-------------│
   │ kubelet     │       │ kubelet     │
   │ kube-proxy  │       │ kube-proxy  │
   │ Container   │       │ Container   │
   │ Runtime     │       │ Runtime     │
   └─────────────┘       └─────────────┘

# Explination

# Kubernetes Architecture

## 1. Control Plane (Master)

The control plane manages the cluster, making decisions about scheduling, scaling, and maintaining the desired state.

### Components of Control Plane:

**API Server (`kube-apiserver`)**

- Entry point for all commands (kubectl requests go here).
- Validates and configures data for objects like pods, services, deployments.

**etcd**

- A key-value database that stores all cluster data (state, configurations).
- Very important: if etcd is lost, cluster state is lost.

**Controller Manager**

- Runs controllers that maintain the desired state.
- Examples: Node Controller, Replication Controller.

**Scheduler**

- Decides which node will run a pod based on resources, constraints, and policies.

---

## 2. Worker Nodes

Worker nodes are where your containers actually run. Each node has its own components:

### Components of a Worker Node:

**kubelet**

- An agent that communicates with the control plane.
- Ensures containers in pods are running as expected.

**kube-proxy**

- Manages networking and load balancing inside the cluster.
- Ensures pods can communicate with each other and with external clients.

**Container Runtime**

- Software that runs containers (like Docker, containerd, or CRI-O).


# Kubernetes vs Docker

Kubernetes and Docker are often mentioned together, but they serve different purposes in container management.

## 1. Docker

- Docker is a **containerization platform**.
- It allows you to **package an application and its dependencies** into a container.
- Focused on **building, shipping, and running containers**.
- Manages containers on a **single host**.
- Docker alone **does not handle scaling or orchestration**.

## 2. Kubernetes (K8s)

- Kubernetes is a **container orchestration platform**.
- It manages **multiple containers across multiple hosts**.
- Handles **deployment, scaling, and management** of containerized applications.
- Provides **self-healing, load balancing, and rolling updates**.
- Works with **Docker or other container runtimes**.

## 3. Key Differences

| Feature                  | Docker                          | Kubernetes                           |
|--------------------------|---------------------------------|--------------------------------------|
| Purpose                  | Containerization                | Container orchestration              |
| Scale                    | Single host                     | Multi-node cluster                   |
| Management               | Manual or Docker Compose        | Automated via control plane          |
| Load Balancing           | Not built-in                    | Built-in                             |
| Self-Healing             | No                              | Yes                                  |
| Deployment Strategy      | Manual                          | Automated, declarative               |
| Container Runtime        | Docker engine                   | Works with Docker, containerd, CRI-O |

**In short:** Docker **creates containers**, Kubernetes **runs and manages containers at scale**.


# Kubernetes Objects

Kubernetes objects are **persistent entities in the cluster** that represent the desired state of your applications.

## 1. Pod

- **Definition:** The smallest deployable unit in Kubernetes; represents one or more containers running together on a node.
- **Example:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: nginx-container
    image: nginx:latest
```

## 2. ReplicaSet

- **Definition:**  Ensures that a specified number of pod replicas are running at any time.

- **Example:**

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: my-replicaset
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest

```

## 3. Deployment

- **Definition:**  Manages ReplicaSets and provides declarative updates, rollbacks, and scaling.

- **Example:**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest

```

## 4. StatefulSet

- **Definition:**  Manages stateful applications that require stable network IDs and persistent storage.
- **Example:**

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: my-statefulset
spec:
  serviceName: "nginx"
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
  volumeClaimTemplates:
  - metadata:
      name: nginx-storage
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 1Gi

```


## 5. DaemonSet

- **Definition:**  Ensures that a copy of a pod runs on all or selected nodes.

- **Example:**

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: my-daemonset
spec:
  selector:
    matchLabels:
      app: fluentd
  template:
    metadata:
      labels:
        app: fluentd
    spec:
      containers:
      - name: fluentd
        image: fluent/fluentd:latest


```

## 6. CronJob

- **Definition:**  Runs Jobs on a scheduled time (like Linux cron).
- **Example:**

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: my-cronjob
spec:
  schedule: "0 0 * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hello
            image: busybox
            args:
            - /bin/sh
            - -c
            - date; echo Hello from CronJob
          restartPolicy: OnFailure
```

# 🌐 Kubernetes Networking Concepts

Networking is a critical part of Kubernetes. It ensures **communication between pods, services, and external clients**.

## 1. Pod-to-Pod Communication

- Pods can communicate with each other across nodes using **IP addresses**.
- Kubernetes provides a **flat network** where every pod gets a unique IP.

## 2. Service

- A Service **exposes pods** and provides **stable IPs and DNS names**.
- Enables **load balancing** across pods.

### Service Types:

**ClusterIP**  
- Default type.  
- Exposes the service **only within the cluster**.  

**NodePort**  
- Exposes the service on a **specific port on each node**.  
- Can be accessed externally via `<NodeIP>:<NodePort>`.

**LoadBalancer**  
- Exposes the service via a **cloud provider’s load balancer**.  
- External clients can access the service using the LB IP.

**ExternalName**  
- Maps a service to an **external DNS name**.  
- Does **not create a cluster IP**.

## 3. Ingress

- Ingress **manages external access** to services, usually via HTTP/HTTPS.
- Supports **routing, SSL termination, and name-based virtual hosting**.

## 4. Ingress Controller

- Implements the rules defined in Ingress objects.
- Examples: **NGINX Ingress Controller, Traefik**.

## 5. DNS in Kubernetes

- Kubernetes has a **built-in DNS service**.
- Every service gets a **DNS name**, e.g., `my-service.default.svc.cluster.local`.
- Pods can use **DNS names instead of IP addresses** for communication.

## 6. Network Policies

- Define **rules for pod communication**.
- Can **allow or block traffic** between pods based on labels and ports.

## 7. CNI Plugins (Container Network Interface)

- Provide **network connectivity to pods**.
- Popular CNI plugins:
  - **Calico** – Network policies and security.
  - **Flannel** – Simple overlay networking.
  - **Weave** – Secure overlay network with simplicity.


# 🗂️ Configuration & Secrets

Kubernetes provides ways to **store configuration and sensitive data** separately from container images, making applications more secure and flexible.

## 1. ConfigMap

- Stores **non-sensitive configuration data** as key-value pairs.
- Can be used to **configure applications without rebuilding images**.
- **Example:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
data:
  APP_COLOR: "blue"
  APP_MODE: "production"
```

## 2. Secret

- Stores sensitive information like passwords, tokens, and keys.
- Encoded in Base64 for storage (not fully encrypted).
- **Example:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
data:
  APP_COLOR: "blue"
  APP_MODE: "production"
```

## 3. Environment Variablest

- ConfigMaps and Secrets can be injected as environment variables into pods.
- Example usage in a pod:
- **Example:**
```yaml
env:
- name: APP_COLOR
  valueFrom:
    configMapKeyRef:
      name: my-config
      key: APP_COLOR
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: my-secret
      key: password
```

## 4. Volume Mounts

- ConfigMaps and Secrets can also be mounted as files inside pods using volumes.
- **Example:**
```yaml
volumes:
- name: config-volume
  configMap:
    name: my-config
containers:
- name: app
  image: nginx
  volumeMounts:
  - name: config-volume
    mountPath: /etc/config
```

# 💾 Storage Concepts in Kubernetes

Kubernetes provides a flexible way to **manage storage for containers**, ensuring data persists beyond the lifecycle of pods.

---

## 1. Volume

- A **directory accessible to containers in a pod**.
- Data persists **only as long as the pod exists** (except for special types like `emptyDir`, `hostPath`, etc.).
- **Example:**
```yaml
volumes:
- name: my-volume
  emptyDir: {}
containers:
- name: app
  image: nginx
  volumeMounts:
  - mountPath: /usr/share/nginx/html
    name: my-volume
```

## 2. PersistentVolume (PV)

- A cluster-wide resource that provides storage independent of pods.
- Can be backed by NFS, cloud storage (AWS EBS, GCP PD), or local storage.
- **Example:**
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-example
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: "/mnt/data"
```

## 3. PersistentVolumeClaim (PVC)

- A request for storage by a user.
- Pods use PVCs to bind to available PVs.
- **Example:**
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-example
spec:
  capacity:
    storage: 5Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: "/mnt/data"
```

## 4. StorageClass

- Defines different types of storage (fast, slow, SSD, HDD, etc.).
- Supports dynamic provisioning of PVs based on the class.
- **Example:**
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-storage
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
  fsType: ext4
reclaimPolicy: Retain
```

## 5. Dynamic Provisioning

- Allows automatic creation of PVs when PVCs are created.
- Eliminates the need for manual PV creation.
- Uses StorageClass to define the type of storage to provision

## 6. CSI (Container Storage Interface)

- A standard interface to expose storage systems to Kubernetes.
- Allows Kubernetes to use different storage vendors without vendor-specific code.
- Popular CSI drivers: AWS EBS CSI, GCP PD CSI, Ceph CSI.
- **Example:**
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: csi-storage
provisioner: ebs.csi.aws.com
parameters:
  type: gp2
  fsType: ext4
```


# 📈 Scaling & Availability in Kubernetes

Kubernetes provides multiple ways to **scale applications** and ensure **high availability** of workloads.

---

## 1. Manual Scaling

- You can **manually increase or decrease** the number of pod replicas using `kubectl scale`.
- **Example:**
```bash
kubectl scale deployment my-deployment --replicas=5

```

## 2. Horizontal Pod Autoscaler (HPA)

- Automatically scales the number of pod replicas based on CPU/memory usage or custom metrics.
- Ensures applications handle varying workloads.

- **Example:**
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: hpa-example
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: my-deployment
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
```

## 3. Vertical Pod Autoscaler (VPA)

- Automatically adjusts CPU and memory requests/limits of pods based on usage.
- Useful for workloads that cannot be scaled horizontally.

## 4. Cluster Autoscaler

- Automatically adjusts the number of nodes in the cluster based on pod resource requirements.
- Works with cloud providers like AWS, GCP, Azure.

## 5. Resource Requests

- ASpecify minimum resources (CPU/memory) a pod needs to run.
- Kubernetes uses this for scheduling decisions.
- **Example:**
```yaml
resources:
  requests:
    memory: "256Mi"
    cpu: "500m"
```

## 6. Resource Limits

- Specify maximum resources (CPU/memory) a pod can use.
- Prevents a pod from consuming excessive cluster resources.
- **Example:**
```yaml
resources:
  limits:
    memory: "512Mi"
    cpu: "1"
```

## 6. Resource Limits

- Defines the minimum number of pods that must remain available during voluntary disruptions (e.g., node maintenance, upgrades).
-  Ensures high availability of critical applications.
- **Example:**
```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: pdb-example
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: my-app
```