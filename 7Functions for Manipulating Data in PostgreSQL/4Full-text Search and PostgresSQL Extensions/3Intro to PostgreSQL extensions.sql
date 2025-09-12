# Enabling extensions ->  Mengaktifkan fitur tambahan di PostgreSQL agar database bisa melakukan 
# hal-hal di luar fitur standar, seperti fuzzy search, GIS, UUID, dan lainnya.

-- Enable the pg_trgm extension
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Select all rows extensions
SELECT * 
FROM pg_extension;

####################
# Measuring similarity between two strings ->  berapa besar kemiripan dua teks — apakah hanya beda kecil, typo, 
# atau sama sekali berbeda.


-- Select the title and description columns
SELECT 
  title, 
  description, 
  -- Calculate the similarity
  similarity(title, description)
FROM 
  film


#########################################
#Levenshtein distance examples -> adalah jumlah minimum operasi edit untuk mengubah satu string ke string lain

-- Select the title and description columns
SELECT  
  title, 
  description, 
  -- Calculate the levenshtein distance
  levenshtein(title, 'JET NEIGHBOR') AS distance
FROM 
  film
ORDER BY 3


###########################################
#  Putting it all together

-- Select the title and description columns
SELECT  
  title, 
  description 
FROM 
  film
WHERE 
  -- Match "Astounding Drama" in the description
  to_tsvector(description) @@ 
  to_tsquery('Astounding & Drama');



SELECT 
  title, 
  description, 
  -- Calculate the similarity
  similarity(description, 'Astounding Drama')
FROM 
  film 
WHERE 
  to_tsvector(description) @@ 
  to_tsquery('Astounding & Drama') 
ORDER BY 
	similarity(description, 'Astounding Drama') DESC;