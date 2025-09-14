# Converting to 1NF -> memastikan setiap tabel punya kolom dengan nilai tunggal (atomic) 
# dan tidak ada pengulangan kolom.

-- Create a new table to hold the cars rented by customers
CREATE TABLE cust_rentals (
  customer_id INT NOT NULL,
  car_id VARCHAR(128) NULL,
  invoice_id VARCHAR(128) NULL
);

-- Drop two columns from customers table to satisfy 1NF
ALTER TABLE customers
DROP COLUMN cars_rented,
DROP COLUMN invoice_id;


########################
# Converting to 2NF = menghilangkan partial dependency dengan memecah tabel, supaya semua atribut non-key 
# bergantung penuh pada primary key.

-- Create a new table to satisfy 2NF
CREATE TABLE cars (
  car_id VARCHAR(256) NULL,
  model VARCHAR(128),
  manufacturer VARCHAR(128),
  type_car VARCHAR(128),
  condition VARCHAR(128),
  color VARCHAR(128)
);

-- Insert data into the new table
INSERT INTO cars
SELECT DISTINCT
  car_id,
  model,
  manufacturer,
  type_car,
  condition,
  color
FROM customer_rentals;

-- Drop columns in customer_rentals to satisfy 2NF
ALTER TABLE customer_rentals
DROP COLUMN model,
DROP COLUMN manufacturer, 
DROP COLUMN type_car,
DROP COLUMN condition,
DROP COLUMN color;


###########################
# Converting to 3NF ->  menghilangkan transitive dependency, 
# dengan memindahkan atribut yang bergantung pada non-key ke tabel baru.

-- Create a new table to satisfy 3NF
CREATE TABLE car_model(
  model VARCHAR(128),
  manufacturer VARCHAR(128),
  type_car VARCHAR(128)
);

-- Drop columns in rental_cars to satisfy 3NF
ALTER TABLE rental_cars
DROP COLUMN condition, 
DROP COLUMN color;