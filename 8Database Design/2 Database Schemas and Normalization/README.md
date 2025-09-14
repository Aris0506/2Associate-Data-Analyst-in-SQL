# 📘 Catatan Belajar Hari Ini

## 🔗 Adding Foreign Keys  
Foreign Key = kolom di suatu tabel yang dipakai untuk menghubungkan ke **Primary Key (PK)** di tabel lain.  

```sql
ALTER TABLE fact_booksales ADD CONSTRAINT sales_book
    FOREIGN KEY (book_id) REFERENCES dim_book_star (book_id);

ALTER TABLE fact_booksales ADD CONSTRAINT sales_time
    FOREIGN KEY (time_id) REFERENCES dim_time_star (time_id);

ALTER TABLE fact_booksales ADD CONSTRAINT sales_store
    FOREIGN KEY (store_id) REFERENCES dim_store_star (store_id);
```

---

## 📖 Extending the Book Dimension  
Menambahkan kolom/atribut baru ke tabel dimensi **Book** agar lebih kaya informasi.  

```sql
CREATE TABLE dim_author (
    author varchar(256)  NOT NULL
);

INSERT INTO dim_author
SELECT DISTINCT author FROM dim_book_star;

ALTER TABLE dim_author ADD COLUMN author_id SERIAL PRIMARY KEY;
```

---

## ⭐ Querying the Star Schema  
Menulis SQL query dengan tabel **fact + dimensi** (lebih sederhana, join langsung).  

```sql
SELECT dim_store_star.state, SUM(sales_amount)
FROM fact_booksales
JOIN dim_book_star ON fact_booksales.book_id = dim_book_star.book_id
JOIN dim_store_star ON fact_booksales.store_id = dim_store_star.store_id
WHERE dim_book_star.genre = 'novel'
GROUP BY dim_store_star.state;
```

---

## ❄ Querying the Snowflake Schema  
Query di snowflake schema → lebih banyak JOIN karena tabel dimensi dipecah.  

```sql
SELECT dim_state_sf.state, SUM(sales_amount)
FROM fact_booksales
JOIN dim_book_sf on fact_booksales.book_id = dim_book_sf.book_id
JOIN dim_genre_sf on dim_book_sf.genre_id = dim_genre_sf.genre_id
JOIN dim_store_sf on fact_booksales.store_id = dim_store_sf.store_id 
JOIN dim_city_sf on dim_store_sf.city_id = dim_city_sf.city_id
JOIN dim_state_sf on dim_city_sf.state_id = dim_state_sf.state_id
WHERE dim_genre_sf.genre = 'novel'
GROUP BY dim_state_sf.state;
```

---

## 🌍 Updating Countries  
Membersihkan data dimensi store berdasarkan country.  

```sql
SELECT * FROM dim_store_star
WHERE country != 'USA' AND country !='CA';
```

---

## ❄ Extending the Snowflake Schema  
Menambah level hierarki baru (misalnya **Continent**).  

```sql
ALTER TABLE dim_country_sf
ADD continent_id int NOT NULL DEFAULT(1);

ALTER TABLE dim_country_sf ADD CONSTRAINT country_continent
   FOREIGN KEY (continent_id) REFERENCES dim_continent_sf(continent_id);
```

---

## 🏗 Normal Forms  

### ✅ Converting to 1NF  
- Setiap kolom harus **atomic** (tidak multi-value).  
- Tidak ada kolom berulang.  

```sql
CREATE TABLE cust_rentals (
  customer_id INT NOT NULL,
  car_id VARCHAR(128) NULL,
  invoice_id VARCHAR(128) NULL
);

ALTER TABLE customers
DROP COLUMN cars_rented,
DROP COLUMN invoice_id;
```

---

### ✅ Converting to 2NF  
- Hilangkan **partial dependency** (non-key harus bergantung penuh pada PK).  

```sql
CREATE TABLE cars (
  car_id VARCHAR(256) NULL,
  model VARCHAR(128),
  manufacturer VARCHAR(128),
  type_car VARCHAR(128),
  condition VARCHAR(128),
  color VARCHAR(128)
);

INSERT INTO cars
SELECT DISTINCT
  car_id, model, manufacturer, type_car, condition, color
FROM customer_rentals;

ALTER TABLE customer_rentals
DROP COLUMN model,
DROP COLUMN manufacturer, 
DROP COLUMN type_car,
DROP COLUMN condition,
DROP COLUMN color;
```

---

### ✅ Converting to 3NF  
- Hilangkan **transitive dependency** (non-key tidak boleh bergantung ke non-key lain).  

```sql
CREATE TABLE car_model(
  model VARCHAR(128),
  manufacturer VARCHAR(128),
  type_car VARCHAR(128)
);

ALTER TABLE rental_cars
DROP COLUMN condition, 
DROP COLUMN color;
```

---

🎯 **Ringkasan hari ini:**  
Belajar tentang **Foreign Keys, Star & Snowflake Schema (query & extending), Updating data dimensi, serta Normal Forms (1NF, 2NF, 3NF)**.  
