## Read an entity relationship diagram -> memahami tabel, kolom kunci, dan hubungan antar tabel.

-- Count the number of tags with each type
SELECT type, COUNT(*) AS count
  FROM tag_type
 -- To get the count for each type, what do you need to do?
 GROUP BY type
 -- Order the results with the most common tag types listed first
 ORDER BY count DESC;


 -- Select the 3 columns desired
SELECT company.name, tag_type.tag, tag_type.type
  FROM company
  	   -- Join to the tag_company table
       INNER JOIN tag_company 
       ON company.id = tag_company.company_id
       -- Join to the tag_type table
       INNER JOIN tag_type
       ON tag_company.tag = tag_type.tag
  -- Filter to most common type
  WHERE type='cloud';


#################################

# Coalesce -> dipakai untuk mengganti NULL dengan nilai alternatif, sehingga tidak ada nilai kosong di hasil query.
-- Use coalesce
SELECT COALESCE(NULL, industry, 'Unknown') AS industry2,
       -- Don't forget to count!
       COUNT(*) 
  FROM fortune500
-- Group by what? (What are you counting by?)
 GROUP BY industry
-- Order results to see most common first
 ORDER BY COUNT DESC
-- Limit results to get just the one value you want
 LIMIT 1;