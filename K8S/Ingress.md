# Kubernetes Ingress and Ingress Controller

## 1. Introduction

When you run applications in Kubernetes, they usually run inside **pods**.  
Pods are inside the Kubernetes cluster network, which means users on the internet cannot access them directly.

To allow external users to access applications, Kubernetes provides multiple options like:

- ClusterIP
- NodePort
- LoadBalancer
- Ingress

Among these, **Ingress is the most flexible and production-friendly method** for exposing applications.

---

# 2. What is Ingress in Kubernetes?

**Ingress** is a Kubernetes object that manages **external HTTP and HTTPS access to services inside the cluster**.

In simple words:

👉 **Ingress acts like a smart traffic manager that routes internet requests to the correct service inside Kubernetes.**

Example:

User visits:

```
www.myapp.com
```

Ingress checks the request and sends it to the correct service.

---

## Simple Example

Imagine you have 2 applications running in Kubernetes:

| Application  | Service          | URL           |
| ------------ | ---------------- | ------------- |
| Frontend App | frontend-service | myapp.com     |
| Backend API  | backend-service  | api.myapp.com |

Ingress can route traffic like this:

```
Internet
   |
   v
Ingress
   |-------------> frontend-service
   |
   |-------------> backend-service
```

---

# 3. Why Do We Use Ingress?

Without Ingress:

You would need **separate LoadBalancers for every service**, which is expensive and difficult to manage.

With Ingress:

You can use **one entry point for multiple services**.

Benefits:

- Single public IP
- URL-based routing
- Domain-based routing
- SSL/TLS termination
- Centralized traffic management

---

# 4. What is an Ingress Controller?

Here is an important concept.

**Ingress itself is only a configuration object.**

It does not actually handle traffic.

To make Ingress work, Kubernetes needs something that can **read the Ingress rules and route the traffic accordingly**.

That component is called an **Ingress Controller**.

### Simple Definition

👉 **Ingress Controller is the actual program that processes Ingress rules and routes traffic to services.**

---

# 5. Simple Analogy

Think of it like a **hotel receptionist**.

| Component           | Example      |
| ------------------- | ------------ |
| Internet User       | Guest        |
| Ingress             | Guest list   |
| Ingress Controller  | Receptionist |
| Kubernetes Services | Hotel Rooms  |

Process:

1. Guest arrives
2. Receptionist checks guest list
3. Receptionist sends guest to correct room

Same in Kubernetes:

1. User sends request
2. Ingress Controller checks Ingress rules
3. Request goes to correct service

---

# 6. Popular Ingress Controllers

Some commonly used ingress controllers are:

- NGINX Ingress Controller
- AWS ALB Ingress Controller
- Traefik
- HAProxy
- Istio Gateway

Most beginners start with **NGINX Ingress Controller**.

---

# 7. Basic Ingress YAML Example

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myapp-ingress
spec:
  rules:
    - host: myapp.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: frontend-service
                port:
                  number: 80
```

This means:

When a user visits

```
http://myapp.com
```

Traffic goes to

```
frontend-service
```

---

# 8. Full Traffic Flow

```
User Request
     |
     v
Internet
     |
     v
Ingress Controller
     |
     v
Ingress Rules
     |
     v
Kubernetes Service
     |
     v
Pod
```

---

# 9. Difference Between Service and Ingress

| Feature        | Service                | Ingress                |
| -------------- | ---------------------- | ---------------------- |
| Purpose        | Expose pods internally | Manage external access |
| Layer          | Network                | HTTP/HTTPS             |
| Routing        | Simple                 | Advanced routing       |
| Domain support | No                     | Yes                    |

---

# 10. Real World Example

Company has multiple applications:

```
shop.company.com
api.company.com
admin.company.com
```

Instead of creating multiple load balancers, **one Ingress controller routes traffic to different services.**

---

# 11. Summary

**Ingress**

- Kubernetes resource
- Defines rules for external access
- Routes HTTP/HTTPS traffic to services

**Ingress Controller**

- Actual component that implements Ingress rules
- Watches Kubernetes API
- Routes traffic to services

---

# 12. Quick One Line Definitions

Ingress

> A Kubernetes object that defines how external traffic should reach services inside the cluster.

Ingress Controller

> A program that reads Ingress rules and actually routes the traffic.

---

# 13. Best Way to Remember

```
Ingress = Rules
Ingress Controller = Traffic Manager
```

---

# End
