---🔑 KEY:
---Table partitioning = memecah tabel besar jadi bagian kecil (partisi).
---Tujuan = query lebih cepat, pengelolaan data lebih mudah.
---User tetap akses tabel seolah satu kesatuan.


# Creating vertical partitions -> membagi tabel berdasarkan kolom. Tujuan = efisiensi query, storage, dan keamanan.
# Lawannya → horizontal partitioning (berdasarkan baris).

-- Create a new table called film_descriptions
CREATE TABLE film_descriptions (
    film_id INT,
    long_description TEXT
);

-- Copy the descriptions from the film table
INSERT INTO film_descriptions
SELECT film_id, long_description FROM film;
    
-- Drop the descriptions from the original table
DROP TABLE film_descriptions;
########
-- Join to view the original table
CREATE TABLE film_descriptions (
    film_id INT,
    long_description TEXT
);

INSERT INTO film_descriptions
SELECT film_id, long_description FROM film;

SELECT * FROM film 
JOIN film_descriptions USING(film_id);


###################
# Creating horizontal partitions -> memecah tabel besar berdasarkan baris (records). 
# Tujuan = performa, efisiensi, manajemen lebih mudah. Bentuk umum: Range, List, Hash, Composite.

-- Create a new table called film_partitioned
CREATE TABLE film_partitioned (
  film_id INT,
  title TEXT NOT NULL,
  release_year TEXT
)
PARTITION BY LIST (release_year);

-- Create the partitions for 2019, 2018, and 2017
CREATE TABLE film_2019
	PARTITION OF film_partitioned FOR VALUES IN ('2019');

CREATE TABLE film_2018
	PARTITION OF film_partitioned FOR VALUES IN ('2018');

CREATE TABLE film_2017
	PARTITION OF film_partitioned FOR VALUES IN ('2017');

-- Insert the data into film_partitioned
INSERT INTO film_partitioned
SELECT film_id, title, release_year FROM film;

-- View film_partitioned
SELECT * FROM film_partitioned;



