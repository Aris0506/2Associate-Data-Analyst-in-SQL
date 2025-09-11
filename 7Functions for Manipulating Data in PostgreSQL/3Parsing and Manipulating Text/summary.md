📘 Catatan Pembelajaran: Parsing and Manipulating Text in PostgreSQL


📌 Tujuan Umum
Mempelajari cara memproses, mengubah, dan menyesuaikan data teks (string) di PostgreSQL untuk keperluan:
- Menyatukan (concatenate) teks
- Memformat huruf besar/kecil
- Membersihkan data
- Memotong atau mengekstrak bagian tertentu dari teks
- Menambahkan karakter (padding)
- Menghapus karakter (trimming)
- Menggabungkan berbagai fungsi menjadi solusi yang efisien


🔧 1. Concatenating Strings
✅ Inti:
Menggabungkan beberapa kolom string menjadi satu.

🛠️ Fungsi:
- || (operator penggabungan)
- CONCAT()

🧪 Studi Kasus:
Gabungkan nama dan email untuk ditampilkan sebagai format kontak:

SELECT 
  first_name || ' ' || last_name || ' <' || email || '>' AS full_email
FROM customer;


🔡 2. Changing the Case of Text
✅ Inti:
- Mengubah huruf menjadi:
- Kapital semua (UPPER())
- Kecil semua (LOWER())
- Format Judul (INITCAP())

🧪 Studi Kasus:
Format nama kategori film ke huruf besar dan judul film ke Title Case:

SELECT 
  UPPER(c.name) || ': ' || INITCAP(f.title) AS film_category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id;


🔁 3. Replacing String Data
✅ Inti:
Mengganti karakter tertentu dalam string.

🛠️ Fungsi:
- REPLACE(string, 'yang_diganti', 'pengganti')

🧪 Studi Kasus:
Ganti spasi dengan underscore di judul film:

SELECT REPLACE(title, ' ', '_') AS formatted_title
FROM film;

📏 4. Determining the Length of Strings
✅ Inti:
Mengetahui berapa panjang string dalam karakter.

🛠️ Fungsi:
- LENGTH(string)

🧪 Studi Kasus:
Lihat panjang kolom deskripsi film:

SELECT title, LENGTH(description) AS desc_length
FROM film;


✂️ 5. Truncating Strings
✅ Inti:
Memotong teks agar tidak terlalu panjang (misalnya preview deskripsi).

🛠️ Fungsi:
- LEFT(string, n)
- SUBSTRING(string FROM x FOR y)

🧪 Studi Kasus:
Tampilkan hanya 50 karakter pertama dari deskripsi:

SELECT SUBSTRING(description, 1, 50) AS short_description
FROM film;



🔍 6. Extracting Substrings
✅ Inti:
Mengambil sebagian dari string berdasarkan posisi atau pola.

🛠️ Fungsi:
- SUBSTRING()
- POSITION()

🧪 Studi Kasus:
Ambil nama jalan dari kolom address (hilangkan nomor rumah):

SELECT SUBSTRING(address FROM POSITION(' ' IN address)+1) AS street_name
FROM address;



7. Combining Functions
✅ Inti:
Menggabungkan berbagai fungsi string untuk manipulasi kompleks.

🧪 Studi Kasus:
Pisahkan email menjadi username dan domain:

SELECT 
  LEFT(email, POSITION('@' IN email)-1) AS username,
  SUBSTRING(email FROM POSITION('@' IN email)+1) AS domain
FROM customer;



🔢 8. Padding Strings
✅ Inti:
Menambah karakter di kiri (LPAD) atau kanan (RPAD) string agar panjangnya sesuai.

🧪 Studi Kasus:
Gabungkan nama depan dan belakang dengan spasi tambahan:

SELECT RPAD(first_name, LENGTH(first_name)+1) || last_name AS full_name
FROM customer;


🧼 9. TRIM Function
✅ Inti:
Menghapus karakter (biasanya spasi) dari awal/akhir string.

🛠️ Fungsi:
- TRIM(), TRIM(BOTH FROM ...), TRIM(LEADING FROM ...), dll.

🧪 Studi Kasus:
Hapus spasi berlebih setelah memotong deskripsi:

SELECT TRIM(LEFT(description, 50)) AS cleaned_description
FROM film;


🧠 10. Putting It All Together
✅ Inti:
Menggabungkan beberapa teknik untuk hasil akhir yang rapi dan kontekstual.

🧪 Studi Kasus:
Tampilkan kategori film + judul, dan preview deskripsi yang tidak memotong kata di tengah:

SELECT 
  UPPER(c.name) || ': ' || f.title AS film_category,
  LEFT(description, 50 - POSITION(' ' IN REVERSE(LEFT(description, 50)))) AS safe_preview
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id;



📘 Tabel Ringkas: Parsing & Manipulating Text


| No | Konsep         | Fungsi Kunci                           | Contoh                             |
|----|----------------|----------------------------------------|------------------------------------|
| 1  | Concatenate    | `||`, `CONCAT()`                       | `first_name || ' ' || last_name`   |
| 2  | Ubah Huruf     | `UPPER()`, `LOWER()`, `INITCAP()`      | `INITCAP(title)`                   |
| 3  | Ganti Karakter | `REPLACE()`                            | `REPLACE(title, ' ', '_')`         |
| 4  | Hitung Panjang | `LENGTH()`                             | `LENGTH(description)`              |
| 5  | Potong String  | `LEFT()`, `SUBSTRING()`                | `LEFT(description, 50)`            |
| 6  | Ambil Substr   | `SUBSTRING()`, `POSITION()`            | `SUBSTRING(email FROM ... )`       |
| 7  | Gabung Fungsi  | Kombinasi `LEFT()`, `POSITION()`, dll  | `LEFT(email, POSITION(...) - 1)`   |
| 8  | Padding        | `LPAD()`, `RPAD()`                     | `LPAD('123', 5, '0')`              |
| 9  | Trim           | `TRIM()`                               | `TRIM('  hello  ')`                |
| 10 | Safe Truncate  | `REVERSE()`, `POSITION()`              | `LEFT(..., 50 - POS(...))`         |

