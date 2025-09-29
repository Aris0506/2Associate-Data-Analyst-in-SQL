# CUBE = menghasilkan semua agregasi multidimensi.


# Groups of customers

SELECT gender, -- Extract information of a pivot table of gender and country for the number of customers
	   country,
	   COUNT(*)
FROM customers
GROUP BY CUBE (gender, country)
ORDER BY country;


# Categories of movies

SELECT year_of_release,
       genre,
       COUNT(*)
FROM movies
GROUP BY CUBE (year_of_release, genre)
ORDER BY year_of_release;


# Analyzing average ratings

SELECT 
	c.country, 
	m.genre, 
	AVG(r.rating) AS avg_rating -- Calculate the average rating 
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY CUBE (c.country, m.genre); -- For all aggregation levels of country and genre 






