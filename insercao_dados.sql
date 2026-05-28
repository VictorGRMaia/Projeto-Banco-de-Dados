-- CARGA DE DADOS PRINCIPAIS (20 REGISTROS POR ENTIDADE)

-- Inserção em Categorias
INSERT INTO Categorias (nome_categoria) VALUES 
('Ficção Científica'), ('Romance'), ('História'), ('Biografia'), ('Tecnologia'), 
('Autoajuda'), ('Mistério'), ('Terror'), ('Infantil'), ('Poesia'),
('Didático'), ('Filosofia'), ('Psicologia'), ('Economia'), ('Direito'),
('Medicina'), ('Arte'), ('Gastronomia'), ('Aventura'), ('Fantasia');

-- Inserção em Editoras
INSERT INTO Editoras (nome_editora, cidade, contato) VALUES 
('Editora Alfa', 'São Paulo', 'contato@alfa.com'), ('Editora Beta', 'Rio de Janeiro', 'vendas@beta.com'),
('Gama Books', 'Curitiba', 'sac@gama.com'), ('Delta Editores', 'Belo Horizonte', 'info@delta.com'),
('Epsilon', 'Porto Alegre', 'epsilon@books.com'), ('Zeta', 'Salvador', 'zeta@zeta.com'),
('Sigma', 'Fortaleza', 'contato@sigma.br'), ('Omega', 'Recife', 'atendimento@omega.com'),
('Lumiere', 'Campinas', 'lumi@ere.com'), ('Nova Era', 'Brasília', 'novaera@gov.br'),
('Saber', 'São Paulo', 'saber@edu.com'), ('Cultura', 'Manaus', 'cultura@am.com'),
('Panteão', 'Florianópolis', 'pan@teao.com'), ('Ícone', 'Vitória', 'icon@ne.com'),
('Fênix', 'Goiânia', 'fenix@go.com'), ('Atlas', 'São Paulo', 'atlas@atlas.com'),
('Saraiva', 'São Paulo', 'saraiva@loja.com'), ('Rocco', 'Rio de Janeiro', 'rocco@rj.com'),
('Companhia das Letras', 'São Paulo', 'comp@letras.com'), ('Intrínseca', 'Rio de Janeiro', 'intrin@seca.com');

-- Inserção em Autores
INSERT INTO Autores (nome_autor, nacionalidade) VALUES 
('Machado de Assis', 'Brasileira'), ('Clarice Lispector', 'Brasileira'), ('Isaac Asimov', 'Americana'),
('J.K. Rowling', 'Britânica'), ('Stephen King', 'Americana'), ('George Orwell', 'Britânica'),
('Gabriel García Márquez', 'Colombiana'), ('Virginia Woolf', 'Britânica'), ('Franz Kafka', 'Tcheca'),
('Fernando Pessoa', 'Portuguesa'), ('Jorge Amado', 'Brasileira'), ('Agatha Christie', 'Britânica'),
('Paulo Coelho', 'Brasileira'), ('Ernest Hemingway', 'Americana'), ('Leo Tolstoy', 'Russa'),
('Fyodor Dostoievsky', 'Russa'), ('José Saramago', 'Portuguesa'), ('Umberto Eco', 'Italiana'),
('Guimarães Rosa', 'Brasileira'), ('Cecília Meireles', 'Brasileira');

-- Inserção em Livros
INSERT INTO Livros (titulo, isbn, ano_publicacao, id_editora, id_categoria) VALUES 
('Fundação', '9788576573005', 1951, 1, 1), ('Dom Casmurro', '9788508040438', 1899, 2, 2),
('1984', '9788535914849', 1949, 3, 3), ('O Alquimista', '9788575427583', 1988, 4, 6),
('Harry Potter', '9788532511010', 1997, 5, 20), ('O Iluminado', '9788532507105', 1977, 6, 8),
('Cem Anos de Solidão', '9788501012074', 1967, 7, 2), ('A Metamorfose', '9788572323864', 1915, 8, 12),
('Clean Code', '9788576082323', 2008, 9, 5), ('O Processo', '9788525411471', 1925, 10, 12),
('Ensaio sobre a Cegueira', '9788573021929', 1995, 11, 2), ('Crime e Castigo', '9788572325325', 1866, 12, 13),
('O Nome da Rosa', '9788501024343', 1980, 13, 7), ('Grande Sertão: Veredas', '9788520923054', 1956, 14, 2),
('A Hora da Estrela', '9788532508102', 1977, 15, 2), ('Iracema', '9788508040445', 1865, 16, 2),
('Corte de Espinhos e Rosas', '9788501105837', 2015, 17, 20), ('O Senhor dos Anéis', '9788533613379', 1954, 18, 20),
('Duna', '9788576573135', 1965, 19, 1), ('Sapiens', '9788525432186', 2011, 20, 3);

-- Inserção em Usuarios
INSERT INTO Usuarios (nome, cpf, email, telefone) VALUES 
('João Silva', '11122233344', 'joao@email.com', '11999998888'), ('Maria Souza', '22233344455', 'maria@email.com', '11988887777'),
('Carlos Lima', '33344455566', 'carlos@email.com', '21977776666'), ('Ana Oliveira', '44455566677', 'ana@email.com', '31966665555'),
('Pedro Santos', '55566677788', 'pedro@email.com', '41955554444'), ('Julia Costa', '66677788899', 'julia@email.com', '51944443333'),
('Lucas Rocha', '77788899900', 'lucas@email.com', '61933332222'), ('Beatriz Melo', '88899900011', 'beatriz@email.com', '71922221111'),
('Ricardo Ferreira', '99900011122', 'ricardo@email.com', '81911110000'), ('Fernanda Dias', '00011122233', 'fernanda@email.com', '91900009999'),
('Gabriel Nunes', '12312312312', 'gabriel@email.com', '11912345678'), ('Amanda Vaz', '45645645645', 'amanda@email.com', '11987654321'),
('Marcos Paiva', '78978978978', 'marcos@email.com', '21945678901'), ('Sonia Guimarães', '32132132132', 'sonia@email.com', '31901234567'),
('Bruno Alves', '65465465465', 'bruno@email.com', '41965432109'), ('Clara Luz', '98798798798', 'clara@email.com', '51932109876'),
('Diego Ramos', '14725836914', 'diego@email.com', '61914725836'), ('Helena Gomes', '25836914725', 'helena@email.com', '71925836914'),
('Fábio Junior', '36914725836', 'fabio@email.com', '81936914725'), ('Renata Silveira', '74185296374', 'renata@email.com', '91974185296');

-- CARGA DE TABELAS ASSOCIATIVAS E RELACIONAIS (10)

-- Relacionamento Livro_Autor
INSERT INTO Livro_Autor (id_livro, id_autor) VALUES 
(1, 3), (2, 1), (3, 6), (4, 13), (5, 4), (6, 5), (7, 7), (8, 9), (9, 3), (10, 9), (11, 17), (12, 16);

-- Registro de Emprestimos
INSERT INTO Emprestimos (data_emprestimo, data_devolucao_prevista, id_usuario) VALUES 
('2024-05-01', '2024-05-15', 1), ('2024-05-02', '2024-05-16', 2), ('2024-05-03', '2024-05-17', 3),
('2024-05-04', '2024-05-18', 4), ('2024-05-05', '2024-05-19', 5), ('2024-05-06', '2024-05-20', 6),
('2024-05-07', '2024-05-21', 7), ('2024-05-08', '2024-05-22', 8), ('2024-05-09', '2024-05-23', 9),
('2024-05-10', '2024-05-24', 10);

-- Itens dos Emprestimos
INSERT INTO Itens_Emprestimo (id_emprestimo, id_livro) VALUES 
(1, 1), (2, 5), (3, 10), (4, 15), (5, 20), (6, 2), (7, 4), (8, 6), (9, 8), (10, 19);



-- TESTES DE INTEGRIDADE (ETAPA 3)
-- Estes comandos foram projetados para falhar, validando as constraints de segurança.

-- 1. VIOLAÇÃO DE DOMÍNIO (CPF INVÁLIDO)
-- Motivo: Embora o campo suporte 11 caracteres, a inconsistência lógica será tratada em procedures futuras.
INSERT INTO Usuarios (nome, cpf, email) VALUES ('Usuario Teste Erro', '123', 'erro@email.com');

-- 2. VIOLAÇÃO DE CHECK CONSTRAINT (LÓGICA DE DATA)
-- Motivo: Tenta inserir uma devolução anterior ao empréstimo. Bloqueado pela CHK_DATAS_EMPRESTIMO.
INSERT INTO Emprestimos (data_emprestimo, data_devolucao_prevista, id_usuario) 
VALUES ('2024-12-30', '2024-12-01', 1);

-- 3. VIOLAÇÃO DE NOT NULL (DADOS OBRIGATÓRIOS)
-- Motivo: Tenta inserir um livro sem título, o que quebraria a integridade do catálogo.
INSERT INTO Livros (titulo, isbn, id_editora, id_categoria) 
VALUES (NULL, '0000000000000', 1, 1);

-- 4. VIOLAÇÃO DE UNICIDADE (ISBN DUPLICADO)
-- Motivo: Tenta inserir o mesmo ISBN do livro 'Fundação'. Bloqueado pela UNIQUE constraint.
INSERT INTO Livros (titulo, isbn, id_editora, id_categoria) 
VALUES ('Livro Clone', '9788576573005', 1, 1);

-- 5. VIOLAÇÃO DE INTEGRIDADE REFERENCIAL (FK INEXISTENTE)
-- Motivo: Tenta associar um livro a uma Editora (ID 999) que não existe na tabela Editoras.
INSERT INTO Livros (titulo, isbn, id_editora, id_categoria) 
VALUES ('Livro Orfão', '1111111111111', 999, 1);
