# 🐧 Linux Important Commands – DevOps Cheat Sheet
---

## 📁 Basic File & Directory Commands
```bash
pwd                 # Show current directory
ls                  # List files
ls -la              # Detailed list with hidden files
cd <dir>            # Change directory
mkdir <dir>         # Create directory
mkdir -p a/b        # Create nested directories
rmdir <dir>         # Remove empty directory
```

## 📄 File Operations
```bash
touch file.txt          # Create empty file
cp file1 file2          # Copy file
cp -r dir1 dir2         # Copy directory
mv file newname         # Move/Rename file
rm file                 # Delete file
rm -rf dir              # Force delete directory
```

## 👀 View & Read Files
```bash
cat file.txt            # View file
less file.txt           # Scrollable view
more file.txt           # Page-by-page view
head file.txt           # First 10 lines
tail file.txt           # Last 10 lines
tail -f logfile.log     # Live log monitoring
```
## 🔐 File Permissions & Ownership
```bash
chmod 755 file          # Change permissions
chmod +x script.sh      # Make executable
chown user file         # Change owner
chown user:group file   # Change owner & group
```
## 👤 User & Group Management
```bash
whoami                   # Current user
id                       # User info
adduser user1            # Add user
passwd user1             # Set password
groupadd devops          # Create group
usermod -aG devops user1 # Add user to group
```
## ⚙️ Process Management
```bash
ps                      # Running processes
ps aux                  # All processes
top                     # Live process monitor
htop                    # Enhanced top (if installed)
kill <PID>              # Kill process
kill -9 <PID>           # Force kill
```

## 💾 Disk & Memory Commands
```bash
df -h                   # Disk usage
du -sh dir              # Directory size
free -h                 # Memory usage
lsblk                   # Block devices
mount                   # Mounted filesystems
```

## 🌐 Networking Commands
```bash
ip a                    # IP address
ip r                    # Routing table
ping google.com         # Network check
curl URL                # API/URL test
wget URL                # Download file
netstat -tulnp          # Listening ports
ss -tulnp               # Modern netstat
```

## 🔍 Search & Text Processing (Very Important)
```bash
grep "error" file.log   # Search text
grep -i "error" file    # Case-insensitive
find / -name file.txt  # Find file
awk '{print $1}' file  # Column processing
sed 's/old/new/' file  # Replace text
```

## 📦 Compression & Archiving
```bash
tar -cvf file.tar dir       # Create tar
tar -xvf file.tar           # Extract tar
tar -czvf file.tar.gz dir
tar -xzvf file.tar.gz
zip file.zip file
unzip file.zip
```

## 📥 Package Management

### Ubuntu/ Debian
```bash
apt update
apt install nginx
apt remove nginx
```

### Amazon Linux / RHEL
```bash
yum install nginx
dnf install nginx
```

## 🔄 System & Service Management
```bash
uname -a                # System info
hostnamectl             # Host info
uptime                  # System uptime
reboot                  # Restart system
shutdown -h now         # Shutdown
```
### systemd
```bash
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl status nginx
systemctl enable nginx
```

## 🌱 Environment Variables
```bash
env
export VAR=value
echo $VAR
```


## 🔀 Redirection & Pipes
```bash
command > file          # Output to file
command >> file         # Append output
command < file          # Input from file
command1 | command2     # Pipe output
```

## 🔢 Permission Values
```bash
| Value | Meaning |
| ----- | ------- |
| 4     | Read    |
| 2     | Write   |
| 1     | Execute |

Example:- chmod 755 script.sh
```


## 🛠️ DevOps-Specific Commands
```bash
journalctl -u nginx     # Service logs
crontab -l              # List cron jobs
crontab -e              # Edit cron jobs
nohup command &         # Run in background
```

## 🔥 Must-Know Interview Commands
```bash
grep, awk, sed
ps, top, kill
chmod, chown
df, du, free
systemctl
curl
```

---