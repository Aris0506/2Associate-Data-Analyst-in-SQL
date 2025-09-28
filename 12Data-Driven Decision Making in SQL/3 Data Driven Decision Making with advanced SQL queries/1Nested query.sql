# Nested query (atau subquery) adalah query SQL yang berada di dalam query lain

#Often rented movies
SELECT *
FROM movies
WHERE movie_id IN  -- Select movie IDs from the inner query
	(SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(*) > 5)


# Frequent customers ->

SELECT *
FROM customers
WHERE customer_id IN           -- Select all customers with more than 10 movie rentals
	(SELECT customer_id
	FROM renting
	GROUP BY customer_id
	HAVING COUNT(*) > 10);


# Movies with rating above average -> 
SELECT AVG(rating) -- Calculate the total average rating
FROM renting;


SELECT movie_id, -- Select movie IDs and calculate the average rating 
       AVG(rating)
FROM renting
GROUP BY movie_id
HAVING AVG(rating) > (SELECT AVG(rating) FROM renting); -- Of movies with rating above average


SELECT title -- Report the movie titles of all movies with average rating higher than the total average
FROM movies
WHERE movie_id IN
	(SELECT movie_id
	 FROM renting
     GROUP BY movie_id
     HAVING AVG(rating) > 
		(SELECT AVG(rating)
		 FROM renting));