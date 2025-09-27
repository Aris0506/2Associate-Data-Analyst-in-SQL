# First account for each country. ->

SELECT country, -- For each country report the earliest date when an account was created
	MIN(date_account_start) AS first_account
FROM customers
GROUP BY country
ORDER BY first_account ASC;


# Average movie ratings ->

SELECT movie_id, 
       AVG(rating) AS avg_rating,
       COUNT(rating) AS number_ratings,
       COUNT(*) AS number_renting
FROM renting
GROUP BY movie_id
ORDER BY avg_rating DESC; -- Order by average rating in decreasing order

#########
# Average rating per customer ->

SELECT customer_id, -- Report the customer_id
      AVG(rating),  -- Report the average rating per customer
      COUNT(customer_id),  -- Report the number of ratings per customer
      COUNT(*)  -- Report the number of movie rentals per customer
FROM renting
GROUP BY customer_id
HAVING COUNT(*) > 7 -- Select only customers with more than 7 movie rentals
ORDER BY AVG ASC; -- Order by the average rating in ascending order
