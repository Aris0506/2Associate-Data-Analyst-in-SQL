# GROUPING SETS ->  cara fleksibel untuk membuat ringkasan data dari beberapa kombinasi kolom sekaligus, dalam satu query.

# Exploring nationality and gender of actors

SELECT 
	nationality, -- Select nationality of the actors
    gender, -- Select gender of the actors
    COUNT(*) -- Count the number of actors
FROM actors
GROUP BY GROUPING SETS ((nationality), (gender), ()); -- Use the correct GROUPING SETS operation


# Exploring rating by country and gender

SELECT 
	c.country, 
    c.gender,
	AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
-- Report all info from a Pivot table for country and gender
GROUP BY GROUPING SETS ((c.country, c.gender),(c.country), (c.gender), ());
