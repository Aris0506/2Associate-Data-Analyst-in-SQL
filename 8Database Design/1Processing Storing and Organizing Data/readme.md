🔑 1. Storing Data
Cara menyimpan data di database dengan tipe data yang tepat (VARCHAR, INTEGER, FLOAT, dll).
Misalnya park_name pakai VARCHAR(160), distance_km pakai FLOAT.


🔑 2. Name that Data Type!
Menentukan tipe data yang sesuai untuk setiap kolom.
Contoh: year pakai INTEGER, bukan VARCHAR.


🔑 3. Ordering ETL Tasks
Belajar urutan dalam ETL (Extract, Transform, Load).
Extract → ambil data dari sumber.
Transform → bersihkan, normalisasi.
Load → masukkan ke database / data warehouse.


🔑 4. Recommend a Storage Solution
Memilih solusi penyimpanan:
OLTP database (untuk transaksi)
OLAP / Data warehouse (untuk analisis)
atau data lake (untuk raw data).


🔑 5. Database Design
Membuat dimensi dan fakta:
Dimensi = route, week.
Fakta = runs_fact (tempat menyimpan durasi lari, jarak, dsb).
Tujuannya supaya data analisis bisa lebih mudah (model star schema).


🔑 6. Classifying Data Models
Mengenal macam-macam data model:
Conceptual model → gambaran umum entitas & relasi.
Logical model → detail tabel, kolom, relasi.
Physical model → implementasi nyata di database.


🔑 7. Deciding Fact and Dimension Tables

Belajar bedain mana fact table (isi angka/measure → bisa dijumlahkan, dihitung rata-rata, dll) dan mana dimension table (isi deskripsi/konteks).

Contoh:
Fact → runs_fact (duration_mins).
Dimension → route, week.


🔑 8. Querying the Dimensional Model

Latihan query OLAP pakai fact & dimension:
SUM(duration_mins) → total durasi lari.
Join dengan week_dim → filter data berdasarkan bulan dan tahun.



📌 Kesimpulan

Hari ini belajar fondasi data engineering & data warehouse:

    Cara menyimpan data (storing).
    Menentukan tipe data.
    Urutan ETL.
    Pilih solusi penyimpanan.
    Database design (fact vs dimension).
    Classifying data models.
    Dan akhirnya menulis query analitik di atas model dimensional.