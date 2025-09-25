# 📌 Catatan SQL: Dates & Times

Kumpulan istilah penting saat bekerja dengan tanggal & waktu di SQL.

---

## 1. Working with Dates and Timestamps
Bekerja dengan tipe data tanggal (`DATE`) dan waktu (`TIMESTAMP`) di SQL.

## 2. Date/Time Types and Formats
Jenis & format data waktu, misalnya:
- `DATE`: hanya tanggal (YYYY-MM-DD)
- `TIME`: hanya jam (HH:MM:SS)
- `TIMESTAMP`: tanggal + jam
- `INTERVAL`: selisih waktu

## 3. Date Comparisons
Membandingkan tanggal/waktu di SQL, contoh:
```sql
WHERE order_date > '2024-01-01'
```

## 4. Date Arithmetic
Operasi hitung tanggal, contoh:
```sql
order_date + INTERVAL '7 days'
```

## 5. Completion Time by Category
Mengukur lama waktu penyelesaian tiap kategori, biasanya dengan `DATEDIFF`.

## 6. Date/Time Components and Aggregation
Mengambil bagian waktu tertentu lalu agregasi:
```sql
SELECT EXTRACT(MONTH FROM order_date), COUNT(*)
```

## 7. Date Parts
Bagian-bagian dari tanggal/waktu (`YEAR`, `MONTH`, `DAY`, `HOUR`).

## 8. Variation by Day of Week
Analisis data berdasarkan hari dalam seminggu (`EXTRACT(DOW)` atau `DAYNAME`).

## 9. Date Truncation
Memotong timestamp ke unit waktu tertentu, contoh:
```sql
DATE_TRUNC('month', order_date)
```

## 10. Aggregating with Date/Time Series
Membuat deret tanggal untuk agregasi (misal tren bulanan).

## 11. Find Missing Dates
Mencari tanggal yang tidak muncul dalam data (pakai deret tanggal + LEFT JOIN).

## 12. Monthly Average with Missing Dates
Hitung rata-rata bulanan meski ada bulan kosong (isi gap dengan `0` atau `NULL`).

## 13. Time Between Events
Menghitung selisih waktu antar peristiwa, contoh:
```sql
LEAD(order_date) OVER (ORDER BY order_date) - order_date
```

## 14. Longest Gap
Mencari jarak waktu terpanjang antar peristiwa.

## 15. "Rats!"
Ekspresi bahasa Inggris untuk kecewa/frustrasi ringan.  
Mirip dengan "Aduh!", "Sial!", "Yah gagal!".
