# Datadog Next Steps – Beginner Guide (EC2 Only)

This **README.md** is written for **absolute beginners**. It explains what to do **after creating a Datadog account**, using **simple language** and **step-by-step instructions**.

You will learn how to:

1. Install Datadog Agent on **AWS EC2**
2. Create **custom dashboards**
3. Configure **alerts and notifications**
4. Enable **APM (Application Performance Monitoring)**

---

## Prerequisites

Before you start, make sure you have:

- An AWS account
- One **EC2 instance** (Ubuntu 20.04 / 22.04 recommended)
- SSH access to the EC2 instance
- A Datadog account (Free trial is enough)

---

# STEP 1: Install Datadog Agent on EC2

The **Datadog Agent** is a small program that runs on your EC2 instance and sends metrics, logs, and traces to Datadog.

---

## Step 1.1: Get Datadog API Key

1. Log in to Datadog
2. Go to **Organization Settings → API Keys**
3. Copy your **API Key**

> This key allows your EC2 instance to send data to Datadog.

---

## Step 1.2: Connect to EC2

```bash
ssh ubuntu@<EC2_PUBLIC_IP>
```

---

## Step 1.3: Install Datadog Agent

Replace `<YOUR_API_KEY>` with your actual API key.

```bash
DD_API_KEY=<YOUR_API_KEY> \
DD_SITE="datadoghq.com" \
bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
```

### Explanation (Very Simple)

- `DD_API_KEY` → Your Datadog account key
- `DD_SITE` → Datadog website region
- This command downloads and installs the Datadog Agent

---

## Step 1.4: Verify Agent Status

```bash
sudo datadog-agent status
```

If the agent is working, you will see:

- System metrics
- Checks status

---

# STEP 2: Create Custom Dashboards

Dashboards help you **see your EC2 health visually**.

---

## Step 2.1: Create a New Dashboard

1. Open Datadog UI
2. Click **Dashboards → New Dashboard**
3. Select **Blank Dashboard**

---

## Step 2.2: Add a Widget

1. Click **Add Widget**
2. Choose **Time Series**
3. Select metrics like:
   - `system.cpu.user`
   - `system.mem.used`
   - `system.disk.used`

4. Click **Save**

---

## Step 2.3: Save Dashboard

Give it a name like:

```
EC2 Monitoring Dashboard
```

---

# STEP 3: Configure Alerts and Notifications

Alerts notify you when something goes wrong.

---

## Step 3.1: Create a Monitor

1. Go to **Monitors → New Monitor**
2. Select **Metric Monitor**
3. Choose metric:

```
system.cpu.user
```

---

## Step 3.2: Set Alert Condition

Example:

- Alert when CPU usage > **80%**
- For **5 minutes**

---

## Step 3.3: Configure Notification

Example message:

```
High CPU usage detected on EC2 instance.
```

Choose notification method:

- Email
- Slack (optional)

---

## Step 3.4: Save Monitor

Your alert is now active.

---

# STEP 4: Enable APM (Application Performance Monitoring)

APM helps you understand **application performance, latency, and errors**.

---

## Step 4.1: Enable APM in Datadog Agent

Edit configuration file:

```bash
sudo nano /etc/datadog-agent/datadog.yaml
```

Find and update:

```yaml
apm_config:
  enabled: true
```

Restart agent:

```bash
sudo systemctl restart datadog-agent
```

---

## Step 4.2: Install APM Library (Python Example)

```bash
pip install ddtrace
```

Run your app with:

```bash
ddtrace-run python app.py
```

---

## Step 4.3: View APM Data

1. Go to **APM → Services** in Datadog
2. Select your application
3. View:
   - Response time
   - Errors
   - Traces

---

## 🎉 You’re Done!

You have successfully:

- Installed Datadog Agent on EC2
- Created dashboards
- Configured alerts
- Enabled APM

---

Happy Monitoring 🚀
