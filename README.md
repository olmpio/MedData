# 🩺 MedData — Sistema de Gestão de Clínica Médica

<p align="center">
  <img src="https://img.shields.io/badge/Status-Em%20Desenvolvimento-blueviolet?style=for-the-badge" alt="Status: Em Desenvolvimento">
  <img src="https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="SQL">
</p>

## 📋 Sobre o Projeto

O **MedData** é um projeto acadêmico de banco de dados relacional voltado para o gerenciamento completo de uma clínica médica. O sistema foi estruturado para garantir a integridade referencial, otimização de consultas e automação de regras de negócio essenciais no setor de saúde, abrangendo desde o cadastro de pacientes até o controle financeiro de pagamentos.

---

## 🎯 Escopo do Sistema

O banco de dados gerencia as seguintes entidades e relações principais:
- **Pessoas e Atores:** Pacientes e Médicos.
- **Organização:** Especialidades médicas e Departamentos/Consultórios.
- **Atendimento:** Consultas médicas, Exames laboratoriais/de imagem e Receituários.
- **Suprimentos:** Catálogo de medicamentos.
- **Financeiro:** Controle e registro de pagamentos.

---

## 🛠️ Tecnologias e Ferramentas

* **SGBD:** PostgreSQL (gerenciamento e execução de scripts DDL/DML/DQL)
* **Linguagem:** SQL (Structured Query Language)
* **Ferramenta de Apoio:** DBeaver (modelagem, testes e gerenciamento do banco)
* **Versionamento:** Git & GitHub

---

## 🚀 Status do Desenvolvimento

- [x] **DDL (Data Definition Language):** Criação de tabelas, restrições, chaves primárias (PK) e estrangeiras (FK).
- [x] **DML (Data Manipulation Language):** População do banco com dados fictícios e consistentes para testes.
- [x] **DQL (Data Query Language):** Consultas avançadas utilizando `JOIN`s, subconsultas e ordenações.
- [ ] **Visões e Automação:** Implementação de `Views` analíticas, `Triggers` de auditoria/consistência e `Procedures` armazenadas.

---

## 📚 Conceitos Aplicados

* **Modelagem Relacional:** Normalização (até a 3ª Forma Normal - 3NF) para evitar redundâncias.
* **Integridade Referencial:** Uso rigoroso de Chaves Primárias (PK) e Estrangeiras (FK) com regras de cascata/restrição (`ON DELETE`, `ON UPDATE`).
* **Consultas Complexas:** Junções múltiplas (`INNER JOIN`, `LEFT JOIN`), agregações (`GROUP BY`, `HAVING`) e filtragem avançada.
* **Programação em Banco:** Uso de blocos PL/pgSQL para lógica complexa de negócios via **Triggers** e **Stored Procedures**.

---

## 📂 Estrutura do Repositório

*(Exemplo de organização de pastas sugerida)*
```text
├── database/
│   ├── 01_ddl.sql          # Criação do esquema e tabelas
│   ├── 02_dml.sql          # Inserção de dados iniciais (Seed)
│   ├── 03_dql.sql          # Consultas e relatórios analíticos
│   └── 04_views_triggers.sql # Views, Triggers e Procedures
├── docs/
│   ├── MER.png             # Modelo Entidade-Relacionamento
│   └── Dicionario_de_Dados.md
└── README.md

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

