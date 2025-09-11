# Making queries DISTINCT

-- Select unique authors from the books table
SELECT DISTINCT author
FROM books;

-- Select unique authors and genre combinations from the books table
SELECT DISTINCT author, genre
FROM books;



# Aliasing

-- Alias author so that it becomes unique_author
SELECT DISTINCT author AS unique_author
FROM books;


# VIEWing your query

-- Your code to create the view:
CREATE VIEW library_authors AS
SELECT DISTINCT author AS unique_author
FROM books;

-- Select all columns from library_authors
SELECT *
FROM library_authors;