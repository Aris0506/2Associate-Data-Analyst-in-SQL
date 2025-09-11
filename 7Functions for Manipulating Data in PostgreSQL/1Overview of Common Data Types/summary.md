
🎯 Functions for Manipulating Data in PostgreSQL

📁 1. INFORMATION_SCHEMA – Melihat Struktur Database

Digunakan untuk mengecek metadata seperti tabel, kolom, dan tipe data.

🔹 Lihat semua tabel di schema public:

SELECT * 
FROM information_schema.tables
WHERE table_schema = 'public';


🔹 Lihat kolom dalam tabel actor:

SELECT * 
FROM information_schema.columns
WHERE table_name = 'actor';


🔹 Lihat nama kolom dan tipe data tabel customer:

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'customer';


⏱️ 2. Interval Data Types – Manipulasi Tanggal/Waktu

Gunakan INTERVAL untuk menambah/mengurangi waktu.

🔹 Contoh menambah 3 hari ke tanggal sewa:

SELECT rental_date,
       return_date,
       rental_date + INTERVAL '3 days' AS expected_return_date
FROM rental;


🧩 3. ARRAY – Menyimpan Banyak Nilai dalam Satu Kolom

PostgreSQL mendukung array sebagai tipe data.

🔹 Akses elemen array dengan indeks:

SELECT title, special_features
FROM film
WHERE special_features[1] = 'Trailers';


🔹 Akses elemen kedua:

WHERE special_features[2] = 'Deleted Scenes';


🔍 4. Mencari di ARRAY

🔹 Menggunakan ANY – apakah nilai ada dalam array:

SELECT title, special_features
FROM film
WHERE 'Trailers' = ANY (special_features);


🔹 Menggunakan @> – apakah array mengandung nilai tertentu:

SELECT title, special_features
FROM film
WHERE special_features @> ARRAY['Deleted Scenes'];



🧠 Inti Pemahaman:

| Topik               | Fungsi Utama                                            |
| ------------------- | ------------------------------------------------------- |
| INFORMATION\_SCHEMA | Mengecek struktur database (tabel, kolom, dll)          |
| INTERVAL            | Manipulasi tanggal dan waktu                            |
| ARRAY               | Menyimpan dan memfilter beberapa nilai dalam satu kolom |
| `ANY`, `@>`         | Cara mencari nilai dalam array                          |



Metadata adalah data tentang data.

Contohnya:

- Nama tabel
- Nama kolom
- Tipe data kolom
- Jumlah baris

📌 Jadi, metadata menjelaskan struktur dan informasi teknis dari data dalam database.