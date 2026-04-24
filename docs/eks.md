
---

# ⚙️ docs/eks.md

```md id="eks001"
# ⚙️ Amazon EKS

## 📦 Configuração do Cluster

- Versão: 1.30
- Tipo: Managed Kubernetes
- Endpoint: privado + público

---

## 🖥️ Node Groups

- Tipo: Managed
- Instância: t3.small
- Multi-AZ

---

## 🔐 Autenticação

### Problema

O ConfigMap aws-auth foi descontinuado.

---

### Solução

Uso de:

- EKS Access Entries
- Modo: API_AND_CONFIG_MAP

---

## ⚠️ Problemas Enfrentados

### Nodes não aparecem

**Causa:**
- IAM Role incorreta
- Bootstrap falhando

---

### Scaling inconsistente

**Causa:**
- Desired != Running

---

## 📌 Lições

- EKS depende fortemente de IAM
- Debug exige análise de múltiplas camadas
