# 🛠️ Real-World DevOps Projects

[![GitHub Stars](https://img.shields.io/github/stars/techiescamp/devops-projects?style=social)](https://github.com/techiescamp/devops-projects/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/techiescamp/devops-projects?style=social)](https://github.com/techiescamp/devops-projects/network/members)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![License: MIT](https://img.shields.io/badge/Code-MIT-blue.svg)](LICENSE)
[![License: CC BY-NC 4.0](https://img.shields.io/badge/Docs-CC--BY--NC--4.0-lightgrey.svg)](LICENSE-CONTENT)

> Hands-on projects for aspiring DevOps engineers — Beginner to Advanced.

Most DevOps learning resources give you theory. This repo gives you working infrastructure.

Every project is based on a **real scenario** from production environments.

⭐ **If this repo helps you, please star it. It helps other engineers find it.**

---

## Kubernetes Certification Voucher (UpTo 50% OFF) 🎉

As part of our commitment to helping the DevOps community save money on Kubernetes Certifications, we continuously update the latest voucher codes from the Linux Foundation

Get flat 35% discount on CKA, CKAD, CKS, KCNA etc

> [!IMPORTANT]
> 🚀  Use code **LUNAR26CT** at https://kube.promo/devops.

The following are the best bundles to **save 50%** with code **LUNAR26BUNCT**

- CKA + CKAD: [kube.promo/cka-ckad](https://kube.promo/cka-ckad)
- CKA + CKS Bundle: [kube.promo/bundle](https://kube.promo/bundle)
- CKA + CKAD + CKS Exam bundle: [kube.promo/k8s-bundle](https://kube.promo/k8s-bundle)

> [!NOTE]
>⌛ Act fast—this limited-time offer won’t be around much longer!
> You have one year of validity to appear for the certification exam after registration

## 📋 Table of Contents

- [Who Is This For?](#-who-is-this-for)
- [Prerequisites](#-prerequisites)
- [How to Use This Repo](#-how-to-use-this-repo)
- [Quick Start](#-quick-start)
- [Suggested Learning Path](#️-suggested-learning-path)
- [Beginner Projects](#-beginner-projects)
- [Intermediate Projects](#-intermediate-projects)
- [Advanced Projects](#-advanced-projects)
- [Upcoming Projects](#-upcoming-projects)
- [Project Videos](#-project-videos)
- [Related Repositories](#-related-repositories)
- [Stay Updated](#-stay-updated)
- [Contributing](#-contributing)
- [License](#-license)

---

## 👥 Who Is This For?

This repo is built for:

- **Fresh graduates** who want hands-on experience before their first DevOps job
- **Developers** transitioning into DevOps or Platform Engineering
- **Sysadmins** modernising their skillset with cloud-native tooling
- **Experienced engineers** filling gaps in specific areas like GitOps, security, or IaC

If you have ever thought *"I understand the concepts but I have never actually built it"* — this repo is for you.

---

## ✅ Prerequisites

You do not need to know everything before you start. But the following basics will help you get the most out of these projects.

| Skill | Level Needed | Why |
|-------|-------------|-----|
| Linux CLI | Basic | All projects run on Linux VMs or containers |
| Git | Basic | Clone repos, branch, commit |
| AWS Account | Required for most | Projects use EC2, VPC, ECS, Route53 |
| Docker | Basic (for Intermediate+) | Understanding containers before Kubernetes |
| Python | Basic (for Advanced) | Reading automation scripts |

> 💡 No prior DevOps experience needed for Beginner projects. Start there and build up.

---

## 🧭 How to Use This Repo

**New to DevOps?** Start with the 🟢 Beginner projects. Work through them in order. Each one builds on the previous.

**Have 1–2 years experience?** Jump into 🟡 Intermediate. Pick the skill area you are weakest in.

**Senior engineer filling gaps?** Go straight to 🔴 Advanced or pick specific topics from the Upcoming section.

**Each project folder contains:**
- A `README.md` with a full step-by-step guide
- Working code, Terraform configs, and scripts
- A clear "What you will learn" section up front
- Cleanup scripts so you do not leave resources running

> 💡 Use the [AWS $300 Free POC Credits](https://pages.awscloud.com/GLOBAL_NCA_LN_ARRC-program-A300-2023.html)
> to run all projects without worrying about cost. Every project has a destroy script.

---

## ⚡ Quick Start

```bash
# 1. Clone the repo
git clone https://github.com/techiescamp/devops-projects.git
cd devops-projects

# 2. Pick a project folder
cd 01-jenkins-setup

# 3. Read the project guide first
cat README.md

# 4. Follow the setup instructions inside
```

Each project README contains everything you need — prerequisites, architecture overview, step-by-step instructions, and cleanup steps.

---

## 🗺️ Suggested Learning Path

Not sure where to start? Follow this progression from foundation to production-grade skills:

```
🟢 01. Jenkins HA Setup
           ↓
🟢 04. Prometheus Observability Stack
           ↓
🟡 02. Consul Service Discovery
           ↓
🟡 03. Scalable Java App on AWS
           ↓
🟡 06. AWS VPN Setup  →  🟡 10. Route53 Private DNS
           ↓
🔴 05. AWS VPC Design with Terraform
           ↓
🔴 09. GitHub Actions OIDC  →  🔴 08. Fargate Deployment
```

---

## 🟢 Beginner Projects

Start here. These projects cover the core skills you will use in almost every DevOps job.

| # | Project | What You Will Learn |
|---|---------|---------------------|
| 01 | [Jenkins HA Setup on AWS](./01-jenkins-setup) | Set up a production-grade CI/CD server with auto-recovery using Packer, Ansible, and Terraform |
| 04 | [Prometheus Observability Stack](./04-prometheus-observability-stack) | Build a full monitoring stack with Prometheus, Grafana, and Alertmanager using Docker Compose |
| 07 | [Pritunl VPN Setup](./07-pritunl-vpn-setup) | Configure a self-hosted VPN server for secure access to private infrastructure |

---

## 🟡 Intermediate Projects

For engineers with 1–2 years of experience going deeper into AWS and distributed systems.

| # | Project | What You Will Learn |
|---|---------|---------------------|
| 02 | [Service Discovery with Consul](./02-consul-sevice-discovery) | Implement dynamic service discovery so services find each other without hardcoded IPs |
| 03 | [Scalable Java App on AWS](./03-scalable-java-app) | Deploy an application with Auto Scaling Groups, Load Balancers, and zero-downtime deployments |
| 06 | [AWS Client-to-Site VPN](./06-aws-client-vpn-setup) | Configure AWS-managed VPN for secure remote access to your private VPC |
| 10 | [Route53 Private Hosted Zone](./10-route53-private-hosted-zone) | Set up internal DNS so services resolve by name inside a private network |

---

## 🔴 Advanced Projects

For engineers ready to tackle production-grade infrastructure, security, and automation challenges.

| # | Project | What You Will Learn |
|---|---------|---------------------|
| 05 | [AWS VPC Design & Automation](./05-aws-vpc-design-and-automation) | Design and automate a multi-tier VPC with public/private subnets, NAT, and security groups using Terraform |
| 08 | [Fargate App Deployment](./08-fargate-app-deployment) | Deploy a containerised application on serverless ECS Fargate with task definitions and service configs |
| 09 | [GitHub Actions OIDC AWS Integration](./09-github-action-oidc-aws) | Set up keyless AWS authentication from GitHub Actions using OIDC — no long-lived credentials |

---

## 🔮 Upcoming Projects

Projects being actively planned and built. Star the repo to get notified when they drop.

> 💬 **Vote on what gets built next** — open an [Issue](https://github.com/techiescamp/devops-projects/issues) with the project name you want most. Most requested gets built first.

### 🐳 Containers & Kubernetes
- [ ] Docker Multi-Stage Build Pipeline
- [ ] Kubernetes Cluster Setup from Scratch (kubeadm)
- [ ] Helm Chart Development and Deployment
- [ ] Kubernetes Ingress with NGINX and TLS
- [ ] Karpenter — Node Autoscaling on EKS
- [ ] Kubernetes Resource Management — Requests, Limits, and QoS Classes

### 🔁 GitOps & CI/CD
- [ ] GitOps with ArgoCD — Full Application Deployment
- [ ] End-to-End GitHub Actions Pipeline (Build → Test → Deploy)
- [ ] Tekton Pipelines on Kubernetes
- [ ] Self-Hosted GitHub Actions Runners on Kubernetes

### 🔐 Security & Secrets
- [ ] HashiCorp Vault — Secrets Management for Kubernetes
- [ ] Container Image Scanning with Trivy in CI/CD
- [ ] Kubernetes RBAC — Real World Multi-Team Setup
- [ ] OPA Gatekeeper — Policy Enforcement on Kubernetes

### 📦 Infrastructure as Code
- [ ] Terraform Modules — Reusable, Shareable Infrastructure
- [ ] Terraform Remote State with S3 and DynamoDB Locking
- [ ] Terragrunt — Managing Multi-Environment Infrastructure
- [ ] Pulumi — IaC with Python

### 📊 Observability & Logging
- [ ] EFK Stack — Centralized Logging on Kubernetes
- [ ] Loki + Grafana — Log Aggregation Without Elasticsearch
- [ ] OpenTelemetry — Distributed Tracing Setup
- [ ] Kubernetes Dashboard — Real-Time Cluster Visibility

### ☁️ Platform Engineering
- [ ] Internal Developer Platform with Backstage
- [ ] Self-Service Infrastructure with Crossplane
- [ ] Cost Optimization — Spot Instances and Resource Right-Sizing
- [ ] Developer Environments with DevContainers

---

## 📺 Project Videos

| Project | Video |
|---------|-------|
| Jenkins HA Setup on AWS | [Watch on YouTube →](https://www.youtube.com/watch?v=GLMJhF_cZ5M) |

More videos drop regularly. [Subscribe to DevOpsCube on YouTube →](https://www.youtube.com/@devopscube)

---

## 🔗 Related Repositories

Other repos from the same community that complement the projects here:

| Repo | What It Covers |
|------|----------------|
| [kubernetes-projects](https://github.com/techiescamp/kubernetes-projects) | Hands-on Kubernetes projects from beginner to advanced |
| [mlops-for-devops](https://github.com/techiescamp/mlops-for-devops) | MLOps for DevOps engineers — from local ML to production on Kubernetes |
| [devops-roadmap](https://github.com/techiescamp/devops-roadmap) | A structured roadmap with practical tasks for every core DevOps skill |
| [python-for-devops](https://github.com/techiescamp/python-for-devops) | Python scripting and automation for DevOps engineers |

---

## 📬 Stay Updated

New projects drop regularly. The best ways to keep up:

| Channel | Link |
|---------|------|
| ⭐ Star this repo | GitHub will notify you of new releases |
| 📩 Weekly newsletter | [devopscube.com/newsletter](https://devopscube.com) — DevOps and MLOps deep-dives every week |
| 📺 YouTube | [youtube.com/@devopscube](https://www.youtube.com/@devopscube) — project walkthroughs and tutorials |

---

## 🤝 Contributing

Contributions are welcome — new projects, bug fixes, or improvements to existing guides.

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a PR. For new project ideas, open an Issue first so we can align on scope before you start building.

---

## 📜 License

- Code: [MIT](LICENSE)
- Content & Documentation: [CC BY-NC 4.0](LICENSE-CONTENT)

---

Built with ❤️ by [DevOpsCube](https://devopscube.com) · Follow us on [Twitter/X](https://twitter.com/devopscube)
