# GROUP BY single fields

-- Find the release_year and film_count of each year
SELECT release_year, COUNT(*) AS film_count
FROM films
GROUP BY release_year;


-- Find the release_year and average duration of films for each year
SELECT release_year, AVG(duration) AS avg_duration
FROM films
GROUP BY release_year;


#####################
# GROUP BY multiple fields

-- Find the release_year, country, and max_budget, then group and order by release_year and country
SELECT release_year, country, MAX(budget) AS max_budget
FROM films
GROUP BY release_year, country; 


# Answering business questions

SELECT release_year, COUNT(DISTINCT language) AS Most_language_diversity
FROM films
GROUP BY release_year
ORDER BY most_language_diversity DESC
LIMIT 1;

