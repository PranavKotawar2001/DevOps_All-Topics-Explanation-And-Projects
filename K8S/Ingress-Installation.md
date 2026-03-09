# Install NGINX Ingress Controller using Helm

This guide explains how to install the **NGINX Ingress Controller** in a Kubernetes cluster using **Helm**.

---

# Prerequisites

Before starting, make sure you have:

- Kubernetes Cluster running
- kubectl installed and configured
- Internet access on the server

Check cluster connection:

kubectl get nodes

---

# Installation

```bash
wget https://get.helm.sh/helm-v4.1.1-linux-amd64.tar.gz
tar -xzvf helm-v4.1.1-linux-amd64.tar.gz
cd linux-amd64/
./helm pull oci://ghcr.io/nginx/charts/nginx-ingress --untar --version 2.4.3
cd nginx-ingress/
../helm install nginx-ingress .
```

---

# Verify Installation

Check if pods are running.

```bash
kubectl get pods
```

Check services.

```bash
kubectl get svc
```

Check ingress resources.

```bash
kubectl get ingress
```

---

# Expected Result

You should see the **NGINX Ingress Controller pod running**.

Example:

```
nginx-ingress-controller-xxxxx   Running
```

---

# Notes

- Helm is a package manager for Kubernetes.
- NGINX Ingress Controller manages external HTTP/HTTPS traffic.
- It routes incoming requests to Kubernetes services based on rules.

---
