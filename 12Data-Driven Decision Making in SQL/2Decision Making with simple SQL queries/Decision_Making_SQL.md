
# Decision Making with Simple SQL Queries

## 🧠 Ringkasan Materi

### 1️⃣ Grouping & Aggregation
- `GROUP BY` → ngelompokkan data per kategori
- Fungsi agregasi:
  - `COUNT()` → jumlah data
  - `SUM()` → total nilai
  - `AVG()` → rata-rata
  - `MIN()` / `MAX()` → nilai ekstrem
📌 Contoh: *average rating per movie*, *first account per country*

---

### 2️⃣ Filtering Data
- `WHERE` → filter baris sebelum agregasi
- `HAVING` → filter hasil setelah agregasi
📌 Contoh: *hanya customer dengan >7 rentals*, *hanya aktor dengan >5 views*

---

### 3️⃣ Joining Tables
- Menggabungkan tabel biar informasi lengkap
- `LEFT JOIN` sering dipakai (tetap simpan semua data dari tabel utama)
- Best practice: `ON b.col = a.col` (tabel baru dulu → tabel lama)
📌 Contoh: *gabung renting + customers + movies* buat tahu revenue

---

### 4️⃣ Subqueries
- Query di dalam query → bikin tabel sementara
- Dipakai untuk:
  - Memfilter data dulu
  - Bikin perhitungan sebelum query utama
📌 Contoh: *income per movie* (pakai subquery harga sewa), *actors from USA*

---

### 5️⃣ KPI / Decision Making
Hasil akhirnya dipakai buat ambil insight:
- 🎬 Film terfavorit → `AVG(rating)` + `COUNT(*)`
- ⭐ Aktor terpopuler per negara → `GROUP BY actor, gender`
- 🌍 KPI per country → revenue, jumlah rentals, average rating
- 📊 Perbandingan tahun → filter dengan `WHERE date BETWEEN ...`

---

## 📊 Alur Analisis SQL
**Raw Data → Filtering (WHERE) → Grouping (GROUP BY) → Aggregation (SUM/AVG/COUNT) → Filtering lagi (HAVING) → Join (gabung tabel lain) → [Opsional: Subquery] → KPI / Insight untuk Decision Making**
