# Latihan Advanced SQL untuk Pengambilan Keputusan Berbasis Data

Repositori ini berisi kumpulan kueri SQL yang dirancang untuk mendemonstrasikan teknik-teknik tingkat lanjut dalam analisis data. Setiap kueri disertai dengan studi kasus sederhana untuk menjawab pertanyaan bisnis yang spesifik, menyoroti bagaimana SQL dapat digunakan untuk *data-driven decision making*.

## Konsep Utama yang Dibahas

* **Nested Queries (Subqueries)**: Menjalankan kueri di dalam kueri lain untuk melakukan analisis multi-langkah.
* **Correlated Nested Queries**: Subquery yang dieksekusi berulang kali untuk setiap baris dari kueri utama.
* **Operator `EXISTS`**: Memeriksa keberadaan data secara efisien tanpa perlu mengambil data itu sendiri.
* **Set Operators (`UNION` & `INTERSECT`)**: Menggabungkan atau mencari irisan dari hasil dua kueri atau lebih.

---

## Detail Kueri dan Studi Kasus

Berikut adalah rincian dari setiap kueri yang ada di dalam latihan ini.

### 1. Nested Queries (Subqueries)

Digunakan ketika hasil dari satu kueri dibutuhkan sebagai input untuk kueri lainnya.

**Studi Kasus: Menemukan Film yang Sering Disewa**
*Tujuan: Menampilkan detail film yang telah disewa lebih dari 5 kali.*
```sql
SELECT *
FROM movies
WHERE movie_id IN
	(SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(*) > 5);
```

**Studi Kasus: Menemukan Pelanggan yang Sering Menyewa**
*Tujuan: Menampilkan data pelanggan yang telah menyewa lebih dari 10 film.*
```sql
SELECT *
FROM customers
WHERE customer_id IN
	(SELECT customer_id
	FROM renting
	GROUP BY customer_id
	HAVING COUNT(*) > 10);
```

**Studi Kasus: Menemukan Film dengan Rating di Atas Rata-rata Keseluruhan**
*Tujuan: Menampilkan judul film yang rata-rata ratingnya lebih tinggi dari rata-rata rating semua film.*
```sql
SELECT title
FROM movies
WHERE movie_id IN
	(SELECT movie_id
	 FROM renting
     GROUP BY movie_id
     HAVING AVG(rating) >
		(SELECT AVG(rating)
		 FROM renting));
```

### 2. Correlated Nested Queries

Subquery yang memiliki ketergantungan pada setiap baris dari kueri luar, berguna untuk analisis per baris yang kompleks.

**Studi Kasus: Menganalisis Perilaku Pelanggan (Rental Rendah)**
*Tujuan: Mengidentifikasi pelanggan yang total penyewaannya kurang dari 5 kali.*
```sql
SELECT *
FROM customers as c
WHERE 5 >
	(SELECT count(*)
	FROM renting as r
	WHERE r.customer_id = c.customer_id);
```

**Studi Kasus: Mencari Pelanggan yang Memberi Rating Rendah**
*Tujuan: Menemukan pelanggan yang pernah memberikan rating di bawah 4.*
```sql
SELECT *
FROM customers AS c
WHERE 4 >
	(SELECT MIN(rating)
	FROM renting AS r
	WHERE r.customer_id = c.customer_id);
```

### 3. Operator `EXISTS`

Cara yang efisien untuk memverifikasi apakah suatu kondisi terpenuhi tanpa perlu menghitung atau mengambil data.

**Studi Kasus: Mencari Pelanggan yang Pernah Memberi Rating**
*Tujuan: Menampilkan daftar pelanggan yang memiliki setidaknya satu catatan rating.*
```sql
SELECT *
FROM customers AS c
WHERE EXISTS
	(SELECT *
	FROM renting AS r
	WHERE rating IS NOT NULL
	AND r.customer_id = c.customer_id);
```

**Studi Kasus: Menemukan Aktor yang Bermain di Film Komedi**
*Tujuan: Menghitung jumlah aktor berdasarkan kewarganegaraan yang pernah bermain di film bergenre 'Comedy'.*
```sql
SELECT a.nationality, COUNT(*)
FROM actors AS a
WHERE EXISTS
	(SELECT ai.actor_id
	 FROM actsin AS ai
	 LEFT JOIN movies AS m
	 ON m.movie_id = ai.movie_id
	 WHERE m.genre = 'Comedy'
	 AND ai.actor_id = a.actor_id)
GROUP BY a.nationality;
```

### 4. Set Operators: `UNION` dan `INTERSECT`

Untuk menggabungkan (UNION) atau mencari irisan (INTERSECT) dari dua set hasil yang berbeda.

**Studi Kasus: Mencari Aktor Muda Bukan dari USA (Irisan)**
*Tujuan: Menampilkan aktor yang bukan dari USA **DAN** lahir setelah tahun 1990.*
```sql
SELECT name,
       nationality,
       year_of_birth
FROM actors
WHERE nationality <> 'USA'
INTERSECT
SELECT name,
       nationality,
       year_of_birth
FROM actors
WHERE year_of_birth > 1990;
```

**Studi Kasus: Menemukan Film Drama dengan Rating Tinggi**
*Tujuan: Menampilkan detail film yang bergenre 'Drama' **DAN** memiliki rata-rata rating di atas 9.*
```sql
SELECT *
FROM movies
WHERE movie_id IN
   (SELECT movie_id
    FROM movies
    WHERE genre = 'Drama'
    INTERSECT
    SELECT movie_id
    FROM renting
    GROUP BY movie_id
    HAVING AVG(rating)>9);
```

## Cara Menggunakan

Kueri-kueri ini bersifat ilustratif. Untuk menjalankannya, Anda memerlukan sebuah sistem database relasional (seperti PostgreSQL, MySQL, dll.) yang berisi tabel-tabel seperti `movies`, `customers`, `renting`, `actors`, dan `actsin` dengan skema yang sesuai.

---
Semoga koleksi kueri ini bermanfaat untuk melatih dan memahami kemampuan SQL tingkat lanjut.




---

