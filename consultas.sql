--Consulta 1: Ranking de Autores com Maior Acervo  
--Objetivo: Identificar quais autores possuem a maior quantidade de títulos cadastrados para otimização de compras e marketing. Utiliza `JOIN`, `COUNT` e `GROUP BY`.

SELECT 
    A.nome AS autor, 
    COUNT(L.id_livro) AS total_livros
FROM Autores A
INNER JOIN Livro_Autor LA ON A.id_autor = LA.id_autor
INNER JOIN Livros L ON LA.id_livro = L.id_livro
GROUP BY A.id_autor, A.nome
ORDER BY total_livros DESC;

--Consulta 2: Relatório de Inadimplência Recorrente  
--Objetivo: Filtrar usuários que possuem **2 ou mais atrasos ativos**, permitindo ações de cobrança mais incisivas. Utiliza `Subquery` e `HAVING`.

SELECT 
    U.nome, 
    U.email, 
    COUNT(E.id_emprestimo) AS total_itens_atrasados
FROM Usuarios U
JOIN Emprestimos E ON U.id_usuario = E.id_usuario
WHERE E.data_devolucao_efetiva IS NULL 
  AND E.data_devolucao_prevista < CURRENT_DATE
  AND U.id_usuario IN (
      SELECT id_usuario 
      FROM Emprestimos 
      WHERE data_devolucao_efetiva IS NULL
      GROUP BY id_usuario
      HAVING COUNT(*) >= 2   -- Filtra inadimplentes recorrentes
  )
GROUP BY U.id_usuario, U.nome, U.email
ORDER BY total_itens_atrasados DESC;


--Consulta 3: Categorias Mais Populares  
--Objetivo: Analisar quais gêneros literários têm maior saída. Utiliza múltiplos `JOINs` entre Empréstimos, Itens e Categorias.

SELECT 
    C.nome_categoria, 
    SUM(IE.quantidade_itens) AS total_saidas
FROM Categorias C
JOIN Livros L ON C.id_categoria = L.id_categoria
JOIN Itens_Emprestimo IE ON L.id_livro = IE.id_livro
GROUP BY C.id_categoria, C.nome_categoria
ORDER BY total_saidas DESC;


--Consulta 4: KPI de Movimentação por Parceria Editorial 
--Objetivo: Avaliar o desempenho das editoras, incluindo aquelas que ainda não tiveram movimentação. Utiliza `LEFT JOIN` e `COALESCE` para evitar valores nulos.

SELECT 
    ED.nome_editora, 
    COUNT(DISTINCT L.id_livro) AS diversidade_titulos,
    COALESCE(SUM(IE.quantidade_itens), 0) AS total_itens_movimentados
FROM Editoras ED
JOIN Livros L ON ED.id_editora = L.id_editora
RIGHT JOIN  Itens_Emprestimo IE ON L.id_livro = IE.id_livro
GROUP BY ED.id_editora, ED.nome_editora
ORDER BY total_itens_movimentados DESC;


--Consulta 5: Usuários com Volume de Empréstimo Acima da Média  
--Objetivo: Identificar "superleitores" para programas de fidelidade. Utiliza `Subquery` comparativa.

SELECT 
    U.nome, 
    COUNT(E.id_emprestimo) AS total_emprestimos
FROM Usuarios U
JOIN Emprestimos E ON U.id_usuario = E.id_usuario
GROUP BY U.id_usuario, U.nome
HAVING COUNT(E.id_emprestimo) > (
    SELECT AVG(total) FROM (SELECT COUNT(*) AS total FROM Emprestimos GROUP BY id_usuario) AS media
)
ORDER BY total_emprestimos DESC;

---

---View 1: Catálogo Detalhado com Autores Agrupados
--Objetivo: Simplificar a listagem de livros, unindo os nomes dos autores em uma única linha. 

CREATE VIEW vw_catalogo_detalhado AS
SELECT 
    L.id_livro, 
    L.titulo, 
    L.isbn, 
    GROUP_CONCAT(A.nome ORDER BY A.nome SEPARATOR ', ') AS autores,
    C.nome_categoria, 
    L.quantidade_estoque
FROM Livros L
INNER JOIN Livro_Autor LA ON L.id_livro = LA.id_livro
INNER JOIN Autores A ON LA.id_autor = A.id_autor
INNER JOIN Categorias C ON L.id_categoria = C.id_categoria
GROUP BY L.id_livro, L.titulo, L.isbn, C.nome_categoria, L.quantidade_estoque;

---

--Identificação de Campos em Branco: Esta consulta cumpre a exigência de localizar registros com CPFs ou e-mails que foram deixados propositalmente em branco ou nulos para teste.
--Integridade Temporal: Registros com ano de publicação 2026 são considerados inválidos conforme a regra de negócio definida para este projeto, indicando erro de entrada de dados.

-- Auditoria de campos nulos/vazios e integridade temporal
SELECT 'Usuário' AS entidade, nome AS registro, 'CPF/Email Nulo ou Vazio' AS motivo
FROM Usuarios WHERE cpf IS NULL OR email IS NULL OR cpf = ''
UNION
SELECT 'Livro' AS entidade, titulo AS registro, 'Ano Futuro Inconsistente' AS motivo
FROM Livros WHERE ano_publicacao > 2024; -- Regra de negócio do projeto
