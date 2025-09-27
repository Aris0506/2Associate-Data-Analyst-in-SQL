# Identify favorite movies for a group of customers -> 

SELECT m.title, 
COUNT(*),
AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY m.title
HAVING COUNT(*) > 1 -- Remove movies with only one rental
ORDER BY AVG(r.rating) DESC; -- Order with highest rating first

##########
# Identify favorite actors for Spain ->


SELECT a.name,  c.gender,
       COUNT(*) AS number_views, 
       AVG(r.rating) AS avg_rating
FROM renting as r
LEFT JOIN customers AS c -- Augment table renting with information about customers
ON r.customer_id = c.customer_id
LEFT JOIN actsin as ai -- Augment the table renting with the table actsin
ON r.movie_id = ai.movie_id
LEFT JOIN actors as a -- Augment table renting with information about actors
ON ai.actor_id = a.actor_id
WHERE c.country = 'Spain'  -- Select only customers from Spain
GROUP BY a.name, c.gender -- For each actor, separately for male and female customers
HAVING AVG(r.rating) IS NOT NULL 
  AND COUNT(*) > 5  -- Report only actors with more than 5 movie rentals
ORDER BY avg_rating DESC, number_views DESC;


###########
#KPIs per country -> 


SELECT 
	c.country,                    -- For each country report
	COUNT(*) AS number_renting, -- The number of movie rentals
	AVG(r.rating) AS average_rating, -- The average rating
	SUM(m.renting_price) AS revenue         -- The revenue from movie rentals
FROM renting AS r -- Augment the table renting with information about customers
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m -- Augment the table renting with information about movies
ON m.movie_id = r.movie_id
WHERE date_renting >= '2019-01-01' -- Select only records about rentals since the beginning of 2019
GROUP BY c.country;
