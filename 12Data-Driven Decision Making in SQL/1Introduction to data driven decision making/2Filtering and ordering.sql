# Filtering and ordering -> menyaring baris data sesuai kondisi tertentu dan mengurutkan hasil query berdasarkan kolom tertentu


# Working with dates ->  bekerja dengan data bertipe tanggal & waktu

SELECT *
FROM renting
WHERE date_renting = '2018-10-09'; -- Movies rented on October 9th, 2018


SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-04-01' AND '2018-08-31'
ORDER BY date_renting DESC; -- Order by recency in decreasing order


###############3
# Selecting movies -> 

SELECT *
FROM movies
WHERE genre <> 'Drama'; -- All genres except drama

SELECT *
FROM movies
WHERE title IN ('Showtime', 'Love Actually', 'The Fighter' ); -- Select all movies with the given titles

SELECT *
FROM movies
ORDER BY renting_price DESC ; -- Order the movies by increasing renting price


##################
# Select from renting -> 

SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-01-01' AND '2018-12-31' -- Renting in 2018
AND rating IS NOT NULL; -- Rating exists