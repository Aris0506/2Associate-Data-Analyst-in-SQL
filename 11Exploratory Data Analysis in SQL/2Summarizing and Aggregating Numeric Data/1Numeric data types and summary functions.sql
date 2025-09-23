# Division -> perasi pembagian angka, baik dalam matematika maupun dalam kode/program.

-- Select average revenue per employee by sector
SELECT sector, 
     AVG(revenues/employees::numeric) AS avg_rev_employee
  FROM fortune500
 GROUP BY sector
 -- Use the column alias to order the results
 ORDER BY avg_rev_employee;


################
# Explore with division -> menggunakan pembagian untuk mendapatkan insight dari data (misalnya rata-rata, proporsi, rasio).

-- Divide unanswered_count by question_count
SELECT unanswered_count/question_count::NUMERIC AS computed_pct, 
       -- What are you comparing the above quantity to?
       unanswered_pct
  FROM stackoverflow
 -- Select rows where question_count is not 0
 WHERE question_count != 0
 LIMIT 10;



########################
# Summarize numeric columns -> membuat ringkasan statistik dari kolom-kolom yang berisi angka.

-- Select min, avg, max, and stddev of fortune500 profits
SELECT MIN(profits),
       AVG(profits),
       MAX(profits),
       STDDEV(profits)
  FROM fortune500;


-- Select sector and summary measures of fortune500 profits
SELECT sector,
       MIN(profits),
       AVG(profits),
       MAX(profits),
       STDDEV(profits)
  FROM fortune500
 -- What to group by?
 GROUP BY sector
 -- Order by the average profits
 ORDER BY AVG;

##############################
# Summarize group statistics -> menghitung ringkasan (sum, avg, min, max, dll.) untuk setiap kelompok dalam data.

-- Compute standard deviation of maximum values
SELECT STDDEV(maxval),
	   -- min
       MIN(maxval),
       -- max
       MAX(maxval),
       -- avg
       AVG(maxval)
  -- Subquery to compute max of question_count by tag
  FROM (SELECT MAX(question_count) AS maxval
          FROM stackoverflow
         -- Compute max by...
         GROUP BY tag) AS max_results; -- alias for subquery