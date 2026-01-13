
 # Create a 10GB Storage and Permanently Mount It to an EC2 Instance

> This guide explains how to create a 10GB storage volume and permanently mount it to an EC2 instance.

---

## Prerequisites

* AWS account
* EC2 instance running (Linux-based)
* SSH access to the instance

---

## Step-by-Step Procedure

### **Step 1: Create an EC2 Instance**

* Launch a new EC2 instance or use an existing one.

---

### **Step 2: Create a 10GB Volume**

* Go to **EC2 Dashboard**
* From the left menu, navigate to **Elastic Block Store → Volumes**
* Click **Create volume**
* Set **Size = 10 GB**
* Select the same **Availability Zone** as your EC2 instance
* Click **Create volume**

---

### **Step 3: Attach Volume to the Instance**

* Select the created volume
* Click **Actions → Attach volume**

---

### **Step 4: Select Instance and Device Name**

* Choose your EC2 instance
* Set **Device name** as:

  ```
  /dev/xvdbh
  ```
* Click **Attach**

---

### **Step 5: SSH into the EC2 Instance**

```bash
ssh -i <key.pem> ec2-user@<public-ip>
```

---

### **Step 6: Verify Attached Volume**

```bash
lsblk
```

---

### **Step 7: Create Partition**

```bash
fdisk /dev/<mount-name>
```

---

### **Step 8: Create a New Partition**

Inside `fdisk`:

* Press `n` → New partition
* Press `p` → Primary
* Press `Enter` twice
* Type `+5G` to allocate 5GB
* Press `w` to write and exit

---

### **Step 9: Format the Partition**

```bash
mkfs.xfs -f /dev/<partition-name>
```

---

### **Step 10: Verify Partition Creation**

```bash
lsblk
```

---

### **Step 11: Check UUID**

```bash
blkid
```

---

### **Step 12: Configure Permanent Mount**

```bash
vim /etc/fstab
```

---

### **Step 13: Add Entry to `/etc/fstab`**

Example entry:

```
/dev/nvme1n1p1   /mnt   xfs   defaults   0 0
```

---

### **Step 14: Mount All Filesystems**

```bash
mount -av
```

---

### **Step 15: Verify Mount**

```bash
lsblk
```

---
