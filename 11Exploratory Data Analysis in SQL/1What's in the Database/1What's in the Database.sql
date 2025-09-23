# Explore table sizes -> kalimat ini dipakai waktu kita mengeksplorasi seberapa besar tabel di database

SELECT COUNT(*)
FROM tag_type


########################
# Count missing values -> menghitung berapa banyak baris yang kolom tertentu tidak terisi (NULL).
-- Count the number of null values in the industry column
SELECT count(*) - COUNT(industry) AS missing
  FROM fortune500;



#######################
#Join tables -> menggabungkan data dari dua (atau lebih) tabel berdasarkan kolom yang saling berhubungan.

SELECT company.name
-- Table(s) to select from
  FROM company
       INNER JOIN fortune500
       ON company.ticker=fortune500.ticker;


