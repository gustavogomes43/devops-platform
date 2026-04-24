# 🌐 Network Architecture

## 📐 CIDR e Segmentação

- VPC: 10.0.0.0/16

Subnets:

| Tipo     | AZ           | CIDR        |
|----------|-------------|------------|
| Public   | us-east-1a  | 10.0.1.0/24 |
| Public   | us-east-1b  | 10.0.2.0/24 |
| Private  | us-east-1a  | 10.0.11.0/24 |
| Private  | us-east-1b  | 10.0.12.0/24 |

---

## 🌍 Internet Access

### Internet Gateway
- Associado à VPC
- Permite tráfego de entrada/saída nas subnets públicas

---

### NAT Gateway

- Implantado em subnet pública
- Permite saída dos nodes privados

---

## 🔐 Segurança de Rede

### Subnets Privadas

- Sem IP público
- Sem acesso direto da internet

---

### Security Groups

- Controle de tráfego granular
- Apenas portas necessárias liberadas

---

## ⚠️ Problema Crítico Encontrado

### Erro: Subnet sem Auto-Assign Public IP

**Impacto:**
- Node Group não criava

**Erro:**
Ec2SubnetInvalidConfiguration

**Causa:**
Subnets públicas sem auto-assign habilitado

**Solução:**
Ativar:

```bash
Auto-assign public IPv4 address = ENABLED
