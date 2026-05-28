Projeto de Banco de Dados: Sistema de Controle de Biblioteca

1. Objetivo do Projeto
O objetivo deste projeto é o desenvolvimento de um sistema de banco de dados relacional para automatizar o gerenciamento de uma biblioteca.O sistema visa substituir
controles manuais por uma solução robusta que garanta a integridade dos dados, facilite a busca por obras e controle rigorosamente os prazos de empréstimos e devoluções.

3. Escopo do Projeto
O sistema abrange as seguintes funcionalidades e controles:
Gestão de Acervo: Cadastro detalhado de livros, incluindo ISBN, ano de publicação, editoras e autores.
Controle de Usuários: Registro completo de leitores com CPF, e-mail e dados de contato.
Fluxo de Empréstimos: Registro de saídas de livros com cálculo automático de datas de devolução prevista.
Monitoramento de Devoluções: Atualização de status e controle de exemplares disponíveis no estoque.
Integridade de Dados: Uso de regras de negócio (constraints) para evitar empréstimos de livros sem estoque ou para usuários não cadastrados.

4. Estrutura do Repositório
Para a entrega da Etapa 2, este repositório contém os seguintes arquivos:
criacao_tabelas.sql: Script DDL contendo a criação das tabelas e definições de chaves primárias e estrangeiras.
insercao_dados.sql: Script DML com a carga inicial de dados (mínimo de 20 registros por tabela) e dados para testes de erro.
modelo_conceitual.png: Imagem do Diagrama Entidade-Relacionamento (DER).
modelo_logico.png: Imagem da estrutura lógica das tabelas.
