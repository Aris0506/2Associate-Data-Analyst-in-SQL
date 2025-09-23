# 📘 SQL Notes: Aggregating Numeric Data

Hari ini kita belajar tentang bagaimana cara bekerja dengan **numeric data** dan melakukan **aggregasi** di SQL.  
Berikut rangkuman catatan lengkapnya:

---

## 📊 1. Operasi Dasar pada Numeric Data

### ➡️ Division (Pembagian)
- Operasi pembagian angka di SQL.
- Contoh: hitung **average revenue per employee**.
```sql
SELECT sector, 
       AVG(revenues/employees::numeric) AS avg_rev_employee
  FROM fortune500
 GROUP BY sector
 ORDER BY avg_rev_employee;
```

### ➡️ Explore with Division
- Gunakan pembagian untuk mencari insight (rasio, proporsi).
```sql
SELECT unanswered_count/question_count::NUMERIC AS computed_pct, 
       unanswered_pct
  FROM stackoverflow
 WHERE question_count != 0
 LIMIT 10;
```

---

## 📈 2. Summary & Aggregasi Numeric Data

### ➡️ Summarize Numeric Columns
- Gunakan fungsi agregasi: `MIN`, `MAX`, `AVG`, `STDDEV`.
```sql
SELECT MIN(profits),
       AVG(profits),
       MAX(profits),
       STDDEV(profits)
  FROM fortune500;
```

### ➡️ Summarize Group Statistics
- Ringkas data per kategori dengan `GROUP BY`.
```sql
SELECT sector,
       MIN(profits),
       AVG(profits),
       MAX(profits),
       STDDEV(profits)
  FROM fortune500
 GROUP BY sector
 ORDER BY AVG(profits);
```

### ➡️ Mean and Median
- `AVG()` untuk mean, `PERCENTILE_DISC(0.5)` untuk median.
```sql
SELECT sector,
       AVG(assets) AS mean,
       PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY assets) AS median
  FROM fortune500
 GROUP BY sector
 ORDER BY mean;
```

### ➡️ Correlation
- Ukur hubungan linear antar kolom numerik.
```sql
SELECT CORR(revenues, profits) AS rev_profits,
       CORR(revenues, assets) AS rev_assets,
       CORR(revenues, equity) AS rev_equity 
  FROM fortune500;
```

### ➡️ Truncate
- Potong angka ke kelipatan tertentu (binning).
```sql
SELECT TRUNC(employees, -5) AS employee_bin,
       COUNT(*)
  FROM fortune500
 GROUP BY employee_bin
 ORDER BY employee_bin;
```

### ➡️ Generate Series
- Buat deret angka atau tanggal otomatis (berguna untuk histogram).
```sql
WITH bins AS (
      SELECT generate_series(2200, 3050, 50) AS lower,
             generate_series(2250, 3100, 50) AS upper),
     dropbox AS (
      SELECT question_count 
        FROM stackoverflow
       WHERE tag='dropbox') 
SELECT lower, upper, count(question_count) 
  FROM bins
       LEFT JOIN dropbox
         ON question_count >= lower 
        AND question_count < upper
 GROUP BY lower, upper
 ORDER BY lower;
```

---

## 🗂 3. Tools untuk Mempermudah Analisis Numeric

### ➡️ Create a Temp Table
- Simpan hasil query sementara.
```sql
CREATE TEMP TABLE profit80 AS
  SELECT sector, 
         percentile_disc(0.8) WITHIN GROUP (ORDER BY profits) AS pct80
    FROM fortune500 
   GROUP BY sector;
```

### ➡️ Create a Temp Table to Simplify a Query
- Memecah query panjang menjadi lebih mudah dibaca.
```sql
CREATE TEMP TABLE startdates AS
SELECT tag, min(date) AS mindate
  FROM stackoverflow
 GROUP BY tag;
```

### ➡️ Insert into a Temp Table
- Tambahkan data (manual atau hasil query) ke tabel sementara.
```sql
INSERT INTO correlations
SELECT 'profits_change'::varchar AS measure,
       corr(profits_change, profits) AS profits,
       corr(profits_change, profits_change) AS profits_change,
       corr(profits_change, revenues_change) AS revenues_change
  FROM fortune500;
```

---

## 📌 Inti Pembelajaran
- **Division** → operasi dasar pembagian untuk rasio/proporsi.  
- **Summary & Aggregasi** → meringkas data numerik (mean, median, stddev, correlation).  
- **Truncate & Generate Series** → mengelompokkan data numerik.  
- **Temp Tables** → mempermudah analisis dengan menyimpan hasil query sementara.  

👉 Semua ini adalah bagian dari **aggregating numeric data di SQL**.

