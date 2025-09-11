🗒️ Catatan Belajar PostgreSQL: Manipulasi Data Tanggal & Waktu

🧠 Tujuan Pembelajaran
Memahami cara kerja fungsi dan operator DATE/TIME di PostgreSQL untuk:

- Menghitung durasi
- Menambah atau mengurangi waktu
- Mengelompokkan data berdasarkan waktu
- Mengekstrak informasi dari tanggal
- Menganalisis data terkait waktu (seperti keterlambatan pengembalian)

1️⃣ Menghitung Selisih Tanggal
🔹 Menggunakan Operator Pengurangan -
r.return_date - r.rental_date AS days_rented

📌 Menghasilkan jumlah hari antara dua tanggal.

🔹 Menggunakan Fungsi AGE()
AGE(r.return_date, r.rental_date) AS days_rented

📌 Menghasilkan selisih waktu dalam format lengkap (x years y mons z days).


2️⃣ INTERVAL: Representasi Durasi Waktu
🔹 Membuat interval dari jumlah hari:
INTERVAL '1' day * f.rental_duration

📌 Digunakan untuk menyatakan "berapa lama sesuatu berlangsung".

🔹 Menambahkan interval ke tanggal:
r.rental_date + INTERVAL '1' day * f.rental_duration AS expected_return_date

📌 Untuk menghitung kapan sesuatu seharusnya berakhir.


3️⃣ Mengambil Tanggal dan Waktu Saat Ini
🔹 Fungsi yang digunakan:
CURRENT_DATE              -- hanya tanggal
NOW()                     -- timestamp lengkap
CAST(NOW() AS DATE)       -- konversi timestamp ke tanggal

📌 Penting untuk operasi yang bergantung pada "hari ini".

🔹 Menambahkan waktu ke waktu sekarang:
interval '5 days' + CURRENT_TIMESTAMP(0)

📌 Contoh manipulasi waktu ke masa depan atau masa lalu.


4️⃣ Mengekstrak Bagian dari Tanggal: EXTRACT()
EXTRACT(dow FROM rental_date) AS dayofweek

📌 Mengambil informasi spesifik, seperti:

dow = day of week (0 = Minggu, 1 = Senin, ...)

🧠 Penting untuk analisis pola waktu (misal: hari tersibuk).


5️⃣ Membulatkan Tanggal: DATE_TRUNC()
🔹 Format:
DATE_TRUNC('year', rental_date)
DATE_TRUNC('month', rental_date)
DATE_TRUNC('day', rental_date)

📌 Menghapus informasi waktu lebih kecil dari yang ditentukan (misalnya, jam/menit/detik jika dibulatkan ke 'day').

🧠 Sangat berguna untuk grouping by time (per bulan, per tahun, dll).


6️⃣ Aplikasi Nyata: Cek Keterlambatan Pengembalian
🔹 Menggabungkan konsep:
CASE 
  WHEN DATE_TRUNC('day', AGE(r.return_date, r.rental_date)) >
       f.rental_duration * INTERVAL '1' day 
  THEN TRUE 
  ELSE FALSE 
END AS past_due


📌 Mengecek apakah durasi sewa melebihi batas waktu yang diizinkan.

🧠 Menunjukkan kekuatan kombinasi antara AGE(), INTERVAL, dan DATE_TRUNC().


🧩 Inti Pemahaman:
| Konsep                  | Inti Pemahaman                                                        |
| ----------------------- | --------------------------------------------------------------------- |
| `CURRENT_DATE`          | Mengambil tanggal hari ini, tanpa jam                                 |
| `NOW()`                 | Mengambil timestamp lengkap saat ini                                  |
| `AGE()`                 | Menghitung selisih dua tanggal dalam format lengkap                   |
| `INTERVAL`              | Representasi durasi waktu (seperti '5 days', '2 hours')               |
| `+`, `-` dengan tanggal | Menambahkan atau mengurangi tanggal dengan interval                   |
| `EXTRACT()`             | Mengambil bagian spesifik dari tanggal (tahun, bulan, hari, dow, dll) |
| `DATE_TRUNC()`          | Membulatkan tanggal ke unit waktu tertentu (hari, bulan, tahun, dll)  |
| `CAST()`                | Mengubah satu tipe data ke tipe lain (misalnya timestamp → date)      |
| `CASE WHEN` + tanggal   | Logika kondisi berbasis waktu (misal: keterlambatan, durasi maksimum) |



📘 Contoh Studi Kasus yang Dikuasai:

- Menghitung berapa hari film disewa
- Menentukan tanggal pengembalian seharusnya
- Menganalisis jumlah sewa berdasarkan hari
- Membuat sistem deteksi keterlambatan otomatis
- Mengelompokkan data rental berdasarkan bulan/tahun