# 📘 Database Views & Materialized Views

## 1. Views
**View** adalah objek database berupa tabel virtual yang dibentuk dari hasil query `SELECT`.  
View tidak menyimpan data secara fisik, hanya menyimpan definisi query.

### 🔹 Membuat View
```sql
CREATE VIEW view_name AS
SELECT column1, column2
FROM table_name
WHERE condition;
```

### 🔹 Querying View
```sql
SELECT * FROM view_name;
```

### 🔹 Managing Views
- **Menghapus view**  
  ```sql
  DROP VIEW view_name;
  ```

- **Redefining a view** (mengubah definisi query):  
  - MySQL / PostgreSQL:
    ```sql
    CREATE OR REPLACE VIEW view_name AS
    SELECT ...
    FROM ...
    WHERE ...;
    ```
  - SQL Server:
    ```sql
    ALTER VIEW view_name AS
    SELECT ...
    FROM ...
    WHERE ...;
    ```

### 🔹 Creating a View from Another View
```sql
CREATE VIEW new_view AS
SELECT column1, column2
FROM existing_view
WHERE condition;
```

### 🔹 Granting & Revoking Access
```sql
GRANT SELECT ON view_name TO username;
REVOKE SELECT ON view_name FROM username;
```

### 🔹 Updatable Views
Beberapa view bisa di-*update* (INSERT, UPDATE, DELETE) jika:
- View hanya berasal dari **satu tabel**.
- Tidak ada fungsi agregasi (`SUM`, `COUNT`, dll).
- Tidak ada `DISTINCT`, `GROUP BY`, atau `JOIN` yang kompleks.

---

## 2. Materialized Views
**Materialized View** adalah view yang menyimpan data hasil query secara fisik di database.  
Berbeda dengan view biasa yang hanya virtual, materialized view **perlu di-refresh** agar datanya tetap up-to-date.

### 🔹 Membuat Materialized View
```sql
CREATE MATERIALIZED VIEW mv_sales_summary AS
SELECT product_id, SUM(amount) AS total_sales
FROM sales
GROUP BY product_id;
```

### 🔹 Refresh Materialized View
- **Manual Refresh**
  ```sql
  REFRESH MATERIALIZED VIEW mv_sales_summary;
  ```

- **Dengan opsi refresh (Oracle / PostgreSQL)**
  ```sql
  CREATE MATERIALIZED VIEW mv_sales_summary
  BUILD IMMEDIATE
  REFRESH FAST
  ON DEMAND
  AS
  SELECT product_id, SUM(amount) AS total_sales
  FROM sales
  GROUP BY product_id;
  ```

  - `BUILD IMMEDIATE` → langsung buat dan isi data.  
  - `REFRESH FAST` → hanya update data yang berubah (lebih cepat).  
  - `ON DEMAND` → refresh dilakukan manual.  
  - `ON COMMIT` → refresh otomatis setiap ada commit transaksi.  

---

## ✨ Perbedaan View vs Materialized View
| Fitur            | View                          | Materialized View |
|-------           |------                         |-------------------|
| Penyimpanan data | Tidak menyimpan data          | Menyimpan data fisik |
| Performa query   | Bergantung query asli         | Lebih cepat karena sudah disimpan |
| Update data      | Selalu up-to-date (real-time) | Perlu refresh agar up-to-date |
| Kegunaan         | Query dinamis                 | Analisis data besar & agregasi |
