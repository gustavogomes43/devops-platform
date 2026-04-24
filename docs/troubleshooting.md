# 🧠 Troubleshooting Real

## 🔥 1. VPC não deletava

Erro:
DependencyViolation


---

### Causa

- NAT Gateway ativo
- Elastic IP associado

---

### Solução

1. Identificar NAT
2. Deletar NAT Gateway
3. Liberar EIP

---

## 🔥 2. Permissão AWS

Erro:
AuthFailure


---

### Causa

- Role sem permissão EC2

---

### Solução

Adicionar policy:

- ec2:*
- iam:PassRole

---

## 🔥 3. Node Group falhando

Erro:
CREATE_FAILED


---

### Causa

Subnets mal configuradas

---

## 📌 Lições Finais

- AWS possui dependências implícitas
- Debug exige visão sistêmica
- IAM é frequentemente o gargalo
