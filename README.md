# 🚀 Production-Grade EKS Platform with Terraform & GitOps (ArgoCD)

<p align="center">

![AWS](https://img.shields.io/badge/AWS-EKS%20%7C%20VPC%20%7C%20IAM-orange?logo=amazon-aws)
![Kubernetes](https://img.shields.io/badge/Kubernetes-1.30-blue?logo=kubernetes)
![Terraform](https://img.shields.io/badge/Terraform-IaC-purple?logo=terraform)
![ArgoCD](https://img.shields.io/badge/GitOps-ArgoCD-red?logo=argo)
![Helm](https://img.shields.io/badge/Helm-Charts-0F1689?logo=helm)
![Observability](https://img.shields.io/badge/Monitoring-Prometheus%20%7C%20Grafana-green?logo=prometheus)

</p>

<p align="center">

![GitHub repo size](https://img.shields.io/github/repo-size/gustavogomes43/devops-platform)
![GitHub stars](https://img.shields.io/github/stars/gustavogomes43/devops-platform?style=social)
![GitHub forks](https://img.shields.io/github/forks/gustavogomes43/devops-platform?style=social)
![GitHub last commit](https://img.shields.io/github/last-commit/gustavogomes43/devops-platform)
![GitHub issues](https://img.shields.io/github/issues/gustavogomes43/devops-platform)

</p>

---

## 🎯 Overview

Infraestrutura na AWS com Kubernetes (EKS), provisionada via Terraform e operada com GitOps usando ArgoCD.

---

## 🏗️ Arquitetura

![Architecture](architecture.png)

---

## ⚡ Key Features

- ✅ Infraestrutura como código (Terraform)
- ✅ Kubernetes gerenciado (EKS 1.30)
- ✅ GitOps com ArgoCD
- ✅ Observabilidade completa (Prometheus + Grafana)
- ✅ Segurança com subnets privadas
- ✅ Alta disponibilidade multi-AZ

---

## 🧰 Stack Tecnológica

- AWS (EKS, EC2, VPC, IAM, ELB, NAT Gateway)
- Terraform (IaC)
- Kubernetes (EKS)
- ArgoCD (GitOps)
- Helm
- Prometheus + Grafana

---

## 🌐 Design de Rede

- VPC customizada (`10.0.0.0/16`)
- Subnets públicas e privadas
- NAT Gateway para saída controlada
- Workloads isoladas em subnets privadas

---

## ⚙️ Kubernetes (Amazon EKS)

- Versão: **1.30**
- Managed Node Groups
- Instâncias: `t3.small`
- OS: Amazon Linux 2023
- Multi-AZ

---

## 🔐 Autenticação Moderna (EKS Access Entry)

### Problema
Depreciação do `aws-auth ConfigMap`

### Solução
- Upgrade para Terraform v20+
- Uso de Access Entries (`API_AND_CONFIG_MAP`)

### Resultado
- Controle via API AWS
- Sem dependência de YAML

---

## 🐙 GitOps com ArgoCD

- Deploy automático via Git
- Sync contínuo
- Self-healing
- Rollback automático

### Fluxo

```mermaid
graph TD;
A[Git Commit] --> B[ArgoCD Detect]
B --> C[Sync Cluster]
C --> D[Deploy Kubernetes]
```

---

### 📊 Observabilidade
- Prometheus
- Grafana
- Node Exporter

---

### 🧠 Troubleshooting Real

- 🔥 EKS Authentication Failure
Causa: aws-auth deprecated
Solução: Access Entries

- 🔥 Terraform State Drift
Solução: terraform state rm + import

- 🔥 NAT Gateway Lock
Causa: EIP preso
Solução: remoção correta do NAT

---

### 🚀 Provisionamento

```bash

terraform init -upgrade
terraform apply --auto-approve
```

---

### 📈 Roadmap
- KMS Encryption
- AWS Load Balancer Controller (ALB)
- Karpenter (FinOps)

---

### 👨‍💻 Autor

Gustavo Gomes
DevOps & Cloud Infrastructure
