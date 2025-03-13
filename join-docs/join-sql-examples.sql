use TheFirstDatabase;

CREATE SCHEMA People;

CREATE SCHEMA Library;


CREATE TABLE People.Authors (
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL
);

CREATE TABLE People.Editors (
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL
);

CREATE TABLE People.Translators (
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL
);

CREATE TABLE Library.Books (
    id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    type NVARCHAR(100) NOT NULL,
    author_id INT NOT NULL,
    editor_id INT NULL,
    translator_id INT NULL,
    CONSTRAINT FK_books_authors FOREIGN KEY (author_id) REFERENCES people.authors(id) ON DELETE CASCADE,
    CONSTRAINT FK_books_editors FOREIGN KEY (editor_id) REFERENCES people.editors(id) ON DELETE SET NULL,
    CONSTRAINT FK_books_translators FOREIGN KEY (translator_id) REFERENCES people.translators(id) ON DELETE SET NULL
);

-- insert dummy data

INSERT INTO people.authors (first_name, last_name) VALUES
('Orhan', 'Pamuk'),
('Yaşar', 'Kemal'),
('Elif', 'Şafak'),
('Ahmet', 'Ümit'),
('Sabahattin', 'Ali');

INSERT INTO people.editors (first_name, last_name) VALUES
('Merve', 'Yıldız'),
('Ali', 'Kaya'),
('Zeynep', 'Demir'),
('Cem', 'Kurt'),
('Ayşe', 'Toprak'),
('Ali', 'Demir'),
('Zeynep', 'Kaya'),
('Mehmet', 'Çelik'),
('Ayşe', 'Yıldırım');

INSERT INTO people.translators (first_name, last_name) VALUES
('John', 'Smith'),
('Emily', 'Brown'),
('Michael', 'Johnson'),
('Emma', 'Davis'),
('David', 'Wilson');

INSERT INTO library.books (title, type, author_id, editor_id, translator_id) VALUES
('Beyaz Kale', 'Roman', 1, 1, NULL),
('İnce Memed', 'Roman', 2, 2, NULL),
('Aşk', 'Roman', 3, 3, 1),
('Kayıp Tanrılar Ülkesi', 'Polisiye', 4, 4, 2),
('Kürk Mantolu Madonna', 'Roman', 5, 5, NULL),
('Kitap4', 'Roman', 1, 2, NULL),
('Kitap5', 'Biyografi', 2, 3, NULL);


-- Example #1: Showing books and their authors

SELECT 
	b.title AS Title, 
	b.type AS Type, 
	a.first_name + ' ' + a.last_name AS Author 
FROM
	library.books b inner join people.authors a
	ON b.author_id = a.id


-- Example #2: Showing books and their translators

SELECT 
	b.title AS Title,
	b.type AS Type,
	CONCAT(t.first_name, ' ', t.last_name) AS Translator
FROM 
	library.books b join people.translators t
	ON b.translator_id = t.id


-- Example #3: Showing all books alongside their authors and translators, if they exist

SELECT 
	b.title AS Title,
	b.type AS Type, 
	CONCAT(a.first_name, ' ', a.last_name) AS Author,
	t.last_name AS Translator
FROM library.books b inner join people.authors a
	on b.id = a.id
	left outer join people.translators t
	on b.translator_id = t.id
	

-- Example #4: Showing all books with their editors, if any

SELECT
	b.title AS Title,
	b.type AS Type,
	e.last_name AS Editor
FROM library.books b left outer join people.editors e
	on b.editor_id = e.id

-- Example #5: Books and editors with RIGHT JOIN

SELECT *
FROM library.books b right outer join people.editors e
on b.editor_id = e.id

-- Example #6: Showing all books and all editors

SELECT *
FROM library.books b full join people.editors e
on b.editor_id = e.id
