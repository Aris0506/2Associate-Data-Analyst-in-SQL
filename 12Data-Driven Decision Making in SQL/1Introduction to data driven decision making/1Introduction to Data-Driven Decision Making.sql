## Introduction to Data-Driven Decision Making (SQL) biasanya merujuk ke pengenalan bagaimana 
# kita bisa membuat keputusan bisnis berdasarkan data, dengan menggunakan SQL untuk mengambil, menganalisis, dan memahami data.


# Exploring the table renting -> angkah awal mengenal data sebelum dianalisis lebih jauh

SELECT *  -- Select all
FROM renting;        -- From table renting


SELECT movie_id,  -- Select all columns needed to compute the average rating per movie
       rating
FROM renting;

