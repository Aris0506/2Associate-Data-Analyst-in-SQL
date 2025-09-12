# A review of the LIKE operator -> mencari nilai teks tertentu yang cocok dengan pola tertentu

-- Select all columns
SELECT *
FROM film
-- Select only records that begin with the word 'GOLD'
WHERE title LIKE 'GOLD%';

SELECT *
FROM film
-- Select only records that end with the word 'GOLD'
WHERE title LIKE '%GOLD';

SELECT *
FROM film
-- Select only records that contain the word 'GOLD'
WHERE title LIKE '%GOLD%';


##################
#What is a tsvector? -> representasi teks yang sudah diolah dan siap untuk dicari dengan cepat dan efisien.
#(Pembuatan indeks full-text search)

-- Select the film description as a tsvector
SELECT to_tsvector(description)
FROM film;


####################
#  Basic full-text search -> pencarian teks sederhana

-- Select the title and description
SELECT title, description
FROM film
-- Convert the title to a tsvector and match it against the tsquery 
WHERE to_tsvector(title) @@ tsquery('elf');