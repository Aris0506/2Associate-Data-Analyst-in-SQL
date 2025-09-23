# Effects of casting -> mengubah tipe data suatu nilai atau kolom ke tipe lain.

-- Select the original value
SELECT profits_change, 
	   -- Cast profits_change
       CAST(profits_change AS INTEGER) AS profits_change_int
  FROM fortune500;


  -- Divide 10 by 3
SELECT 10/3, 
       -- Cast 10 as numeric and divide by 3
       10::NUMERIC/3;


SELECT '3.2'::NUMERIC,
       '-123'::NUMERIC,
       '1e3'::NUMERIC,
       '1e-3'::NUMERIC,
       '02314'::NUMERIC,
       '0002'::NUMERIC;


#####################################
# Summarize the distribution of numeric values -> bikin ringkasan statistik dari kolom angka (misalnya revenue, salary, price).
# Biasanya mencakup: min, max, avg, sum, count, median, kategori rentang.

-- Select the count of each value of revenues_change
SELECT revenues_change, COUNT(*)
  FROM fortune500
 GROUP BY revenues_change
 -- order by the values of revenues_change
 ORDER BY revenues_change;


-- Select the count of each revenues_change integer value
SELECT revenues_change::INTEGER, COUNT(*)
  FROM fortune500
 GROUP BY revenues_change::INTEGER
 -- order by the values of revenues_change
 ORDER BY revenues_change;


-- Count rows 
SELECT COUNT(*)
  FROM fortune500
 -- Where...
 WHERE revenues_change > 0;