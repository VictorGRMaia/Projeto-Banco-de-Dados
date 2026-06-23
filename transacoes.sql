-- ========================================================================
-- ETAPA 4: TRANSAÇÕES, TRIGGERS E FINALIZAÇÃO
-- ========================================================================

-- ------------------------------------------------------------------------
-- CENÁRIO 1: Registro Seguro de Empréstimo (COMMIT/ROLLBACK)
-- Objetivo: Garante atomicidade. O empréstimo só se consolida se o cabeçalho
--           e os itens forem inseridos com sucesso.
-- ------------------------------------------------------------------------

BEGIN; -- Inicia a transação no PostgreSQL (pode usar START TRANSACTION também)

-- 1. Cria o registro do cabeçalho do empréstimo (Usuário ID 1)
INSERT INTO Emprestimos (data_emprestimo, data_devolucao_prevista, id_usuario) 
VALUES (CURRENT_DATE, CURRENT_DATE + INTERVAL '7 days', 1);

-- 2 e 3. Insere o item utilizando lastval() para capturar o ID do empréstimo recém-gerado
INSERT INTO Itens_Emprestimo (id_emprestimo, id_livro) 
VALUES (lastval(), 5);

-- 4. Se ambos os comandos rodarem sem erro, confirmamos as alterações definitivamente
COMMIT; 


-- ------------------------------------------------------------------------
-- CENÁRIO 2: Trigger para Atualização Automática de Estoque
-- Objetivo: Mantém a consistência diminuindo o estoque do livro emprestado.
-- ------------------------------------------------------------------------

-- Passo A: Adiciona a coluna de estoque na tabela Livros (necessário para o teste)
ALTER TABLE Livros ADD COLUMN quantidade_estoque INT DEFAULT 10;

-- Passo B: Criação da função que contém a lógica da Trigger
CREATE OR REPLACE FUNCTION fn_atualiza_estoque_emprestimo()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Livros 
    SET quantidade_estoque = quantidade_estoque - 1
    WHERE id_livro = NEW.id_livro;
    
    RETURN NEW; -- Retorna o registro inserido
END;
$$ LANGUAGE plpgsql;

-- Passo C: Criação do gatilho (Trigger) associado à tabela associativa
CREATE OR REPLACE TRIGGER trg_atualiza_estoque_emprestimo
AFTER INSERT ON Itens_Emprestimo
FOR EACH ROW
EXECUTE FUNCTION fn_atualiza_estoque_emprestimo();


-- ------------------------------------------------------------------------
-- CENÁRIO 3: Proteção de Dados com Rollback Manual
-- Objetivo: Simular um erro operacional de exclusão e desfazê-lo a tempo.
-- ------------------------------------------------------------------------

BEGIN;

-- Simulação: O administrador executa um comando de exclusão do Usuário ID 11 por engano
DELETE FROM Usuarios WHERE id_usuario = 11;

-- Verificação mental/auditoria: "Ih, deletei o usuário errado!"
-- Enquanto não dermos COMMIT, os outros usuários do sistema não enxergam essa exclusão.
-- Executamos o ROLLBACK para restaurar o dado imediatamente:
ROLLBACK;
