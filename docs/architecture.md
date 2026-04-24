# 🏗️ Architecture Overview

## 🎯 Visão Geral

Esta plataforma implementa uma arquitetura moderna baseada em Kubernetes (EKS), com provisionamento via Terraform e operação contínua através de GitOps (ArgoCD).

O objetivo é garantir:

- Alta disponibilidade (multi-AZ)
- Segurança (isolamento em subnets privadas)
- Escalabilidade horizontal
- Automação completa (IaC + GitOps)

---

## 🧱 Componentes Principais

### Infraestrutura (AWS)

- VPC customizada
- Subnets públicas e privadas
- NAT Gateway
- Internet Gateway
- Security Groups

### Compute

- Amazon EKS (v1.30)
- Managed Node Groups
- Instâncias EC2 (t3.small)

### Plataforma

- ArgoCD (GitOps)
- Helm Charts
- Kubernetes Workloads

### Observabilidade

- Prometheus
- Grafana
- Node Exporter

---

## 🔄 Fluxo de Operação

1. Terraform provisiona a infraestrutura
2. EKS cluster é criado
3. ArgoCD é instalado no cluster
4. ArgoCD monitora o repositório Git
5. Aplicações são sincronizadas automaticamente

---

## 🧠 Decisões Arquiteturais

### Subnets Privadas para Nodes

Motivação:
- Reduzir superfície de ataque
- Evitar exposição direta à internet

Trade-off:
- Necessidade de NAT Gateway para saída

---

### Uso de Managed Node Groups

Motivação:
- Redução de overhead operacional
- Patch e lifecycle gerenciado pela AWS

---

### GitOps como padrão

Motivação:
- Eliminação de configuration drift
- Deploy auditável e versionado
