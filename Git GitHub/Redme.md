# Git and GitHub – Complete Beginner to Advanced Guide

This **README.md** explains **Git and GitHub from scratch**, in a **very clear, step-by-step way**, with **detailed explanations** and **all commonly used commands mapped to real use cases**.

This guide is perfect for:

- Beginners
- DevOps / Cloud learners
- Interview preparation
- Real project usage

---

## PART 1: What is Git?

### Definition

**Git** is a **distributed version control system** used to **track changes in source code**.

👉 In simple words:

> Git helps you save versions of your code and work with others safely.

---

### Why Git is Needed

Without Git:

- No history of code changes
- Hard to collaborate
- Risk of losing code

With Git:

- Full history of changes
- Easy collaboration
- Rollback to previous versions
- Branching and merging

---

### Git Key Concepts

| Term              | Meaning                       |
| ----------------- | ----------------------------- |
| Repository (Repo) | Project folder tracked by Git |
| Commit            | Snapshot of code changes      |
| Branch            | Parallel version of code      |
| Merge             | Combine branches              |
| HEAD              | Current commit                |
| Working Tree      | Files you are editing         |

---

## PART 2: What is GitHub?

### Definition

**GitHub** is a **cloud platform** that hosts **Git repositories** online.

👉 Think like this:

- Git = Tool (runs on your computer)
- GitHub = Cloud storage + collaboration

---

### Why GitHub is Used

- Store code online
- Team collaboration
- Backup repositories
- CI/CD integration
- Issue tracking & pull requests

---

## Git vs GitHub (Very Important)

| Feature           | Git     | GitHub    |
| ----------------- | ------- | --------- |
| Type              | Tool    | Platform  |
| Internet Required | No      | Yes       |
| Code Storage      | Local   | Cloud     |
| Collaboration     | Limited | Excellent |

---

## PART 3: Git Installation

### Install Git on Ubuntu

```bash
sudo apt update
sudo apt install git -y
git --version
```

---

### Configure Git (One Time Setup)

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

Check config:

```bash
git config --list
```

---

## PART 4: Git Workflow (Core Understanding)

```
Working Directory → Staging Area → Repository
```

Commands:

- `git add` → staging
- `git commit` → repository

---

## PART 5: Common Git Commands by Use Case

### Use Case 1: Start a New Project

```bash
git init
```

Initializes a new Git repository.

---

### Use Case 2: Check Repository Status

```bash
git status
```

Shows modified, staged, and untracked files.

---

### Use Case 3: Add Files to Staging Area

Add single file:

```bash
git add file.txt
```

Add all files:

```bash
git add .
```

---

### Use Case 4: Commit Changes

```bash
git commit -m "Initial commit"
```

Creates a snapshot of staged changes.

---

### Use Case 5: View Commit History

```bash
git log
```

Short version:

```bash
git log --oneline
```

---

### Use Case 6: Ignore Files

Create `.gitignore`:

```
node_modules/
.env
*.log
```

---

## PART 6: Branching (Very Important)

### Why Branches?

- Work on features safely
- Avoid breaking main code

---

### Create Branch

```bash
git branch feature-login
```

---

### Switch Branch

```bash
git checkout feature-login
```

OR

```bash
git switch feature-login
```

---

### Create & Switch Together

```bash
git checkout -b feature-login
```

---

### List Branches

```bash
git branch
```

---

### Merge Branch

```bash
git checkout main
git merge feature-login
```

---

## PART 7: Undo & Fix Mistakes

### Undo Staged File

```bash
git reset file.txt
```

---

### Undo Last Commit (Keep Changes)

```bash
git reset --soft HEAD~1
```

---

### Undo Last Commit (Delete Changes)

```bash
git reset --hard HEAD~1
```

⚠️ Dangerous – use carefully

---

## PART 8: GitHub – Hands-On

### Create GitHub Repository

1. Login to GitHub
2. Click **New Repository**
3. Copy repo URL

---

### Connect Local Repo to GitHub

```bash
git remote add origin https://github.com/username/repo.git
```

---

### Push Code to GitHub

```bash
git push -u origin main
```

---

### Pull Code from GitHub

```bash
git pull origin main
```

---

### Clone Repository

```bash
git clone https://github.com/username/repo.git
```

---

## PART 9: GitHub Collaboration

### Pull Requests (PR)

Used to:

- Review code
- Merge changes safely

Flow:

1. Create branch
2. Push to GitHub
3. Open Pull Request
4. Review & merge

---

### Forking

Used in open-source projects:

- Fork repo
- Make changes
- Create PR

---

## PART 10: Common GitHub Commands Summary

| Task          | Command          |
| ------------- | ---------------- |
| Clone repo    | `git clone`      |
| Push code     | `git push`       |
| Pull updates  | `git pull`       |
| Add remote    | `git remote add` |
| Check remotes | `git remote -v`  |

---

## PART 11: Git Best Practices

- Commit frequently
- Write clear commit messages
- Use branches
- Pull before push
- Keep main branch stable

---

# Git – Advanced Topics (What to Learn Next)

This **README.md** is written for **beginners who already know basic Git & GitHub** and want to move to an **intermediate / advanced level**.

It explains the following **5 important topics** in a **simple and practical way**:

1. Git Rebase
2. Git Stash
3. Git Tags
4. GitHub Actions
5. Git Branching Strategies (GitFlow)

---

## 1️⃣ Git Rebase

### What is Git Rebase?

**Git rebase** is used to **move or replay commits** from one branch on top of another branch.

👉 Simple meaning:

> Rebase makes your commit history **clean and linear**.

---

### Why Use Rebase?

- To avoid unnecessary merge commits
- To keep commit history clean
- To apply your changes on the latest code

---

### Rebase vs Merge

| Feature        | Rebase              | Merge             |
| -------------- | ------------------- | ----------------- |
| Commit history | Clean & linear      | Has merge commits |
| Risk           | Higher (if misused) | Safer             |
| Used for       | Local branches      | Shared branches   |

---

### Common Rebase Command

```bash
git checkout feature-branch
git rebase main
```

This applies feature branch commits **on top of main**.

⚠️ **Important Rule**:

> Never rebase a branch that is already pushed and shared.

---

## 2️⃣ Git Stash

### What is Git Stash?

**Git stash** temporarily saves your uncommitted changes so you can work on something else.

👉 Think of it like:

> “Save my work for now, I’ll come back later.”

---

### Why Use Git Stash?

- You need to switch branches quickly
- Your code is not ready to commit
- You want a clean working directory

---

### Common Git Stash Commands

Save changes:

```bash
git stash
```

List stashes:

```bash
git stash list
```

Apply stash:

```bash
git stash apply
```

Apply & delete stash:

```bash
git stash pop
```

---

## 3️⃣ Git Tags

### What are Git Tags?

**Git tags** are used to **mark specific commits**, usually for **releases**.

Example:

- v1.0
- v2.1

---

### Why Use Git Tags?

- Mark production releases
- Roll back to specific versions
- Version tracking

---

### Create a Tag

```bash
git tag v1.0
```

Annotated tag (recommended):

```bash
git tag -a v1.0 -m "First release"
```

---

### Push Tags to GitHub

```bash
git push origin v1.0
```

Push all tags:

```bash
git push origin --tags
```

---

## 4️⃣ GitHub Actions

### What is GitHub Actions?

**GitHub Actions** is a **CI/CD tool** that lets you **automate workflows** directly from GitHub.

Example automations:

- Run tests on every push
- Build Docker images
- Deploy applications

---

### Why GitHub Actions?

- No external CI tool needed
- Easy YAML-based configuration
- Deep GitHub integration

---

### Basic GitHub Actions Workflow Example

Create file:

```
.github/workflows/ci.yml
```

```yaml
name: CI Pipeline

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run tests
        run: echo "Running tests"
```

---

## 5️⃣ Git Branching Strategies (GitFlow)

### What is GitFlow?

**GitFlow** is a **branching strategy** used in professional projects.

It defines **rules for creating and merging branches**.

---

### GitFlow Branch Types

| Branch     | Purpose               |
| ---------- | --------------------- |
| main       | Production-ready code |
| develop    | Integration branch    |
| feature/\* | New features          |
| release/\* | Prepare releases      |
| hotfix/\*  | Production bug fixes  |

---

### GitFlow Workflow (Simple)

1. Create feature branch from develop
2. Merge feature → develop
3. Create release branch
4. Merge release → main
5. Tag release

---

### Why GitFlow is Important?

- Clean release process
- Safe production deployments
- Better team collaboration

---

## 🚀 When to Use Which Feature?

| Scenario        | Tool           |
| --------------- | -------------- |
| Clean history   | Rebase         |
| Temporary save  | Stash          |
| Release version | Tags           |
| Automation      | GitHub Actions |
| Team workflow   | GitFlow        |

---

# Git & CI/CD – Advanced Topics (Next Level)

This **README.md** is designed for learners who already understand **basic and intermediate Git & GitHub** and want to move to a **professional / industry level**.

This guide explains the following **5 advanced topics** in a **clear, beginner-friendly but professional way**:

1. Git Cherry-pick
2. Git Hooks
3. GitHub Actions Secrets
4. Advanced CI/CD Pipelines
5. Mono-repo Strategies

---

## 1️⃣ Git Cherry-pick

### What is Git Cherry-pick?

**Git cherry-pick** allows you to **pick a specific commit from one branch and apply it to another branch**.

👉 Simple meaning:

> Copy one commit and paste it into another branch.

---

### When to Use Cherry-pick?

- Bug fix needs to go to production only
- You don’t want to merge the full branch
- Hotfix from develop → main

---

### Cherry-pick Command

```bash
git checkout main
git cherry-pick <commit-hash>
```

To find commit hash:

```bash
git log --oneline
```

---

### Abort Cherry-pick (if conflict)

```bash
git cherry-pick --abort
```

---

## 2️⃣ Git Hooks

### What are Git Hooks?

**Git hooks** are **scripts that run automatically** when certain Git events occur.

Examples:

- Before commit
- Before push
- After merge

---

### Why Git Hooks are Used?

- Enforce code quality
- Run tests before commit
- Prevent bad commits

---

### Common Hooks

| Hook       | When it runs            |
| ---------- | ----------------------- |
| pre-commit | Before commit           |
| pre-push   | Before push             |
| commit-msg | Validate commit message |

---

### Example: pre-commit Hook

File:

```
.git/hooks/pre-commit
```

```bash
#!/bin/bash
npm test || exit 1
```

Make executable:

```bash
chmod +x .git/hooks/pre-commit
```

---

## 3️⃣ GitHub Actions Secrets

### What are GitHub Actions Secrets?

**Secrets** are encrypted values used to store **passwords, tokens, and keys** safely in GitHub Actions.

Never hardcode secrets in workflows.

---

### Why Secrets are Important?

- Security
- Prevent credential leaks
- Required for deployments

---

### Add a Secret in GitHub

1. Go to Repository → Settings
2. Click **Secrets and variables → Actions**
3. Add **New repository secret**

---

### Use Secret in Workflow

```yaml
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

---

## 4️⃣ Advanced CI/CD Pipelines

### What is Advanced CI/CD?

Advanced CI/CD pipelines include:

- Multiple stages
- Environment-based deployments
- Approval gates
- Rollbacks

---

### Typical Pipeline Stages

1. Code checkout
2. Build
3. Test
4. Security scan
5. Deploy to staging
6. Manual approval
7. Deploy to production

---

### Advanced GitHub Actions Example (Concept)

```yaml
jobs:
  build:
  test:
  deploy-staging:
  deploy-production:
```

---

## 5️⃣ Mono-repo Strategies

### What is a Mono-repo?

A **mono-repo** contains **multiple projects in a single repository**.

Example:

```
repo/
 ├── frontend/
 ├── backend/
 ├── infra/
```

---

### Why Use Mono-repo?

- Shared code
- Unified versioning
- Easier dependency management

---

### Challenges of Mono-repo

- Large repo size
- Complex CI/CD
- Requires discipline

---

### Mono-repo Best Practices

- Clear folder structure
- Scoped CI pipelines
- Ownership rules
- Caching builds

---

## When to Use Which Tool

| Scenario            | Tool           |
| ------------------- | -------------- |
| Apply single fix    | Cherry-pick    |
| Enforce quality     | Git hooks      |
| Secure credentials  | GitHub secrets |
| Enterprise delivery | Advanced CI/CD |
| Large projects      | Mono-repo      |

---

🎉 **You are now moving toward an industry-level Git & CI/CD skill set!**

## Git in DevOps & CI/CD

Git is used in:

- Jenkins pipelines
- GitHub Actions
- GitLab CI
- Infrastructure as Code

---

🎉 **You now have a complete understanding of Git and GitHub from basics to real-world usage!**
