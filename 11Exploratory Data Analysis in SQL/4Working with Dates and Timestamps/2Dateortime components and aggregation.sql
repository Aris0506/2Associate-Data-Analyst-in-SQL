# Date parts artinya bagian-bagian (komponen) dari sebuah tanggal atau waktu yang bisa kita ambil secara terpisah.

-- Extract the month from date_created and count requests
SELECT DATE_PART('month', date_created) AS month, 
       COUNT(*)
  FROM evanston311
 -- Limit the date range
 WHERE date_created >= '2016-01-01'
   AND  date_created < '2018-01-01'
 -- Group by what to get monthly counts?
 GROUP BY DATE_PART('month', date_created);


-- Get the hour and count requests
SELECT DATE_PART('hour', date_created) AS hour,
       count(*)
  FROM evanston311
 GROUP BY hour
 -- Order results to select most common
 ORDER BY COUNT DESC
 LIMIT 1;


 -- Count requests completed by hour
SELECT DATE_PART('hour', date_completed) AS hour,
       COUNT(*)
  FROM evanston311
 GROUP BY hour
 ORDER BY hour DESC;


###############
# Variation by day of week -> melihat pola/perbedaan data berdasarkan hari dalam seminggu untuk menemukan tren atau insight.

-- Select name of the day of the week the request was created 
SELECT TO_CHAR(date_created, 'day') AS day, 
       -- Select avg time between request creation and completion
       AVG(date_completed - date_created) AS duration
  FROM evanston311 
 -- Group by the name of the day of the week and 
 -- integer value of day of week the request was created
 GROUP BY day, EXTRACT(DOW FROM date_created)
 -- Order by integer value of the day of the week 
 -- the request was created
 ORDER BY EXTRACT(DOW FROM date_created);

#############
# Date truncation -> “memotong” detail dari datetime agar hanya tersisa komponen tertentu (tahun, bulan, hari, jam, dst).

-- Aggregate daily counts by month
SELECT DATE_TRUNC('month', day) AS month,
       AVG(COUNT)
  -- Subquery to compute daily counts
  FROM (SELECT DATE_TRUNC('day', date_created) AS day,
               COUNT(*) AS count
          FROM evanston311
         GROUP BY day) AS daily_count
 GROUP BY month
 ORDER BY month;
