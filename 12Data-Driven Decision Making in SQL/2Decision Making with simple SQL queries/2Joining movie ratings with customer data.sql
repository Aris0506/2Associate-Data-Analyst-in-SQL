# Join renting and customers ->

SELECT AVG(rating) -- Average ratings of customers from Belgium
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
WHERE c.country='Belgium';

# Aggregating revenue, rentals and active customers ->

SELECT 
	SUM(m.renting_price), 
	COUNT(*), 
	COUNT(DISTINCT r.customer_id)
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id
-- Only look at movie rentals in 2018
WHERE date_renting BETWEEN '2018-01-01' AND '2018-12-31';

###########
# Movies and actors -> 

SELECT a.name, -- Create a list of movie titles and actor names
       m.title
FROM actsin ai
LEFT JOIN movies AS m
ON m.movie_id = ai.movie_id
LEFT JOIN actors AS a
ON a.actor_id = ai.actor_id;

