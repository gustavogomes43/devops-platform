# 🏗️ Enterprise EKS Foundation & GitOps Lifecycle

Este projeto implementa uma infraestrutura de nível de produção na AWS utilizando **Terraform** para o provisionamento e **ArgoCD** para a estratégia de entrega contínua (GitOps). O foco central foi a construção de um ambiente resiliente, seguro e totalmente compatível com as novas APIs de autenticação do **Amazon EKS v1.30**.

---

## 🗺️ Visão Geral da Arquitetura

A arquitetura foi projetada seguindo o princípio de **Least Privilege** e segregação de rede, isolando workloads críticas em subnets privadas para mitigar vetores de ataque.

### Componentes de Rede (VPC Design)
- **Topologia:** 1 VPC customizada com 4 Subnets distribuídas estrategicamente em 2 Zonas de Disponibilidade (`us-east-1a` e `us-east-1b`).
- **Segurança de Borda (Egress Control):** Implementação de **NAT Gateway** em subnet pública, permitindo que os nodes do cluster em subnets privadas realizem chamadas de saída para atualizações e pull de imagens, sem exposição direta à internet pública.
- **Service Discovery:** Configuração rigorosa de Tags de Cloud Discovery (`kubernetes.io/role/elb` e `internal-elb`), garantindo a integração nativa com o **AWS Load Balancer Controller**.

---

## 🧠 Engenharia de Implementação & Troubleshooting

Diferente de setups básicos, este projeto enfrentou e resolveu desafios reais de infraestrutura complexa:

### 1. Modernização da Autenticação (EKS Access Entries)
**Desafio:** A versão 1.30 do EKS tornou o ConfigMap `aws-auth` legado, gerando falhas de `Unauthorized` em módulos Terraform antigos.
**Solução:** Realizei o upgrade do módulo EKS para a versão **v20.0** e implementamos o **Access Entry Mode (`API_AND_CONFIG_MAP`)**. 
- **Impacto:** Gestão de permissões nativa via API da AWS, eliminando a necessidade de gerenciar arquivos YAML internos para conceder privilégios de Admin à IAM Role (`EC2-GuardianAI-Role`).

### 2. Gestão de Estado Crítica (Terraform State Reconciliation)
**Desafio:** Conflitos de CIDR e recursos órfãos na AWS que impediam a convergência do código.
**Solução:** Aplicamos uma estratégia de reconciliação de estado em vez de destruição total:
- **`terraform state rm`**: Limpeza de referências inconsistentes no arquivo de estado.
- **`terraform import`**: Adopção de recursos existentes para o gerenciamento via IaC.
- **Resultado:** Convergência de infraestrutura com zero downtime dos recursos de rede pré-existentes.

### 3. Abstração de Compute (Managed Node Groups)
**Decisão Técnica:** Utilização de instâncias `t3.small` com **Amazon Linux 2023 (AL2023)**. 
- **Benefício:** Redução da sobrecarga operacional através de *Managed Node Groups*, onde a AWS gerencia o ciclo de vida, patching e segurança do Sistema Operacional dos nodes.

---

## 🐙 GitOps com ArgoCD

O **ArgoCD** foi implementado como a única fonte de verdade para o estado das aplicações no cluster.

- **Deploy Automatizado:** O cluster monitora o repositório Git e sincroniza automaticamente qualquer mudança nos manifestos, eliminando o "Configuration Drift".
- **Acesso:** Exposição via Load Balancer (ELB) com segurança baseada em Security Groups e recuperação dinâmica de credenciais administrativas via Secrets do Kubernetes.

---

## 🚀 Guia de Operação

### Provisionamento Inicial
```bash
# Inicialização com upgrade para suporte às novas APIs (v20+)
terraform init -upgrade

# Aplicação da infraestrutura como código
terraform apply --auto-approve
```

---

📈 Roadmap de Evolução

[ ] Segurança: Implementação de KMS Encryption para Secrets e criptografia de volumes EBS.

[ ] Network: Migração para Application Load Balancer (ALB) via AWS Ingress Controller.

[ ] FinOps: Implementação de Karpenter para substituição do Cluster Autoscaler convencional, otimizando custos de computação.

---
Desenvolvido por Gus — DevOps & Cloud Infrastructure
