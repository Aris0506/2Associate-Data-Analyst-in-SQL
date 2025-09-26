# Aggregations - summarizing data -> mengolah banyak baris data menjadi ringkasan (summary) dengan fungsi agregasi. 

SELECT COUNT(*) -- Count the total number of customers
FROM customers
WHERE date_of_birth BETWEEN '1980-01-01' AND '1989-12-31'; -- Select customers born between 1980-01-01 and 1989-12-31


SELECT COUNT(*)   -- Count the total number of customers
FROM customers
WHERE country = 'Germany'; -- Select all customers from Germany


SELECT COUNT(DISTINCT country)   -- Count the number of countries
FROM customers;


#################
# Ratings of movie 25 ->

SELECT MIN(rating) min_rating, -- Calculate the minimum rating and use alias min_rating
	   MAX(rating) max_rating, -- Calculate the maximum rating and use alias max_rating
	   AVG(rating) avg_rating, -- Calculate the average rating and use alias avg_rating
	   COUNT(rating) number_ratings -- Count the number of ratings and use alias number_ratings
FROM renting
WHERE movie_id = 25 ; -- Select all records of the movie with ID 25



#################
# Examining annual rentals -> 

SELECT 
	COUNT(*) AS number_renting,
	AVG(rating) AS average_rating, 
    COUNT(rating) AS number_ratings -- Add the total number of ratings here.
FROM renting
WHERE date_renting >= '2019-01-01';