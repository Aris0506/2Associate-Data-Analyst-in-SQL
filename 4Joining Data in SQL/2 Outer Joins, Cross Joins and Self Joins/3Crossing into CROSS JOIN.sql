# Histories and languages

SELECT c.name AS country, l.name AS language
-- Inner join countries as c with languages as l on code
FROM countries AS c
INNER JOIN languages AS l
USING (code)
WHERE c.code IN ('PAK','IND')
	AND l.code in ('PAK','IND');


SELECT c.name AS country, l.name AS language
FROM countries AS c        
-- Perform a cross join to languages (alias as l)
CROSS JOIN languages AS l 
WHERE c.code in ('PAK','IND')
	AND l.code in ('PAK','IND');


########################
# Choosing your join

SELECT 
	c.name AS country,
    region,
    life_expectancy AS life_exp
FROM countries AS c
-- Join to populations (alias as p) using an appropriate join
INNER JOIN populations AS p
ON c.code = p.country_code
-- Filter for only results in the year 2010
WHERE p.year = 2010
-- Sort by life_exp
ORDER BY life_expectancy ASC
-- Limit to five records
LIMIT 5;