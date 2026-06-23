-- ========================================================================
-- ETAPA 3: CONSULTAS E RELATÓRIOS GERENCIAIS
-- ========================================================================

-- Consulta 1: Ranking de Autores com Maior Acervo
-- Objetivo: Identificar autores com mais títulos no catálogo.
SELECT 
    A.nome_autor AS autor, 
    COUNT(L.id_livro) AS total_livros
FROM Autores A
INNER JOIN Livro_Autor LA ON A.id_autor = LA.id_autor
INNER JOIN Livros L ON LA.id_livro = L.id_livro
GROUP BY A.id_autor, A.nome_autor
ORDER BY total_livros DESC;


-- Consulta 2: Relatório de Inadimplência Recorrente
-- Objetivo: Usuários com 2 ou mais empréstimos em atraso ativo.
SELECT 
    U.nome, 
    U.email, 
    COUNT(E.id_emprestimo) AS total_itens_atrasados
FROM Usuarios U
JOIN Emprestimos E ON U.id_usuario = E.id_usuario
WHERE E.data_devolucao_real IS NULL 
  AND E.data_devolucao_prevista < CURRENT_DATE
  AND U.id_usuario IN (
      SELECT id_usuario 
      FROM Emprestimos 
      WHERE data_devolucao_real IS NULL
      GROUP BY id_usuario
      HAVING COUNT(*) >= 2 
  )
GROUP BY U.id_usuario, U.nome, U.email
ORDER BY total_itens_atrasados DESC;


-- Consulta 3: Categorias Mais Populares
-- Objetivo: Gêneros (Categorias) com maior volume de saídas nos empréstimos.
SELECT 
    C.nome_categoria, 
    COUNT(IE.id_livro) AS total_saidas
FROM Categorias C
JOIN Livros L ON C.id_categoria = L.id_categoria
JOIN Itens_Emprestimo IE ON L.id_livro = IE.id_livro
GROUP BY C.id_categoria, C.nome_categoria
ORDER BY total_saidas DESC;


-- Consulta 4: KPI de Movimentação por Parceria Editorial
-- Objetivo: Desempenho das editoras (incluindo as sem nenhuma movimentação ou sem livros).
SELECT 
    ED.nome_editora, 
    COUNT(DISTINCT L.id_livro) AS diversidade_titulos,
    COUNT(IE.id_livro) AS total_itens_movimentados
FROM Livros L
RIGHT JOIN Editoras ED ON L.id_editora = ED.id_editora
LEFT JOIN Itens_Emprestimo IE ON L.id_livro = IE.id_livro
GROUP BY ED.id_editora, ED.nome_editora
ORDER BY total_itens_movimentados DESC;


-- Consulta 5: Usuários com Volume de Empréstimo Acima da Média
-- Objetivo: Identificar superleitores da biblioteca utilizando subquery comparativa.
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


-- ========================================================================
-- CRIAÇÃO DE VIEW
-- ========================================================================

-- View 1: Catálogo Detalhado com Autores Agrupados em Linha Única
CREATE OR REPLACE VIEW vw_catalogo_detalhado AS
SELECT 
    L.id_livro, 
    L.titulo, 
    L.isbn, 
    STRING_AGG(A.nome_autor, ', ' ORDER BY A.nome_autor) AS autores, 
    C.nome_categoria
FROM Livros L
INNER JOIN Livro_Autor LA ON L.id_livro = LA.id_livro
INNER JOIN Autores A ON LA.id_autor = A.id_autor
INNER JOIN Categorias C ON L.id_categoria = C.id_categoria
GROUP BY L.id_livro, L.titulo, L.isbn, C.nome_categoria;


-- ========================================================================
-- AUDITORIA DE INTEGRIDADE (ETAPA 2/3)
-- ========================================================================

-- Objetivo: Identificar falhas ou inconsistências de dados (como anos futuros).
SELECT 'Usuário' AS entidade, nome AS registro, 'CPF/Email Nulo ou Vazio' AS motivo
FROM Usuarios WHERE cpf IS NULL OR email IS NULL OR cpf = ''
UNION
SELECT 'Livro' AS entidade, titulo AS registro, 'Ano Futuro Inconsistente' AS motivo
FROM Livros WHERE ano_publicacao > EXTRACT(YEAR FROM CURRENT_DATE);
