✅ Ringkasan Pembelajaran Hari Ini -> Full-text Search and PostgresSQL Extensions

🔎 1. LIKE Operator
- Digunakan untuk pencarian sederhana dengan pola tertentu.
- Contoh:
    - LIKE 'GOLD%' → diawali "GOLD"
    - LIKE '%GOLD' → diakhiri "GOLD"
    - LIKE '%GOLD%' → mengandung "GOLD"

📦 2. tsvector
- Tipe data khusus untuk full-text search.
- Mengubah teks biasa jadi bentuk yang efisien untuk pencarian.
    Contoh: SELECT to_tsvector(description) FROM film;

🔍 3. Basic Full-Text Search
- Pencarian teks yang lebih canggih dari LIKE.
- Menggunakan operator @@ untuk mencocokkan kata kunci.
- Contoh:
    WHERE to_tsvector(title) @@ to_tsquery('elf')

🧩 4. User-Defined Data Types (UDT)
- Tipe data kustom buatan sendiri seperti ENUM.
- Contoh ENUM:
    CREATE TYPE compass_position AS ENUM ('North', 'South', 'East', 'West');

🧠 5. Getting Info About UDT
- Melihat detail tipe data buatan sendiri di PostgreSQL.
- Contoh:
    SELECT * FROM pg_type WHERE typname='compass_position';

🧮 6. User-Defined Functions
- Fungsi buatan sendiri, seperti inventory_held_by_customer(), untuk menyederhanakan query kompleks.
- Contoh penggunaannya di JOIN untuk menandai item yang sedang dipinjam pelanggan.

🔧 7. Enabling Extensions
- Mengaktifkan fitur tambahan PostgreSQL (misalnya pg_trgm untuk fuzzy search).
- Contoh:
    CREATE EXTENSION IF NOT EXISTS pg_trgm;

📏 8. Measuring Similarity Between Two Strings
- Mengukur kemiripan teks (tanpa harus sama persis).
- Gunakan fungsi similarity() dari extension pg_trgm.
- Contoh:
    SELECT similarity(title, description) FROM film;

✂️ 9. Levenshtein Distance
- Mengukur berapa banyak edit yang dibutuhkan untuk mengubah satu string ke yang lain.
- Cocok untuk deteksi typo atau duplikasi mirip.
- Contoh:
    SELECT levenshtein(title, 'JET NEIGHBOR') FROM film;

🧠 10. Putting It All Together
- Gabungkan full-text search + similarity ranking!
- Menemukan data yang relevan dan paling mirip secara konten.
- Contoh:
    SELECT title, description, similarity(description, 'Astounding Drama')
    FROM film
    WHERE to_tsvector(description) @@ to_tsquery('Astounding & Drama')
    ORDER BY similarity(description, 'Astounding Drama') DESC;


inti pemahaman:

| Topik                          | Keterangan Singkat                        |
| ------------------------------ | ----------------------------------------- |
| LIKE Operator                  | Pencarian berbasis pola sederhana         |
| tsvector                       | Format teks khusus untuk full-text search |
| Full-text search               | Pencarian teks lebih pintar dari `LIKE`   |
| ENUM & User-defined Data Types | Buat tipe data kustom (seperti status)    |
| User-defined Functions         | Fungsi buatan sendiri untuk query dinamis |
| Extensions                     | Mengaktifkan fitur tambahan PostgreSQL    |
| Similarity & Levenshtein       | Ukur kemiripan teks dan deteksi typo      |
| Menggabungkan Semuanya         | Full-text search + similarity ranking     |
