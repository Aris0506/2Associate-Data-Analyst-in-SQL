
# Introduction to Data-Driven Decision Making (SQL)

Hari ini kita belajar dasar-dasar SQL untuk data-driven decision making. Inti pembelajarannya adalah:

---

## 1. Exploring the Table
- **Tujuan**: mengenal isi tabel sebelum dianalisis.
- **Contoh**:
```sql
SELECT *  
FROM renting;
```

---

## 2. Filtering and Ordering
- **Filtering (`WHERE`)**: menyaring data sesuai kondisi.  
- **Ordering (`ORDER BY`)**: mengurutkan data (ASC/DSC).
- **Contoh**:
```sql
SELECT *
FROM renting
WHERE date_renting BETWEEN '2018-04-01' AND '2018-08-31'
ORDER BY date_renting DESC;
```

---

## 3. Working with Dates
- Bekerja dengan kolom tanggal/waktu.  
- Bisa filter hari tertentu, rentang tanggal, atau urutkan berdasarkan waktu.
- **Contoh**:
```sql
SELECT *
FROM renting
WHERE date_renting = '2018-10-09';
```

---

## 4. Selecting Movies (dari tabel lain)
- Memilih data tertentu dari tabel `movies`.
- Gunakan `WHERE`, `IN`, `ORDER BY`.
- **Contoh**:
```sql
SELECT *
FROM movies
WHERE genre <> 'Drama';
```

---

## 5. Aggregations – Summarizing Data
- Menggunakan fungsi agregasi: `COUNT`, `MIN`, `MAX`, `AVG`, `SUM`.  
- Digunakan untuk membuat **ringkasan data**.
- **Contoh**:
```sql
SELECT COUNT(*)
FROM customers
WHERE country = 'Germany';
```

---

## 6. Ratings of a Movie
- Menggunakan agregasi untuk analisis rating.
- **Contoh**:
```sql
SELECT MIN(rating) min_rating,
       MAX(rating) max_rating,
       AVG(rating) avg_rating,
       COUNT(rating) number_ratings
FROM renting
WHERE movie_id = 25;
```

---

## 7. Examining Annual Rentals
- Menghitung ringkasan tahunan: jumlah sewa, rata-rata rating, jumlah rating.
- **Contoh**:
```sql
SELECT COUNT(*) AS number_renting,
       AVG(rating) AS average_rating,
       COUNT(rating) AS number_ratings
FROM renting
WHERE date_renting >= '2019-01-01';
```

---

## 🎯 Kesimpulan
- Kamu sudah memahami **fondasi SQL untuk analisis data**:
  - Menjelajahi tabel (explore).
  - Menyaring & mengurutkan data (filter + order).
  - Bekerja dengan tanggal (dates).
  - Mengambil data dari tabel spesifik (select).
  - Membuat ringkasan dengan agregasi (summarizing).
- Semua ini adalah **langkah awal untuk data-driven decision making** → mengubah data mentah jadi **informasi** untuk pengambilan keputusan.


---

## 📊 Ringkasan Fungsi SQL (Cheat Sheet)

| Fungsi        | Deskripsi                                   | Contoh                                                                   |
|---------------|---------------------------------------------|------------------------------------------------------------------------  |
| `COUNT()`     | Menghitung jumlah baris                     | `SELECT COUNT(*) FROM customers;`                                        |
| `SUM()`       | Menjumlahkan nilai                          | `SELECT SUM(amount) FROM orders;`                                        |
| `AVG()`       | Menghitung rata-rata                        | `SELECT AVG(price) FROM products;`                                       |
| `MIN()`       | Nilai terkecil                              | `SELECT MIN(price) FROM products;`                                       |
| `MAX()`       | Nilai terbesar                              | `SELECT MAX(price) FROM products;`                                       |
| `DISTINCT`    | Mengambil nilai unik                        | `SELECT DISTINCT country FROM customers;`                                |
| `GROUP BY`    | Mengelompokkan data untuk agregasi          | `SELECT city, SUM(amount) FROM orders GROUP BY city;`                    |
| `ORDER BY`    | Mengurutkan hasil (ASC/DSC)                 | `SELECT * FROM products ORDER BY price DESC;`                            |
| `WHERE`       | Menyaring baris data berdasarkan kondisi    | `SELECT * FROM customers WHERE country = 'Germany';`                     |
| `BETWEEN`     | Seleksi data dalam rentang nilai            | `SELECT * FROM orders WHERE date BETWEEN '2025-01-01' AND '2025-09-30';` |
| `IN`          | Seleksi data berdasarkan daftar nilai       | `SELECT * FROM movies WHERE genre IN ('Comedy','Action');`               |
| `<>` atau `!=`| Tidak sama dengan                          | `SELECT * FROM movies WHERE genre <> 'Drama';`                            |

---


---

## 🔄 Alur Eksekusi Query SQL

Saat menjalankan query SQL, urutan eksekusi tidak selalu sama dengan urutan penulisan.  
Berikut alur yang umum terjadi:

1. **FROM** → tentukan tabel sumber data.  
2. **WHERE** → filter baris sesuai kondisi.  
3. **GROUP BY** → kelompokkan data.  
4. **HAVING** → filter hasil agregasi.  
5. **SELECT** → pilih kolom/hasil yang ditampilkan.  
6. **ORDER BY** → urutkan hasil.  
7. **LIMIT** → batasi jumlah baris yang ditampilkan.  

📌 **Contoh:**  
```sql
SELECT city, COUNT(*) AS total_orders
FROM orders
WHERE amount > 100
GROUP BY city
HAVING COUNT(*) > 5
ORDER BY total_orders DESC
LIMIT 10;
```

**Urutan eksekusi:**  
`FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT`

---
