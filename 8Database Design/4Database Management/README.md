
# 📚 Database Management Notes

## 1. Database Roles & Access Control
- **Role** = wadah izin (ibarat jabatan).
- **Access Control** = aturan detail siapa boleh apa (hak & wewenang).

### Perintah penting:
```sql
-- Membuat role baru
CREATE ROLE data_scientist;

-- Membuat role dengan login
CREATE ROLE marta LOGIN;

-- Membuat admin role
CREATE ROLE admin WITH CREATEDB CREATEROLE;

-- Memberikan privileges
GRANT UPDATE, SELECT ON long_reviews TO data_scientist;

-- Mengubah atribut role (contoh: password)
ALTER ROLE marta WITH PASSWORD 's3cur3p@ssw0rd';

-- Menambahkan user ke dalam group role
GRANT data_scientist TO marta;

-- Menghapus user dari group role
REVOKE data_scientist FROM marta;
```

---

## 2. Table Partitioning
Memecah tabel besar menjadi bagian kecil (partisi).  
**Tujuan**: query lebih cepat, efisiensi, manajemen data lebih mudah.  
User tetap mengakses tabel seolah satu kesatuan.

### A. Vertical Partitioning
Membagi tabel berdasarkan kolom.
```sql
-- Membuat tabel khusus deskripsi film
CREATE TABLE film_descriptions (
    film_id INT,
    long_description TEXT
);

-- Menyalin data dari tabel film
INSERT INTO film_descriptions
SELECT film_id, long_description FROM film;

-- Join agar terlihat seperti tabel utuh
SELECT * FROM film
JOIN film_descriptions USING(film_id);
```

### B. Horizontal Partitioning
Membagi tabel berdasarkan baris (record).  
Bentuk umum: **Range, List, Hash, Composite**.

```sql
-- Membuat tabel partisi berdasarkan tahun rilis
CREATE TABLE film_partitioned (
  film_id INT,
  title TEXT NOT NULL,
  release_year TEXT
)
PARTITION BY LIST (release_year);

-- Membuat partisi berdasarkan tahun
CREATE TABLE film_2019 PARTITION OF film_partitioned FOR VALUES IN ('2019');
CREATE TABLE film_2018 PARTITION OF film_partitioned FOR VALUES IN ('2018');
CREATE TABLE film_2017 PARTITION OF film_partitioned FOR VALUES IN ('2017');

-- Insert data
INSERT INTO film_partitioned
SELECT film_id, title, release_year FROM film;

-- Melihat hasil
SELECT * FROM film_partitioned;
```

---

## 3. Data Integration
Proses **menggabungkan data dari berbagai sumber** (database, file, API, sistem aplikasi, dsb.) ke dalam satu sistem terpadu.  

### Tujuan:
- Single source of truth
- Efisiensi
- Kualitas data lebih baik
- Analisis lebih kaya

### Teknik umum:
- **ETL** (Extract, Transform, Load)
- **ELT** (Extract, Load, Transform)
- **Data Virtualization**
- **API-based Integration**

---

## 4. Picking a DBMS
Proses memilih **Database Management System** terbaik sesuai kebutuhan aplikasi/organisasi.

### Faktor penting:
- **Jenis data** → Relasional (MySQL, PostgreSQL) vs Non-relasional (MongoDB, Cassandra).
- **Skalabilitas & performa**
- **Biaya & lisensi** → open-source vs enterprise.
- **Kemudahan integrasi**
- **Keamanan & compliance**
- **Dukungan komunitas & vendor**

### Contoh:
- Startup kecil → PostgreSQL/MySQL
- Bank & enterprise → Oracle/SQL Server
- Big Data & IoT → MongoDB, Cassandra
- Analitik & AI → Snowflake, BigQuery

---

✍️ **Catatan ini dibuat sebagai ringkasan belajar tentang:**
- Roles & Access Control
- Table Partitioning
- Data Integration
- Picking a DBMS
