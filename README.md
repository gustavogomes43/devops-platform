<p align="center">
<img src="assets/architecture.png" width="900"/>
</p>

<h1 align="center">Plataforma Kubernetes na AWS</h1>

<p align="center">
Plataforma cloud totalmente automatizada projetada para simular cenários reais de DevOps e SRE utilizando Terraform, Amazon EKS e GitOps.
</p>

<p align="center">

![AWS](https://img.shields.io/badge/AWS-EKS%20%7C%20VPC%20%7C%20IAM-orange?logo=amazon-aws)
![Kubernetes](https://img.shields.io/badge/Kubernetes-1.30-blue?logo=kubernetes)
![Terraform](https://img.shields.io/badge/Terraform-Infrastructure%20as%20Code-purple?logo=terraform)
![ArgoCD](https://img.shields.io/badge/GitOps-ArgoCD-red?logo=argo)
![Observability](https://img.shields.io/badge/Monitoring-Prometheus%20%7C%20Grafana-green?logo=prometheus)

</p>

---

## 📌 Problema

Ambientes cloud modernos raramente falham por falta de ferramentas —  
os principais problemas estão em:

- Deploys manuais e inconsistentes  
- Configuration drift  
- Falta de isolamento de rede  
- Baixa observabilidade  
- Infraestrutura difícil de manter  

Este projeto foi construído para resolver esses pontos através de uma abordagem **automatizada, previsível e resiliente**.

---

## 🧠 Solução

Uma plataforma cloud-native baseada em:

- **Infrastructure as Code (Terraform)** → ambientes reproduzíveis  
- **Kubernetes (Amazon EKS)** → orquestração escalável  
- **GitOps (ArgoCD)** → deploy declarativo e automatizado  
- **Observabilidade (Prometheus + Grafana)** → visibilidade operacional  

O sistema foi projetado para operar com **mínima intervenção manual** e **comportamento previsível mesmo sob falhas**.

---

## 🏗️ Arquitetura

![Architecture](architecture.png)

### Principais decisões de arquitetura

- Workloads executando em **subnets privadas** (sem exposição direta à internet)  
- Saída controlada via **NAT Gateway**  
- Deploy distribuído em múltiplas AZs (alta disponibilidade)  
- Git como **fonte única da verdade**  
- Uso de serviços gerenciados para reduzir overhead operacional  

---

## ⚙️ Componentes da Plataforma

### Camada de Infraestrutura
- AWS VPC (CIDR customizado)  
- Subnets públicas e privadas  
- NAT Gateway e tabelas de rota  
- IAM com princípio de menor privilégio  

### Camada de Compute
- Amazon EKS (v1.30)  
- Managed Node Groups (Amazon Linux 2023)  

### Camada de Deploy
- ArgoCD (controle GitOps)  
- Helm (gerenciamento de aplicações)  

### Camada de Observabilidade
- Prometheus (coleta de métricas)  
- Grafana (visualização)  
- Node Exporter (métricas de infraestrutura)  

---

## 🔄 Modelo de Deploy (GitOps)
- Git Commit → ArgoCD detecta → Sync do cluster → Deploy automático

---

### Garantias do modelo

- Eliminação de deploy manual (`kubectl apply`)  
- Correção automática de desvios (self-healing)  
- Detecção de drift  
- Versionamento completo de infra + aplicações  

---

## 🧪 Cenários Reais de Falha e Decisões de Engenharia

Este projeto inclui problemas reais encontrados em ambientes cloud:

### 1. Mudança de autenticação no EKS
- Problema: depreciação do `aws-auth ConfigMap`  
- Solução: migração para **Access Entries (API_AND_CONFIG_MAP)**  
- Resultado: controle de acesso nativo via IAM  

---

### 2. Terraform State Drift
- Problema: divergência entre estado e infraestrutura real  
- Solução:
  - `terraform state rm`  
  - `terraform import`  
- Resultado: reconciliação sem downtime  

---

### 3. Falha ao deletar VPC
- Problema: `DependencyViolation`  
- Causa raiz: dependência entre NAT Gateway e Elastic IP  
- Resultado: entendimento do ciclo de vida dos recursos AWS  

---

### 4. Erro na criação de Node Group
- Problema: subnets sem auto-assign public IP  
- Resultado: correção do design entre subnets públicas e privadas  

---

## 📊 Características Operacionais

- Alta disponibilidade (multi-AZ)  
- Segurança por isolamento de rede  
- Deploy determinístico  
- Observabilidade completa  
- Redução de intervenção manual  

---

## 🚀 Como executar

```bash
terraform init -upgrade
terraform apply --auto-approve

aws eks update-kubeconfig --region us-east-1 --name devops-cluster
kubectl get nodes
```

## 📈 Evoluções futuras

- Karpenter (autoscaling inteligente)
- Estratégias de FinOps (otimização de custos)
- Criptografia com KMS
- Pipeline CI/CD com GitHub Actions
- Policy as Code (OPA / Kyverno)

---

## 👨‍💻 Autor

Gustavo Gomes
Cloud & DevOps Engineer

---

## ⚠️ Aviso

Este projeto foi desenvolvido para fins educacionais e demonstração arquitetural.

Para uso em produção, recomenda-se:

- Hardening de segurança
- Controle de custos
- Validação de compliance
