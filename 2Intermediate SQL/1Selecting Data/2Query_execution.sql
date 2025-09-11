# Debugging errors

-- Debug this code
SELECT certification
FROM films  # tadinya kedua itu terbalik sehingga menyebabkan error 
LIMIT 5;


-- Debug this code
SELECT film_id, imdb_score, num_votes # tadinya tidak ada koma akhir sehingga menyebabkan error
FROM reviews;


-- Debug this code
SELECT COUNT(birthdate) AS count_birthdays # tadinya typo pada COUNNT sehingga menyebabkan error
FROM people; # tadinya typo pada nama tabel sehingga menyebabkan error