🩺 Sistema de Gestão de Clínica Médica - MedData

Status: 🚀 Em Desenvolvimento (Etapas DDL, DML e DQL Concluídas)

❇️ Projeto acadêmico de Banco de Dados SQL para gerenciamento de uma clínica médica.

✍️ Sobre

O sistema permite gerenciar pacientes, médicos, especialidades, consultas, exames, receitas, medicamentos e pagamentos.

🛠️ Tecnologias 

- PostgreSQL
- SQL
- DBeaver
- GitHub

📚 Conceitos

Chaves primárias (PK), Chaves estrangeiras (FK), Relacionamentos, Normalização, JOINs, Views, Triggers e Procedures.

👥 Equipe

| Nome |
|----------------------------------------|
| 1- Pedro Olímpio Arantes Freire Brandão |
| 2- Gabriel de Oliveira de Assis |
| 3- Eduardo Almeida |

📂 Estrutura do Repositório

- `/ddl`: Scripts de criação das tabelas e relacionamentos (`CREATE TABLE`).
- `/dml`: Scripts de povoamento e carga de dados (`INSERT`).
- `/dql`: Consultas relacionais (`SELECT` com `INNER`, `LEFT`, `RIGHT JOIN` e `GROUP BY`), um arquivo por consulta.
- `script_banco.sql`: Script unificado completo (`DROP` → `CREATE` → `INSERT`) para execução sequencial.

---

# Modelagem de Banco de Dados — MedData

## 1. Entidades

1. **Paciente** — armazena os dados dos pacientes da clínica.
2. **Médico** — armazena os dados dos médicos que trabalham na clínica.
3. **Especialidade** — representa as especialidades médicas dos profissionais.
4. **Consulta** — registra os atendimentos realizados ou agendados.
5. **Exame** — armazena os tipos de exames disponíveis na clínica.
6. **Consulta_Exame** — relaciona as consultas aos exames solicitados (associativa).
7. **Receita** — registra as receitas emitidas pelos médicos.
8. **Medicamento** — armazena os medicamentos que podem ser prescritos.
9. **Receita_Medicamento** — relaciona as receitas aos medicamentos prescritos (associativa).
10. **Convênio** — armazena os convênios aceitos pela clínica.
11. **Pagamento** — registra os pagamentos relacionados às consultas.

---

## 2. Justificativa do domínio

O domínio escolhido foi um **Sistema de Gestão Interna de Clínica Médica**, com o objetivo de organizar e centralizar as informações utilizadas no funcionamento da clínica.

O sistema permitirá o gerenciamento de pacientes, médicos, especialidades, consultas, exames, receitas, medicamentos, convênios e pagamentos.

A escolha desse domínio possibilita trabalhar diferentes tipos de relacionamentos e aplicar conceitos de modelagem de banco de dados e seus relacionamentos.

---

## 3. Atributos das Entidades

### Convênio
- `id` (PK)
- `nome`
- `numero_registro` (UNIQUE)
- `telefone`
- `ativo`

### Especialidade
- `id` (PK)
- `nome` (UNIQUE)
- `descricao`

### Exame
- `id` (PK)
- `nome` (UNIQUE)
- `descricao`
- `valor`

### Medicamento
- `id` (PK)
- `nome`
- `principio_ativo`
- `fabricante`

### Paciente
- `id` (PK)
- `nome`
- `cpf` (UNIQUE)
- `data_nascimento`
- `telefone`
- `email` (UNIQUE)
- `endereco`
- `ativo`
- `id_convenio` (FK)

### Médico
- `id` (PK)
- `nome`
- `crm` (UNIQUE)
- `telefone`
- `email` (UNIQUE)
- `ativo`
- `id_especialidade` (FK)

### Consulta
- `id` (PK)
- `data_consulta`
- `horario`
- `motivo`
- `diagnostico`
- `observacoes`
- `status`
- `id_paciente` (FK)
- `id_medico` (FK)

### Consulta_Exame
- `id` (PK)
- `id_consulta` (FK)
- `id_exame` (FK)
- `data_exame`
- `resultado`
- `status`

### Receita
- `id` (PK)
- `id_consulta` (FK, UNIQUE)
- `data_receita`
- `instrucoes`

### Receita_Medicamento
- `id` (PK)
- `id_receita` (FK)
- `id_medicamento` (FK)
- `dosagem`
- `frequencia`
- `duracao`

### Pagamento
- `id` (PK)
- `id_consulta` (FK, UNIQUE)
- `valor`
- `data_pagamento`
- `forma_pagamento`
- `status`

---

## Relacionamentos

* **Convênio** `1 ─── N` **Paciente**
* **Especialidade** `1 ─── N` **Médico**
* **Paciente** `1 ─── N` **Consulta**
* **Médico** `1 ─── N` **Consulta**
* **Consulta** `N ─── N` **Exame** *(via Consulta_Exame)*
* **Consulta** `1 ─── 0..1` **Receita**
* **Receita** `N ─── N` **Medicamento** *(via Receita_Medicamento)*
* **Consulta** `1 ─── 0..1` **Pagamento**

> **Nota:** Todos os relacionamentos e restrições de integridade referencial (*Foreign Keys*) foram devidamente implementados via DDL com tratamento de ações de deleção (`ON DELETE RESTRICT`, `ON DELETE CASCADE` e `ON DELETE SET NULL`).

---

## 4. Consultas Relacionais (DQL)

As consultas ficam em `/dql`, numeradas na ordem da atividade. Cada arquivo traz um cabeçalho com o objetivo, o critério adotado e os tipos de JOIN utilizados.

| # | Arquivo | Consulta | Recursos |
|---|---------|----------|----------|
| 01 | `01_faturamento_convenio_especialidade.sql` | Faturamento bruto por convênio e especialidade | INNER, LEFT, GROUP BY |
| 02 | `02_exames_mais_solicitados.sql` | Exames mais solicitados no período | INNER, GROUP BY |
| 03 | `03_pacientes_inativos.sql` | Pacientes sem consultas nos últimos 6 meses | LEFT (anti-join) |
| 04 | `04_cancelamentos_por_medico.sql` | Consultas canceladas por médico | LEFT, GROUP BY |
| 05 | `05_medicamentos_por_especialidade.sql` | Prescrições de cada medicamento por especialidade | INNER, GROUP BY |
| 06 | `06_glosas_estimadas.sql` | Consultas realizadas com pagamento pendente, por convênio | INNER, LEFT, GROUP BY |
| 07 | `07_valor_medio_exames_por_paciente.sql` | Valor médio dos exames realizados por paciente | INNER, GROUP BY, AVG |
| 08 | `08_medicos_sem_consultas_proxima_semana.sql` | Médicos sem consultas agendadas na próxima semana | LEFT (anti-join) |
| 09 | `09_pacientes_por_faixa_etaria.sql` | Quantidade de pacientes por faixa etária | CASE, GROUP BY |
| 10 | `10_receitas_sem_medicamentos.sql` | Receitas sem medicamento associado | RIGHT (anti-join) |
| 11 | `11_atendimentos_por_medico_mes_atual.sql` | Atendimentos realizados por médico no mês atual | LEFT, GROUP BY |
| 12 | `12_pacientes_plano_ouro.sql` | Pacientes do convênio Plano Ouro | INNER |
| 13 | `13_faturamento_por_especialidade_ultimo_ano.sql` | Faturamento por especialidade nos últimos 12 meses | INNER, RIGHT, GROUP BY |
| 14 | `14_exames_sem_resultado.sql` | Exames realizados sem resultado registrado | INNER |
| 15 | `15_medicos_multiplas_especialidades.sql` | Médicos com mais de uma especialidade | INNER, GROUP BY, HAVING |
| 16 | `16_tempo_medio_consulta_exame.sql` | Tempo médio (dias) entre consulta e exame | INNER, AVG |
| 17 | `17_top3_convenios_receita.sql` | Três convênios com maior receita | INNER, GROUP BY, LIMIT |
| 18 | `18_pacientes_doencas_cronicas.sql` | Pacientes com diagnóstico de condição crônica | INNER, ILIKE ANY |
| 19 | `19_pagamentos_cartao_credito.sql` | Total pago com cartão de crédito | GROUP BY, SUM |
| 20 | `20_relatorio_consolidado.sql` | Paciente, médico, data, valor e status do pagamento | INNER, LEFT |

### Critérios adotados

- **Faturamento bruto** considera todos os pagamentos lançados (pagos e pendentes); **receita** considera apenas os pagamentos com status `Pago`.
- **Exame realizado** é aquele com `data_exame` preenchida e não futura.
- **Atendimento** é uma consulta com status `Realizada`.
- Pacientes sem convênio aparecem como `Particular` nas consultas agrupadas por convênio.
- As datas são relativas a `CURRENT_DATE`, acompanhando a carga de dados do `script_banco.sql`.

### Como executar

1. Execute `script_banco.sql` em um banco PostgreSQL para criar e popular as tabelas.
2. Abra qualquer arquivo de `/dql` no DBeaver (ou `psql`) e execute.

> **Observação:** com a carga de exemplo atual, as consultas 03, 10, 12, 14, 15 e 18 retornam zero linhas porque os dados não possuem casos que atendam aos critérios (ex.: não existe o convênio *Plano Ouro* nem diagnósticos de doenças crônicas). Todas foram validadas com registros de teste.

> **Limitação do modelo:** a tabela `medico` possui uma única especialidade (`id_especialidade`). Por isso, a consulta 15 identifica o mesmo profissional cadastrado em mais de uma especialidade. Uma evolução recomendada é criar a associativa `medico_especialidade` (N:N).

