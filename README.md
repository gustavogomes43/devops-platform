# 🚀 Production-Grade EKS Platform with Terraform & GitOps (ArgoCD)

> Infraestrutura de nível produção na AWS com Kubernetes (EKS), provisionada via Terraform e operada com GitOps usando ArgoCD.

---

## 🎯 Objetivo

Construir uma plataforma escalável, segura e automatizada para deploy contínuo de aplicações em Kubernetes, eliminando configuration drift, reduzindo intervenção manual e garantindo alta disponibilidade.

---

## 🏗️ Arquitetura

![Architecture Diagram](./docs/architecture.png)

---

## 🧰 Stack Tecnológica

- AWS (EKS, EC2, VPC, IAM, ELB, NAT Gateway)
- Terraform (Infraestrutura como Código)
- Kubernetes (EKS v1.30)
- ArgoCD (GitOps)
- Helm (Gerenciamento de pacotes)
- Prometheus + Grafana (Observabilidade)
- Node Exporter (Métricas de infraestrutura)

---

## 🌐 Design de Rede (VPC)

- 1 VPC customizada (`10.0.0.0/16`)
- 2 Availability Zones (`us-east-1a`, `us-east-1b`)
- Subnets:
  - Públicas (NAT Gateway + Internet Gateway)
  - Privadas (EKS Nodes)

### 🔐 Estratégia de Segurança

- Workloads em subnets privadas
- Sem exposição direta à internet
- Egress controlado via NAT Gateway
- Security Groups restritivos
- IAM com princípio de menor privilégio

---

## ⚙️ Kubernetes (Amazon EKS)

- Versão: **1.30**
- Managed Node Groups
- Instâncias: `t3.small`
- OS: Amazon Linux 2023
- Alta disponibilidade multi-AZ

---

## 🔐 Autenticação Moderna (EKS Access Entry)

### Problema
EKS 1.30 depreca o `aws-auth ConfigMap`.

### Solução
- Upgrade para módulo Terraform v20+
- Uso de **Access Entries (`API_AND_CONFIG_MAP`)**

### Resultado
- Controle de acesso via API AWS
- Eliminação de dependência de YAML interno

---

## 🐙 GitOps com ArgoCD

- Deploy automático baseado em Git
- Sync contínuo
- Self-healing
- Rollback automático

### Fluxo

1. Dev faz commit no Git
2. ArgoCD detecta mudança
3. Sincroniza com cluster
4. Kubernetes aplica estado desejado

---

## 📊 Observabilidade

Implementação completa via Helm:

- Prometheus Operator
- Grafana Dashboards
- Node Exporter

### Benefícios

- Monitoramento de cluster e nodes
- Métricas em tempo real
- Base para alertas e SRE

---

## 🧠 Troubleshooting Real (Diferencial)

### 🔥 1. EKS Authentication Failure

**Problema:**
Erro `Unauthorized` após upgrade

**Causa:**
Depreciação do `aws-auth`

**Solução:**
Migração para Access Entries

---

### 🔥 2. Terraform State Drift

**Problema:**
Infra não convergia (CIDR / recursos órfãos)

**Solução:**

- `terraform state rm`
- `terraform import`

**Resultado:**
Infra recuperada sem downtime

---

### 🔥 3. NAT Gateway Lock (VPC Delete Failure)

**Problema:**
Erro `DependencyViolation` ao deletar VPC

**Causa:**
Elastic IP preso ao NAT Gateway

**Solução:**

- Identificação via ENI
- Remoção correta do NAT Gateway

---

## 🚀 Provisionamento

```bash
terraform init -upgrade
terraform apply --auto-approve
