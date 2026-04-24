
---

# 📊 docs/observability.md

```md id="obs001"
# 📊 Observabilidade

## 🎯 Objetivo

Monitorar cluster, nodes e aplicações.

---

## 🧰 Stack

- Prometheus
- Grafana
- Node Exporter

---

## ⚙️ Deploy

Via Helm:

- kube-prometheus-stack

---

## 📈 Métricas

- CPU
- Memória
- Rede
- Pods

---

## ⚠️ Problema Encontrado

### Pod Pending

Erro:

Too many pods


**Causa:**
Falta de capacidade nos nodes

---

## 📌 Solução

- Aumentar node group
- Ajustar scaling

---

## 📌 Lições

- Observabilidade depende de capacidade
- Monitoramento também consome recurso
