# Projeto E-commerce Olist - Machine Learning 🛍️

Este repositório contém o pipeline completo de Ciência de Dados aplicado ao dataset da **Olist**, o maior marketplace de e-commerce brasileiro.  
O projeto segue uma abordagem híbrida, unindo o rigor técnico do processo **KDD (Knowledge Discovery in Databases)** à visão estratégica do framework **CRISP-DM**.

---

# 🎯 Objetivos e Contexto de Negócio

O projeto simula um cenário real de consultoria para um e-commerce com uma base de dados superior a **100 mil registros** (período de 2016 a 2018).

Os principais objetivos são:

- **Identificação de Clientes VIP**  
  Mapear consumidores de alto valor para estratégias de fidelização.

- **Previsão de Churn**  
  Identificar padrões que sinalizam o possível abandono de clientes da plataforma.

- **Data Storytelling**  
  Traduzir métricas técnicas em decisões de negócio através de um dashboard interativo utilizando **Streamlit**.

---

# 🚀 Roadmap e Status do Projeto

A fase de **Preparação e Limpeza** representa aproximadamente **70% do tempo total do projeto**, devido à complexidade dos dados reais de varejo.

## 📅 Abril — Alinhamento e Seleção *(Concluído)*

- Definição do problema de negócio
- Benchmarking
- Coleta de dados via Kaggle

## 📅 Maio — A Fase Laboriosa *(Em andamento)*

- Limpeza de valores nulos
- Remoção de duplicatas
- Tratamento de outliers utilizando o método **IQR**

### 🔹 Divisão por tabelas

Cada integrante é responsável pelo tratamento completo de uma entidade:

- Clientes
- Itens
- Pagamentos
- Pedidos
- Produtos
- Avaliações

Essa divisão garante maior agilidade e aprendizado prático durante o desenvolvimento.

## 📅 Junho — Modelagem

- Divisão do dataset em:
  - Treino
  - Teste
  - Validação

- Seleção de algoritmos de Machine Learning:
  - Random Forest
  - K-Means
  - Outros modelos comparativos

## 📅 Julho — Avaliação e Implantação

- Validação estatística
- Matriz de Confusão
- Testes de hipótese
- Persistência do modelo em formato `.pkl`

---

# 🛠️ Configuração do Ambiente e Reprodutibilidade

Para evitar o erro comum **"Import could not be resolved"** e garantir que todas as bibliotecas de gráficos e análise funcionem corretamente, siga os passos abaixo.

---

## 1️⃣ Reconstrução do Ambiente Virtual (VENV)

No terminal do VS Code, dentro da pasta do projeto:

```bash
python -m venv .venv
```

---

## 2️⃣ Ativação e Resolução de Problemas (CRÍTICO)

Se o ambiente `.venv` não for detectado automaticamente:

1. Pressione `Ctrl + Shift + P`
2. Digite:
   ```text
   Python: Select Interpreter
   ```
3. Selecione o interpretador localizado dentro da pasta `.venv`

### Ativação manual no terminal

#### Windows

```bash
.\.venv\Scripts\activate
```

#### Mac/Linux

```bash
source .venv/bin/activate
```

---

## 3️⃣ Instalação de Dependências

Com o prefixo `(.venv)` visível no terminal, execute:

```bash
pip install -r requirements.txt
```

Para a visualização dos gráficos, instale:

```bash
pip install pandas seaborn matplotlib sqlalchemy psycopg2-binary
```

---

## 4️⃣ Configuração do Arquivo `.env`

Crie um arquivo chamado `.env` na raiz do projeto e adicione as variáveis abaixo:

```env
SUPABASE_URL=https://vneccntzthmtklbhzgqd.supabase.co
SUPABASE_KEY=sb_publishable_huJ0xIo_Xegm_nvjxCMPiQ_ljX-dNG0
```

---

# 📂 Organização das Camadas (Arquitetura Medallion)

## 🥉 Bronze

Dados brutos e originais ingeridos via Supabase.

---

## 🥈 Silver

Dados limpos e padronizados.  
As transformações e o tratamento de outliers ocorrem nesta fase.

---

## 🥇 Gold

Tabelas agregadas por identificador de cliente, prontas para:

- Mineração de padrões
- Dashboards de negócio
- Modelagem preditiva
- Insights estratégicos

---

# 📌 Tecnologias Utilizadas

- Python
- Pandas
- Matplotlib
- Seaborn
- SQLAlchemy
- PostgreSQL / Supabase
- Streamlit
- Scikit-Learn

---

# 📈 Metodologias Aplicadas

- KDD (Knowledge Discovery in Databases)
- CRISP-DM
- Arquitetura Medallion
- Data Storytelling
- Machine Learning Supervisionado e Não Supervisionado