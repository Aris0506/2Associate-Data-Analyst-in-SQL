# Date/time types and formats -> Jenis data (tipe) yang digunakan untuk menyimpan tanggal/waktu dan cara penulisan (format) tanggal/waktu

# Date comparisons ->  melakukan perbandingan antar nilai tanggal/waktu

-- Count requests created on January 31, 2017
SELECT count(*) 
  FROM evanston311
 WHERE date_created::date = '2017-01-31';


-- Count requests created on February 29, 2016
SELECT count(*)
  FROM evanston311 
 WHERE date_created >= '2016-02-29'
   AND date_created < '2016-03-01';

-- Count requests created on March 13, 2017
SELECT count(*)
  FROM evanston311
 WHERE date_created >= '2017-03-13'
   AND date_created < '2017-03-13'::date + 1;


######################
# Date arithmetic -> berhitung dengan tanggal/waktu → tambah/kurang durasi, cari selisih, atau manipulasi waktu.

-- Subtract the min date_created from the max
SELECT MAX(date_created) - MIN(date_created)
  FROM evanston311;

-- How old is the most recent request?
SELECT now() - max(date_created)
  FROM evanston311;


-- Add 100 days to the current timestamp
SELECT now() + '100 days'::interval;


-- Select the current timestamp, 
-- and the current timestamp + 5 minutes
SELECT NOW() + '5 minutes'::interval;


##############
# Completion time by category -> menghitung lama penyelesaian lalu dikelompokkan berdasarkan kategori tertentu untuk dianalisis.

-- Select the category and the average completion time by category
SELECT category, 
       AVG(date_completed - date_created) AS completion_time
  FROM evanston311
 GROUP BY category
-- Order the results
 ORDER BY completion_time DESC;