-- PART 1

-- Create 'authors' table
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

--  Create 'books' table
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    isbn VARCHAR(20),
    publication_year INTEGER,
    author_id INTEGER REFERENCES authors(id)
);

-- Insert authors
INSERT INTO authors (name, email) VALUES ('F. Scott Fitzgerald', 'scott@example.com');
INSERT INTO authors (name, email) VALUES ('George Orwell', 'george@example.com');

-- Insert books (link to authors via author_id)
INSERT INTO books (title, isbn, publication_year, author_id)
    VALUES ('The Great Gatsby', '9780743273565', 1925, 1);
INSERT INTO books (title, isbn, publication_year, author_id)
    VALUES ('Tender Is the Night', '9780684801544', 1934, 1);
INSERT INTO books (title, isbn, publication_year, author_id)
    VALUES ('1984', '9780451524935', 1949, 2);

-- Query to verify
SELECT b.title, b.isbn, b.publication_year, a.name, a.email
FROM books b
JOIN authors a ON b.author_id = a.id;

--  PART TWO

-- Create 'categories' table
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Create 'book-categories' table
CREATE TABLE book_categories (
    book_id INTEGER REFERENCES books(id),
    category_id INTEGER REFERENCES categories(id),
    PRIMARY KEY (book_id, category_id)
);

-- Insert categories
INSERT INTO categories (name) VALUES ('Classic');
INSERT INTO categories (name) VALUES ('Dystopian');
INSERT INTO categories (name) VALUES ('Fiction');

-- Associate books with categories:

-- The Great Gatsby
INSERT INTO book_categories (book_id, category_id) VALUES (1, 1); -- classic
INSERT INTO book_categories (book_id, category_id) VALUES (1, 3); -- fiction

-- Tender Is the Night 
INSERT INTO book_categories (book_id, category_id) VALUES (2, 1); -- classic
INSERT INTO book_categories (book_id, category_id) VALUES (2, 3); -- fiction

-- 1984
INSERT INTO book_categories (book_id, category_id) VALUES (3, 1); -- classic
INSERT INTO book_categories (book_id, category_id) VALUES (3, 2); -- dystopian
INSERT INTO book_categories (book_id, category_id) VALUES (3, 3); -- fiction

-- Queries to verify
SELECT books.title, categories.name
FROM books
JOIN book_categories ON books.id = book_categories.book_id
JOIN categories ON categories.id = book_categories.category_id

SELECT *
FROM books
JOIN authors ON books.id = authors.id
JOIN book_categories ON books.id = book_categories.book_id
JOIN categories ON books.id = categories.id

