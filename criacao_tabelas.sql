-- CRIAÇÃO DE TABELAS

-- Tabela de Categorias: Armazena a classificação literária (Ex: Ficção, Acadêmico).
CREATE TABLE Categorias (
    id_categoria SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL UNIQUE
);

-- Tabela de Editoras: Cadastro de fornecedores de conteúdo.
CREATE TABLE Editoras (
    id_editora SERIAL PRIMARY KEY,
    nome_editora VARCHAR(100) NOT NULL,
    cidade VARCHAR(50),
    contato VARCHAR(50)
);

-- Tabela de Autores: Gestão de nomes e origens dos escritores.
CREATE TABLE Autores (
    id_autor SERIAL PRIMARY KEY,
    nome_autor VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

-- Tabela de Livros: Centraliza os dados do acervo.
CREATE TABLE Livros (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    isbn VARCHAR(13) NOT NULL UNIQUE,
    ano_publicacao INT,
    id_editora INT NOT NULL,
    id_categoria INT NOT NULL,
    CONSTRAINT fk_livro_editora FOREIGN KEY (id_editora) REFERENCES Editoras(id_editora),
    CONSTRAINT fk_livro_categoria FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

-- Tabela de Usuarios: Identificação única via CPF.
CREATE TABLE Usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100),
    telefone VARCHAR(15)
);

-- Tabela de Emprestimos: Cabeçalho da transação de circulação.
CREATE TABLE Emprestimos (
    id_emprestimo SERIAL PRIMARY KEY,
    data_emprestimo DATE NOT NULL,
    data_devolucao_prevista DATE NOT NULL,
    data_devolucao_real DATE,
    id_usuario INT NOT NULL,
    CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    CONSTRAINT chk_datas_emprestimo CHECK (data_devolucao_prevista >= data_emprestimo)
);

-- Tabela Associativa: Relacionamento Muitos-para-Muitos (N:N) entre Livros e Autores.
CREATE TABLE Livro_Autor (
    id_livro INT NOT NULL,
    id_autor INT NOT NULL,
    PRIMARY KEY (id_livro, id_autor),
    CONSTRAINT fk_la_livro FOREIGN KEY (id_livro) REFERENCES Livros(id_livro),
    CONSTRAINT fk_la_autor FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
);

-- Tabela Associativa: Relacionamento N:N entre Empréstimos e Livros (Itens da transação).
CREATE TABLE Itens_Emprestimo (
    id_emprestimo INT NOT NULL,
    id_livro INT NOT NULL,
    PRIMARY KEY (id_emprestimo, id_livro),
    CONSTRAINT fk_ie_emprestimo FOREIGN KEY (id_emprestimo) REFERENCES Emprestimos(id_emprestimo),
    CONSTRAINT fk_ie_livro FOREIGN KEY (id_livro) REFERENCES Livros(id_livro)
);
