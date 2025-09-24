# Count the categories -> Menghitung berapa kali sebuah kategori muncul dalam data.

-- Select the count of each level of priority
SELECT priority, COUNT(*)
  FROM evanston311 --first
 GROUP BY priority; --second


-- Find values of zip that appear in at least 100 rows
-- Also get the count of each value
SELECT zip, COUNT(*)
  FROM evanston311
 GROUP BY zip
HAVING COUNT(*) >= 100; 

-- Find values of source that appear in at least 100 rows
-- Also get the count of each value
SELECT source, COUNT(*)
  FROM evanston311
 GROUP BY source
HAVING COUNT(*) >= 100;


-- Find the 5 most common values of street and the count of each
SELECT street, COUNT(*)
  FROM evanston311
 GROUP BY street
 ORDER BY COUNT(*) DESC
 LIMIT 5;

###################
#  spotting character data problems = mengidentifikasi masalah data teks (spasi, huruf, NULL, encoding, duplikat) 
# sebelum dipakai analisis

