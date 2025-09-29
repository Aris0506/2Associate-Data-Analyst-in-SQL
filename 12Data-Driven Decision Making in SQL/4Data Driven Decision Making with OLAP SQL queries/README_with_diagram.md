# 📊 OLAP dengan SQL (CUBE, ROLLUP, GROUPING SETS)

Catatan ringkas untuk pengingat konsep **Data Driven Decision Making** dengan SQL OLAP extensions.

---

## 1. OLAP (Online Analytical Processing)
- Digunakan untuk **analisis multidimensi** (pivot table style).
- Cocok untuk agregasi (SUM, AVG, COUNT, dll) berdasarkan beberapa dimensi.
- SQL menyediakan extension:
  - `CUBE`
  - `ROLLUP`
  - `GROUPING SETS`

---

## 2. CUBE
- Menghasilkan **semua kombinasi** agregasi dari kolom yang dipilih.
- Mirip dengan pivot table penuh.

```sql
SELECT 
  c.country, 
  m.genre, 
  AVG(r.rating) AS avg_rating
FROM renting r
LEFT JOIN movies m ON r.movie_id = m.movie_id
LEFT JOIN customers c ON r.customer_id = c.customer_id
GROUP BY CUBE (c.country, m.genre);
```

### 🔎 Contoh hasil (simulasi)
| country  | genre     | avg_rating |
|----------|-----------|------------|
| USA      | Action    | 4.1        |
| USA      | Comedy    | 3.8        |
| USA      | NULL      | 3.95       |
| Japan    | Action    | 4.3        |
| Japan    | Comedy    | 4.0        |
| Japan    | NULL      | 4.15       |
| NULL     | Action    | 4.2        |
| NULL     | Comedy    | 3.9        |
| NULL     | NULL      | 4.05 (Grand Total) |

### 📈 Diagram CUBE
```
(c.country, m.genre)
       /        |        \
 country      genre     ( )
```

---

## 3. ROLLUP
- Menghasilkan **agregasi hierarkis (drill down)**.
- Urutan kolom penting → semakin ke kanan, semakin detail.

```sql
SELECT 
  c.country,
  m.genre,
  AVG(r.rating) AS avg_rating
FROM renting r
LEFT JOIN movies m ON r.movie_id = m.movie_id
LEFT JOIN customers c ON r.customer_id = c.customer_id
GROUP BY ROLLUP (c.country, m.genre);
```

### 🔎 Contoh hasil (simulasi)
| country  | genre     | avg_rating |
|----------|-----------|------------|
| USA      | Action    | 4.1        |
| USA      | Comedy    | 3.8        |
| USA      | NULL      | 3.95       |
| Japan    | Action    | 4.3        |
| Japan    | Comedy    | 4.0        |
| Japan    | NULL      | 4.15       |
| NULL     | NULL      | 4.05 (Grand Total) |

### 📈 Diagram ROLLUP
```
(c.country, m.genre)
       ↓
   (c.country)
       ↓
      ( )
```

⚠️ Tidak menghasilkan `(genre)` saja (beda dengan `CUBE`).

---

## 4. GROUPING SETS
- Menentukan **kombinasi grouping spesifik** (lebih fleksibel).
- Bisa pilih sendiri subset yang ingin ditampilkan.

```sql
SELECT 
  c.country, 
  c.gender,
  AVG(r.rating) AS avg_rating
FROM renting r
LEFT JOIN customers c ON r.customer_id = c.customer_id
GROUP BY GROUPING SETS ((c.country, c.gender), (c.country), (c.gender), ());
```

### 🔎 Contoh hasil (simulasi)
| country  | gender | avg_rating |
|----------|--------|------------|
| USA      | Male   | 4.0        |
| USA      | Female | 3.9        |
| USA      | NULL   | 3.95       |
| Japan    | Male   | 4.2        |
| Japan    | Female | 4.1        |
| Japan    | NULL   | 4.15       |
| NULL     | Male   | 4.1        |
| NULL     | Female | 4.0        |
| NULL     | NULL   | 4.05 (Grand Total) |

### 📈 Diagram GROUPING SETS
```
{ (c.country, c.gender), (c.country), (c.gender), ( ) }
```

---

## 5. Perbedaan Utama
| Operator       | Kombinasi Agregasi                           |
|----------------|-----------------------------------------------|
| **CUBE**       | Semua kombinasi kolom (lengkap seperti pivot) |
| **ROLLUP**     | Hierarki (drill-down) sesuai urutan kolom     |
| **GROUPING SETS** | Fleksibel, pilih kombinasi manual             |

---

## 6. Catatan Tambahan
- `NULL` pada hasil biasanya menandakan level agregasi lebih tinggi (contoh: NULL di `genre` berarti total per negara).
- `GROUPING()` function bisa dipakai untuk membedakan `NULL asli` dengan `NULL hasil agregasi`.
- Grand Total ditampilkan sebagai `()` (kosong).

---
