-- CENÁRIO 1: Registro Seguro de Empréstimo (COMMIT/ROLLBACK)
-- Objetivo: Garante que o empréstimo só seja registrado se todos os itens forem baixados com sucesso.

START TRANSACTION; -- Inicia a transação

-- 1. Cria o registro do cabeçalho do empréstimo
INSERT INTO Emprestimos (id_usuario, data_emprestimo, data_devolucao_prevista) 
VALUES (1, CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY));

-- 2. Salva o ID gerado para usar no item
SET @ultimo_emprestimo = LAST_INSERT_ID();

-- 3. Tenta inserir o livro solicitado (Livro ID 5)
INSERT INTO Itens_Emprestimo (id_emprestimo, id_livro, quantidade_itens) 
VALUES (@ultimo_emprestimo, 5, 1);

-- 4. Simulação de Verificação de Estoque e Finalização
-- Se chegarmos aqui sem erros, confirmamos as alterações
COMMIT; 
-- Caso houvesse um erro (ex: livro inexistente), usaríamos ROLLBACK;


-- CENÁRIO 2: Trigger para Atualização Automática de Estoque
-- Objetivo: Mantém a consistência entre o acervo e as movimentações.

DELIMITER //
CREATE TRIGGER trg_atualiza_estoque_emprestimo
AFTER INSERT ON Itens_Emprestimo
FOR EACH ROW
BEGIN
    UPDATE Livros 
    SET quantidade_estoque = quantidade_estoque - NEW.quantidade_itens
    WHERE id_livro = NEW.id_livro;
END;
//
DELIMITER ;


-- CENÁRIO 3: Proteção de Dados com Rollback Manual
-- Objetivo: Impedir exclusões acidentais de registros com dependências.

START TRANSACTION;

-- Tentativa de exclusão de usuário (ID 1)
DELETE FROM Usuarios WHERE id_usuario = 1;

-- Auditoria interna: Se o sistema detectar que o usuário tem livros pendentes
-- Executamos o ROLLBACK para desfazer a exclusão
ROLLBACK; 
