# Create an "other" category

SELECT CASE WHEN zipcount < 100 THEN 'other'
       ELSE zip
       END AS zip_recoded,
       sum(zipcount) AS zipsum
  FROM (SELECT zip, count(*) AS zipcount
          FROM evanston311
         GROUP BY zip) AS fullcounts
 GROUP BY zip_recoded
 ORDER BY zipsum DESC;

embuat kategori tambahan bernama "Other" (atau "Lainnya") untuk mengelompokkan nilai yang:

terlalu jarang muncul, atau

tidak termasuk dalam daftar kategori utama yang kita tentukan.

👉 Jadi, daripada punya terlalu banyak kategori kecil-kecil (yang bikin data susah dibaca), kita gabungkan mereka jadi satu kategori "Other".


Kalau kita hanya mau fokus ke kategori utama Electronics, Clothing, Toys, sedangkan sisanya kita satukan ke Other:
SELECT 
  CASE 
    WHEN product_category IN ('Electronics', 'Clothing', 'Toys')
         THEN product_category
    ELSE 'Other'
  END AS category_group,
  COUNT(*) AS total_sales
FROM sales
GROUP BY category_group;



################
# Group and recode values -> 
