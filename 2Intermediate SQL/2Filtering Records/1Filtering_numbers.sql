# Using WHERE with numbers
# where is a fitelring condition like df[df['column']>value] in pandas

-- Select film_id and imdb_score with an imdb_score over 7.0
SELECT film_id, imdb_score
FROM reviews
WHERE imdb_score > 7.0; # here are the filtering conditions


-- Select film_id and facebook_likes for ten records with less than 1000 likes 
SELECT film_id, facebook_likes
FROM reviews
WHERE facebook_likes < 1000 # here are the filtering conditions
LIMIT 10;



-- Count the records with at least 100,000 votes
SELECT COUNT(*) AS films_over_100K_votes
FROM reviews
WHERE num_votes >= 100000; # here are the filtering conditions



#########################

# Using WHERE with text

-- Count the Spanish-language films
SELECT COUNT(*) AS count_spanish
FROM films
WHERE language = 'Spanish';
