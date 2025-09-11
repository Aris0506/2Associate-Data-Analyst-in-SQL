# Concatenating strings -> Menggabungkan beberapa kolom/string jadi satu

-- Concatenate the first_name and last_name and email 
SELECT  first_name ||' ' || last_name || ' <' || email || '>' AS full_email 
FROM customer


-- Concatenate the first_name and last_name and email
SELECT CONCAT(first_name, ' ', last_name,  ' <', email,'>') AS full_email 
FROM customer


#################
#Changing the case of string data ->  Mengubah huruf menjadi kapital/lower/judul

SELECT 
  -- Concatenate the category name to coverted to uppercase
  -- to the film title converted to title case
  UPPER(name)  || ': ' || INITCAP(title) AS film_category, 
  -- Convert the description column to lowercase
  LOWER(description) AS description
FROM 
  film AS f 
  INNER JOIN film_category AS fc 
  	ON f.film_id = fc.film_id 
  INNER JOIN category AS c 
  	ON fc.category_id = c.category_id;


###########################
# Replacing string data -> Mengganti karakter tertentu (misalnya spasi jadi underscore)

SELECT 
  -- Replace whitespace in the film title with an underscore
  REPLACE(title, ' ', '_') AS title
FROM film; 