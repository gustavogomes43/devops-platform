# 🐙 GitOps com ArgoCD

## 🎯 Objetivo

Automatizar deploys e manter o estado desejado do cluster.

---

## ⚙️ Funcionamento

- ArgoCD monitora repositório Git
- Detecta mudanças
- Aplica manifests automaticamente

---

## 🔁 Ciclo GitOps

1. Commit no Git
2. ArgoCD detecta alteração
3. Sync automático
4. Kubernetes aplica

---

## 🔥 Recursos Utilizados

- Auto-sync
- Self-heal
- Prune

---

## ⚠️ Problema Encontrado

### Path inválido

Erro:

app path does not exist


**Causa:**
Diretório incorreto no repo

**Solução:**
Ajustar:

```yaml
path: k8s/


📌 Lições
Git é a fonte de verdade
Estrutura do repo é crítica
