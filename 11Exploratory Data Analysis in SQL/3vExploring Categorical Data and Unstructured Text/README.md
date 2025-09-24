
# 📘 Exploring Categorical Data and Unstructured Text

Catatan ini berisi ringkasan konsep dan contoh SQL query untuk eksplorasi data kategorikal dan teks tidak terstruktur.

---

## 1. Count the Categories  
**Tujuan:** Menghitung berapa kali sebuah kategori muncul dalam data.  

```sql
-- Hitung jumlah data per kategori priority
SELECT priority, COUNT(*)
  FROM evanston311
 GROUP BY priority;

-- Hitung zip yang muncul minimal 100 kali
SELECT zip, COUNT(*)
  FROM evanston311
 GROUP BY zip
HAVING COUNT(*) >= 100;

-- Cari 5 street paling umum
SELECT street, COUNT(*)
  FROM evanston311
 GROUP BY street
 ORDER BY COUNT(*) DESC
 LIMIT 5;
```

---

## 2. Spotting Character Data Problems  
**Tujuan:** Mengidentifikasi masalah data teks (spasi, huruf, NULL, encoding, duplikat).  

- **Trimming** → menghapus spasi/karakter tertentu di awal & akhir string.  

```sql
SELECT DISTINCT street,
       TRIM(street, '0123456789 #/.') AS cleaned_street
  FROM evanston311
 ORDER BY street;
```

---

## 3. Exploring Unstructured Text  
**Teks tidak berbentuk tabel tetap (misalnya deskripsi laporan).**  

- **Cari kata tertentu dalam deskripsi:**  
```sql
SELECT COUNT(*)
  FROM evanston311
 WHERE description ILIKE '%trash%'
    OR description ILIKE '%garbage%';
```

- **Deskripsi mengandung kata, tapi kategori tidak:**  
```sql
SELECT category, COUNT(*)
  FROM evanston311 
 WHERE (description ILIKE '%trash%' OR description ILIKE '%garbage%') 
   AND category NOT LIKE '%Trash%'
   AND category NOT LIKE '%Garbage%'
 GROUP BY category
 ORDER BY COUNT DESC
 LIMIT 10;
```

---

## 4. Concatenate Strings  
**Menggabungkan beberapa string menjadi satu string.**

```sql
SELECT LTRIM(CONCAT(house_num, ' ', street)) AS address
  FROM evanston311;
```

---

## 5. Split Strings on a Delimiter  
**Memecah teks panjang menjadi potongan-potongan berdasarkan delimiter.**

```sql
SELECT SPLIT_PART(street, ' ', 1) AS street_name, COUNT(*)
  FROM evanston311
 GROUP BY street_name
 ORDER BY COUNT DESC
 LIMIT 20;
```

---

## 6. Shorten Long Strings  
**Memotong teks panjang menjadi lebih pendek.**

```sql
SELECT CASE WHEN LENGTH(description) > 50
            THEN LEFT(description, 50) || '...'
       ELSE description
       END
  FROM evanston311
 WHERE description LIKE 'I %'
 ORDER BY description;
```

---

## 7. Group and Recode Values  
**Mengelompokkan & menstandarisasi kategori.**

```sql
-- Buat tabel recode
DROP TABLE IF EXISTS recode;
CREATE TEMP TABLE recode AS
  SELECT DISTINCT category, 
         RTRIM(SPLIT_PART(category, '-', 1)) AS standardized
  FROM evanston311;

-- Update kategori tertentu
UPDATE recode SET standardized='Trash Cart' 
 WHERE standardized LIKE 'Trash%Cart';
```

---

## 8. Create a Table with Indicator Variables  
**Mengubah kategori menjadi kolom biner (0/1) → menandai keanggotaan.**

```sql
DROP TABLE IF EXISTS indicators;
CREATE TEMP TABLE indicators AS
  SELECT id, 
         CAST(description LIKE '%@%' AS INTEGER) AS email,
         CAST(description LIKE '%___-___-____%' AS INTEGER) AS phone
    FROM evanston311;

-- Hitung proporsi tiap indikator
SELECT priority,
       SUM(email)/COUNT(*)::NUMERIC AS email_prop,
       SUM(phone)/COUNT(*)::NUMERIC AS phone_prop
  FROM evanston311
       LEFT JOIN indicators
       ON evanston311.id=indicators.id
 GROUP BY priority;
```

---

## 9. Create an "Other" Category  
**Membuat kategori tambahan untuk nilai jarang.**

```sql
SELECT CASE WHEN zipcount < 100 THEN 'Other'
            ELSE zip END AS zip_recoded,
       SUM(zipcount) AS zipsum
  FROM (SELECT zip, COUNT(*) AS zipcount
          FROM evanston311
         GROUP BY zip) AS fullcounts
 GROUP BY zip_recoded
 ORDER BY zipsum DESC;
```

---

📌 **Inti pembelajaran hari ini:**  
1. Cara **menghitung & memfilter kategori**.  
2. Cara **membersihkan teks** (trim, split, shorten).  
3. Teknik eksplorasi teks tidak terstruktur (LIKE, ILIKE).  
4. **Recode kategori** agar lebih standar.  
5. Membuat **indicator variables (dummy variables)**.  
6. Membuat kategori **Other** untuk data langka.  
