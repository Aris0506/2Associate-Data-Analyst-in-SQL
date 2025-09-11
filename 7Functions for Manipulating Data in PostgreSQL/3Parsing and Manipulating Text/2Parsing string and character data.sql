# Determining the length of strings -> menentukan panjang string

SELECT 
  -- Select the title and description columns
  title,
  description,
  -- Determine the length of the description column
  LENGTH(description) AS desc_len
FROM film;


#######################
# Truncating strings (memotong)

SELECT 
  -- Select the first 50 characters of description
  SUBSTRING(description,1, 50) AS short_desc
FROM 
  film AS f; 

#################
# Extracting substrings from text data -> mengambil sebagian substring dari teks

SELECT 
  -- Select only the street name from the address table
  SUBSTRING(address FROM POSITION(' ' IN address)+1 FOR LENGTH(address))
FROM 
  address;


#######################
# Combining functions for string manipulation -> menggabungkan fungsi-fungsi string

SELECT
  -- Extract the characters to the left of the '@'
  LEFT(email, POSITION('@' IN email)-1) AS username,
  -- Extract the characters to the right of the '@'
  SUBSTRING(email FROM POSITION('@' IN email)+1 FOR LENGTH(email)) AS domain
FROM customer;